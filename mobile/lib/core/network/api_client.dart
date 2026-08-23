import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../storage/secure_storage.dart';

/// Base URL — should come from a build-time/environment config in a real
/// build (e.g. --dart-define), not hard-coded, per 5.4 FR-BE-017's
/// credential/config isolation principle applied client-side too.
const _kBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:3000', // Android emulator loopback to localhost
);

/// The single dio instance used by every feature's remote datasource.
/// Implements 5.6 AD-MOB-003's rationale: interceptors are what make
/// IAPI's conventions (auth header, refresh-on-401, request ID) work
/// once, everywhere, rather than being repeated at each call site.
class ApiClient {
  ApiClient._internal() {
    _dio = Dio(BaseOptions(baseUrl: '$_kBaseUrl/v1', connectTimeout: const Duration(seconds: 15)));
    _dio.interceptors.add(_RequestIdInterceptor());
    _dio.interceptors.add(_AuthInterceptor(_dio));
  }

  static final ApiClient instance = ApiClient._internal();
  late final Dio _dio;

  Dio get dio => _dio;
}

/// IAPI FR-IAPI-032 — every request carries a correlation ID, generated
/// client-side if not already present, so a field user's bug report can
/// be traced end-to-end through backend logs (per IAPI §19's scenario).
class _RequestIdInterceptor extends Interceptor {
  final _uuid = const Uuid();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Request-Id'] = _uuid.v4();
    handler.next(options);
  }
}

/// IAPI FR-IAPI-010 — attaches the access token to every request, and
/// transparently refreshes it on a 401 before retrying the original
/// request once. If the refresh itself fails, the caller propagates the
/// failure up to the auth provider, which should route back to login.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._dio);
  final Dio _dio;
  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.instance.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthenticated = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['retried'] == true;

    if (!isUnauthenticated || alreadyRetried || _isRefreshing) {
      handler.next(err);
      return;
    }

    _isRefreshing = true;
    try {
      final refreshToken = await SecureStorage.instance.refreshToken;
      if (refreshToken == null) {
        handler.next(err);
        return;
      }

      final response = await _dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
      final data = response.data['data'] as Map<String, dynamic>;
      await SecureStorage.instance.saveTokens(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
      );

      final retryOptions = err.requestOptions;
      retryOptions.extra['retried'] = true;
      retryOptions.headers['Authorization'] = 'Bearer ${data['access_token']}';
      final retryResponse = await _dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      // Refresh itself failed — the caller (auth provider) should treat
      // this as a full logout requiring re-authentication.
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../network/api_client.dart';
import '../storage/secure_storage.dart';
import '../database/app_database.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController();
});

/// Handles login/logout and exposes the authenticated user's roles,
/// permissions and scope for 5.6 FR-MOB-003's role-based navigation
/// and FR-MOB-004's feature-flag/permission-gated UI elements.
class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState.unknown()) {
    _restoreSession();
  }

  final _dio = ApiClient.instance.dio;

  Future<void> _restoreSession() async {
    final token = await SecureStorage.instance.accessToken;
    if (token == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    await _loadCurrentUser();
  }

  Future<void> login(String username, String password) async {
    final deviceId = await SecureStorage.instance.ensureDeviceId(() => const Uuid().v4());

    final response = await _dio.post('/auth/login', data: {
      'username': username,
      'password': password,
      'device_id': deviceId,
    });

    final data = response.data['data'] as Map<String, dynamic>;
    await SecureStorage.instance.saveTokens(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );

    await _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final response = await _dio.get('/auth/me');
    final data = response.data['data'] as Map<String, dynamic>;
    final scope = data['scope'] as Map<String, dynamic>?;

    state = AuthState(
      status: AuthStatus.authenticated,
      username: data['username'] as String,
      roles: (data['roles'] as List).cast<String>(),
      permissions: (data['permissions'] as List).cast<String>(),
      scopeDistrict: scope?['district'] as String?,
    );
  }

  /// OSDS FR-OSDS-039 — logout clears both server-side tokens and all
  /// locally cached data, not just the in-memory auth state.
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {
      // Best-effort — proceed with local cleanup even if the request
      // itself fails (e.g. already offline).
    }
    await SecureStorage.instance.clearTokens();
    await AppDatabase.instance.wipeAllLocalData();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

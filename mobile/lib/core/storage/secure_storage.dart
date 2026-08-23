import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wraps [FlutterSecureStorage] for auth tokens and other small sensitive
/// values — 5.6 AD-MOB-005 / OSDS FR-OSDS-038. Never use SharedPreferences
/// for this data; secure storage uses the platform keychain/keystore.
class SecureStorage {
  SecureStorage._();
  static final SecureStorage instance = SecureStorage._();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _deviceIdKey = 'device_id';

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> get accessToken => _storage.read(key: _accessTokenKey);
  Future<String?> get refreshToken => _storage.read(key: _refreshTokenKey);

  /// A stable per-install device identifier used for IAPI's device
  /// registration (IAPI FR-IAPI-011). Generated once and persisted.
  Future<String> ensureDeviceId(String Function() generator) async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing != null) return existing;
    final generated = generator();
    await _storage.write(key: _deviceIdKey, value: generated);
    return generated;
  }

  /// OSDS FR-OSDS-039 — clear local credentials on logout/deregistration.
  /// Clearing cached DATA (not just credentials) is the local database's
  /// responsibility (see AppDatabase.wipeAllLocalData), called alongside
  /// this from the logout flow.
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}

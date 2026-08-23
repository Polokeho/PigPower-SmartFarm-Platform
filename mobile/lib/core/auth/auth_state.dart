import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.roles = const [],
    this.permissions = const [],
    this.scopeDistrict,
    this.username,
  });

  const AuthState.unknown() : this(status: AuthStatus.unknown);

  final AuthStatus status;
  final List<String> roles;
  final List<String> permissions;
  final String? scopeDistrict;
  final String? username;

  bool hasPermission(String permission) => permissions.contains(permission);

  AuthState copyWith({
    AuthStatus? status,
    List<String>? roles,
    List<String>? permissions,
    String? scopeDistrict,
    String? username,
  }) {
    return AuthState(
      status: status ?? this.status,
      roles: roles ?? this.roles,
      permissions: permissions ?? this.permissions,
      scopeDistrict: scopeDistrict ?? this.scopeDistrict,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [status, roles, permissions, scopeDistrict, username];
}

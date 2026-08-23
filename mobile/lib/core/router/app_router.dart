import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import '../auth/auth_state.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/farmer/presentation/screens/farmer_list_screen.dart';
import '../../features/farmer/presentation/screens/farmer_create_screen.dart';
import '../../features/production/presentation/screens/production_list_screen.dart';
import '../../features/production/presentation/screens/production_capture_screen.dart';
import '../../features/veterinary/presentation/screens/veterinary_list_screen.dart';
import '../../features/veterinary/presentation/screens/veterinary_capture_screen.dart';

/// Declarative routing with role/auth-based redirect guards — 5.6
/// AD-MOB-004. Screen-level permission checks (e.g. hiding a dashboard
/// tile) happen in the widgets themselves (FR-MOB-003); this router's
/// job is the coarser "are you even allowed past the login screen" gate.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: _AuthStateListenable(ref),
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (authState.status == AuthStatus.unknown) {
        return null; // still restoring session — stay put, splash/loading is handled by the root widget
      }
      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
      GoRoute(
        path: '/farmers',
        builder: (context, state) => const FarmerListScreen(),
        routes: [
          GoRoute(path: 'new', builder: (context, state) => const FarmerCreateScreen()),
        ],
      ),
      GoRoute(
        path: '/production',
        builder: (context, state) => const ProductionListScreen(),
        routes: [
          GoRoute(path: 'new', builder: (context, state) => const ProductionCaptureScreen()),
        ],
      ),
      GoRoute(
        path: '/veterinary',
        builder: (context, state) => const VeterinaryListScreen(),
        routes: [
          GoRoute(path: 'new', builder: (context, state) => const VeterinaryCaptureScreen()),
        ],
      ),
    ],
  );
});

/// Bridges Riverpod's authProvider changes into go_router's
/// refreshListenable, so a login/logout immediately re-evaluates
/// the redirect logic above.
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
  }
}

import 'package:core/src/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Provider do roteador principal.
/// Definido manualmente (sem codegen) para evitar dependência de
/// riverpod_generator no pacote core.
final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const _PlaceholderPage(title: 'Login'),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const _PlaceholderPage(title: 'Home'),
      ),
      GoRoute(
        path: AppRoutes.addPlace,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Add Place'),
      ),
      GoRoute(
        path: AppRoutes.placeDetail,
        builder: (context, state) => const _PlaceholderPage(title: 'Place'),
      ),
      GoRoute(
        path: AppRoutes.groupDetail,
        builder: (context, state) => const _PlaceholderPage(title: 'Group'),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Settings'),
      ),
    ],
  ),
);

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title)),
  );
}

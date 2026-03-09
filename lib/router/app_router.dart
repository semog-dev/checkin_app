import 'package:checkin_app/features/auth/presentation/pages/home_page.dart';
import 'package:checkin_app/features/auth/presentation/pages/login_page.dart';
import 'package:checkin_app/features/auth/presentation/pages/register_page.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/group/presentation/pages/create_group_page.dart';
import 'package:checkin_app/features/group/presentation/pages/group_detail_page.dart';
import 'package:checkin_app/features/group/presentation/pages/groups_page.dart';
import 'package:checkin_app/features/group/presentation/pages/join_group_page.dart';
import 'package:checkin_app/features/places/presentation/pages/add_place_page.dart';
import 'package:checkin_app/features/places/presentation/pages/place_detail_page.dart';
import 'package:checkin_app/features/places/presentation/pages/places_page.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const _SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.places,
        builder: (_, __) => const PlacesPage(),
      ),
      GoRoute(
        path: AppRoutes.addPlace,
        builder: (_, __) => const AddPlacePage(),
      ),
      GoRoute(
        path: AppRoutes.placeDetail,
        builder: (_, state) => PlaceDetailPage(
          placeId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.groups,
        builder: (_, __) => const GroupsPage(),
      ),
      GoRoute(
        path: AppRoutes.createGroup,
        builder: (_, __) => const CreateGroupPage(),
      ),
      GoRoute(
        path: AppRoutes.joinGroup,
        builder: (_, __) => const JoinGroupPage(),
      ),
      GoRoute(
        path: AppRoutes.groupDetail,
        builder: (_, state) => GroupDetailPage(
          groupId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, __) => const _PlaceholderPage(title: 'Settings'),
      ),
    ],
  );
});

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen<AuthState>(authNotifierProvider, (_, next) {
      _authState = next;
      notifyListeners();
    });
    _authState = ref.read(authNotifierProvider);
  }

  late AuthState _authState;

  String? redirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;
    final isSplash = location == AppRoutes.splash;
    final isLogin = location == AppRoutes.login;

    return _authState.when(
      initial: () => null,
      authenticated: (_) => (isSplash || isLogin) ? AppRoutes.home : null,
      unauthenticated: () => isSplash ? AppRoutes.login : null,
      error: (_) => isSplash ? AppRoutes.login : null,
    );
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
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

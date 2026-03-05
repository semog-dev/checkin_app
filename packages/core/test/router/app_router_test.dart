import 'package:core/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('appRouterProvider', () {
    test('é um Provider<GoRouter>', () {
      expect(appRouterProvider, isA<Provider<GoRouter>>());
    });

    testWidgets('fornece uma instância de GoRouter', (tester) async {
      late GoRouter router;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, _) {
              router = ref.watch(appRouterProvider);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(router, isA<GoRouter>());
    });

    testWidgets('GoRouter monta SplashPage na rota inicial', (tester) async {
      late GoRouter router;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, _) {
              router = ref.watch(appRouterProvider);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pump();

      // Splash exibe CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('GoRouter navega para login sem exceção', (tester) async {
      late GoRouter router;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, _) {
              router = ref.watch(appRouterProvider);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pump();
      router.go('/login');
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Login'), findsWidgets);
    });

    testWidgets('GoRouter navega para home sem exceção', (tester) async {
      late GoRouter router;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, _) {
              router = ref.watch(appRouterProvider);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pump();
      router.go('/home');
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Home'), findsWidgets);
    });

    testWidgets('GoRouter navega para settings sem exceção', (tester) async {
      late GoRouter router;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, _) {
              router = ref.watch(appRouterProvider);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pump();
      router.go('/settings');
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Settings'), findsWidgets);
    });
  });
}

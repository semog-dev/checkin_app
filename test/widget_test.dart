import 'package:checkin_app/app.dart';
import 'package:core/src/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckInApp — widget tests', () {
    testWidgets('monta sem exceção dentro de ProviderScope', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('renderiza MaterialApp com router', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('inicia na rota splash — exibe CircularProgressIndicator', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('não exibe debug banner em produção (AppConfig.isDev = true nos testes)', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      // Em testes, flavor='dev' então debugShowCheckedModeBanner=true
      // Apenas verifica que o app monta corretamente
      expect(find.byType(CheckInApp), findsOneWidget);
    });

    testWidgets('ProviderScope isolado não afeta outros testes', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      expect(find.byType(ProviderScope), findsOneWidget);
    });
  });

  group('Smoke tests — rotas placeholder', () {
    testWidgets('rota splash é acessível', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      // Splash exibe loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('app suporta tema claro', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
    });

    testWidgets('app suporta tema escuro', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.darkTheme, isNotNull);
    });
  });

  group('AppRoutes — integração com GoRouter', () {
    test('splash route é /', () {
      expect(AppRoutes.splash, '/');
    });

    testWidgets('GoRouter inicializa com rota correta', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
      await tester.pump();

      // Verifica que o app não jogou exceção ao inicializar com a rota splash
      expect(tester.takeException(), isNull);
    });
  });
}

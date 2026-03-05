import 'package:core/src/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig', () {
    group('valores padrão (sem dart-define)', () {
      test('flavor padrão é dev', () {
        expect(AppConfig.flavor, 'dev');
      });

      test('appName padrão é CheckIn Dev', () {
        expect(AppConfig.appName, 'CheckIn Dev');
      });

      test('apiBaseUrl padrão aponta para localhost', () {
        expect(AppConfig.apiBaseUrl, 'http://localhost:3000');
      });

      test('wsUrl padrão aponta para localhost', () {
        expect(AppConfig.wsUrl, 'ws://localhost:3000');
      });

      test('mapsApiKey padrão é string vazia', () {
        expect(AppConfig.mapsApiKey, isEmpty);
      });
    });

    group('feature flags padrão', () {
      test('mockLocation está desligado por padrão', () {
        expect(AppConfig.mockLocation, isFalse);
      });

      test('showDebugOverlay está desligado por padrão', () {
        expect(AppConfig.showDebugOverlay, isFalse);
      });

      test('useLocalNotifications está desligado por padrão', () {
        expect(AppConfig.useLocalNotifications, isFalse);
      });
    });

    group('detecção de ambiente', () {
      test('isDev retorna true quando flavor é dev (padrão nos testes)', () {
        expect(AppConfig.isDev, isTrue);
      });

      test('isStaging retorna false quando flavor é dev', () {
        expect(AppConfig.isStaging, isFalse);
      });

      test('isProd retorna false quando flavor é dev', () {
        expect(AppConfig.isProd, isFalse);
      });

      test('apenas um ambiente está ativo por vez', () {
        final activeCount = [
          AppConfig.isDev,
          AppConfig.isStaging,
          AppConfig.isProd,
        ].where((b) => b).length;

        expect(activeCount, 1);
      });
    });

    group('consistência dos valores', () {
      test('apiBaseUrl é uma URL válida (começa com http)', () {
        expect(
          AppConfig.apiBaseUrl,
          anyOf(startsWith('http://'), startsWith('https://')),
        );
      });

      test('wsUrl é uma URL WebSocket válida (começa com ws)', () {
        expect(
          AppConfig.wsUrl,
          anyOf(startsWith('ws://'), startsWith('wss://')),
        );
      });

      test('flavor não é string vazia', () {
        expect(AppConfig.flavor, isNotEmpty);
      });

      test('appName não é string vazia', () {
        expect(AppConfig.appName, isNotEmpty);
      });
    });
  });
}

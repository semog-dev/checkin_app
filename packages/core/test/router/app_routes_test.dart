import 'package:core/src/router/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRoutes', () {
    group('constantes de rota', () {
      test('splash é a rota raiz', () {
        expect(AppRoutes.splash, '/');
      });

      test('login', () {
        expect(AppRoutes.login, '/login');
      });

      test('home', () {
        expect(AppRoutes.home, '/home');
      });

      test('placeDetail contém parâmetro :id', () {
        expect(AppRoutes.placeDetail, contains(':id'));
      });

      test('addPlace', () {
        expect(AppRoutes.addPlace, '/places/add');
      });

      test('groupDetail contém parâmetro :id', () {
        expect(AppRoutes.groupDetail, contains(':id'));
      });

      test('groupMemberHistory contém parâmetros :groupId e :memberId', () {
        expect(AppRoutes.groupMemberHistory, contains(':groupId'));
        expect(AppRoutes.groupMemberHistory, contains(':memberId'));
      });

      test('settings', () {
        expect(AppRoutes.settings, '/settings');
      });
    });

    group('groupMemberHistoryPath', () {
      test('monta caminho com groupId e memberId', () {
        expect(
          AppRoutes.groupMemberHistoryPath('g1', 'u1'),
          '/groups/g1/member/u1',
        );
      });

      test('monta caminho com ids distintos', () {
        expect(
          AppRoutes.groupMemberHistoryPath('grupo-abc', 'user-xyz'),
          '/groups/grupo-abc/member/user-xyz',
        );
      });

      test('caminho gerado começa com /', () {
        final path = AppRoutes.groupMemberHistoryPath('g1', 'u1');
        expect(path, startsWith('/'));
      });
    });

    group('formato das rotas', () {
      test('todas as rotas começam com /', () {
        final routes = [
          AppRoutes.splash,
          AppRoutes.login,
          AppRoutes.home,
          AppRoutes.placeDetail,
          AppRoutes.addPlace,
          AppRoutes.groupDetail,
          AppRoutes.groupMemberHistory,
          AppRoutes.settings,
        ];

        for (final route in routes) {
          expect(route, startsWith('/'), reason: '$route deve começar com /');
        }
      });

      test('não há rotas duplicadas', () {
        final routes = [
          AppRoutes.splash,
          AppRoutes.login,
          AppRoutes.home,
          AppRoutes.placeDetail,
          AppRoutes.addPlace,
          AppRoutes.groupDetail,
          AppRoutes.groupMemberHistory,
          AppRoutes.settings,
        ];

        expect(routes.toSet().length, routes.length);
      });

      test('total de 8 rotas definidas', () {
        final routes = [
          AppRoutes.splash,
          AppRoutes.login,
          AppRoutes.home,
          AppRoutes.placeDetail,
          AppRoutes.addPlace,
          AppRoutes.groupDetail,
          AppRoutes.groupMemberHistory,
          AppRoutes.settings,
        ];

        expect(routes, hasLength(8));
      });
    });
  });
}

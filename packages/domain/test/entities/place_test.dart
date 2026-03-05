import 'package:domain/src/entities/place.dart';
import 'package:test/test.dart';

import '../helpers/fixtures.dart';

void main() {
  group('Place', () {
    group('construtor', () {
      test('cria com campos obrigatórios', () {
        final place = makePlace();

        expect(place.id, 'place-1');
        expect(place.name, 'Casa');
        expect(place.ownerId, 'user-1');
        expect(place.lat, -23.5505);
        expect(place.lng, -46.6333);
        expect(place.createdAt, kTestDate);
      });

      test('aplica valores padrão', () {
        final place = makePlace(description: null, memberIds: [], category: PlaceCategory.other);

        expect(place.description, isNull);
        expect(place.memberIds, isEmpty);
        expect(place.category, PlaceCategory.other);
      });

      test('aceita todos os campos opcionais', () {
        final place = makePlace(
          description: 'Minha casa',
          memberIds: ['user-2', 'user-3'],
          category: PlaceCategory.home,
        );

        expect(place.description, 'Minha casa');
        expect(place.memberIds, ['user-2', 'user-3']);
        expect(place.category, PlaceCategory.home);
      });

      test('aceita coordenadas negativas e zero', () {
        final p1 = makePlace(lat: -90.0, lng: -180.0);
        final p2 = makePlace(lat: 0.0, lng: 0.0);
        final p3 = makePlace(lat: 90.0, lng: 180.0);

        expect(p1.lat, -90.0);
        expect(p2.lat, 0.0);
        expect(p3.lat, 90.0);
      });
    });

    group('igualdade', () {
      test('dois objetos com mesmos dados são iguais', () {
        final a = makePlace();
        final b = makePlace();

        expect(a, equals(b));
      });

      test('objetos com ids diferentes não são iguais', () {
        final a = makePlace(id: 'place-1');
        final b = makePlace(id: 'place-2');

        expect(a, isNot(equals(b)));
      });

      test('objetos com nomes diferentes não são iguais', () {
        final a = makePlace(name: 'Casa');
        final b = makePlace(name: 'Trabalho');

        expect(a, isNot(equals(b)));
      });

      test('hashCode é consistente para objetos iguais', () {
        final a = makePlace();
        final b = makePlace();

        expect(a.hashCode, equals(b.hashCode));
      });
    });

    group('copyWith', () {
      test('altera campos especificados mantendo os demais', () {
        final original = makePlace(name: 'Antigo', lat: -23.0);
        final updated = original.copyWith(name: 'Novo', lat: -10.0);

        expect(updated.name, 'Novo');
        expect(updated.lat, -10.0);
        expect(updated.id, original.id);
        expect(updated.ownerId, original.ownerId);
        expect(updated.createdAt, original.createdAt);
      });

      test('copyWith sem argumentos retorna objeto igual', () {
        final original = makePlace();
        final copy = original.copyWith();

        expect(copy, equals(original));
      });

      test('pode alterar lista memberIds', () {
        final original = makePlace(memberIds: ['u1']);
        final updated = original.copyWith(memberIds: ['u1', 'u2', 'u3']);

        expect(updated.memberIds, ['u1', 'u2', 'u3']);
      });

      test('pode alterar categoria', () {
        final original = makePlace(category: PlaceCategory.other);
        final updated = original.copyWith(category: PlaceCategory.gym);

        expect(updated.category, PlaceCategory.gym);
      });
    });

    group('serialização JSON', () {
      test('toJson/fromJson — roundtrip completo', () {
        final place = makePlace(
          description: 'Descrição',
          memberIds: ['u2', 'u3'],
          category: PlaceCategory.work,
        );

        final json = place.toJson();
        final restored = Place.fromJson(json);

        expect(restored, equals(place));
      });

      test('toJson inclui todos os campos', () {
        final place = makePlace();
        final json = place.toJson();

        expect(json['id'], 'place-1');
        expect(json['name'], 'Casa');
        expect(json['ownerId'], 'user-1');
        expect(json['lat'], -23.5505);
        expect(json['lng'], -46.6333);
        expect(json.containsKey('createdAt'), isTrue);
      });

      test('fromJson com campos mínimos aplica padrões', () {
        final json = <String, dynamic>{
          'id': 'p1',
          'name': 'X',
          'ownerId': 'u1',
          'lat': 0.0,
          'lng': 0.0,
          'createdAt': kTestDate.toIso8601String(),
        };

        final place = Place.fromJson(json);

        expect(place.memberIds, isEmpty);
        expect(place.category, PlaceCategory.other);
        expect(place.description, isNull);
      });

      test('fromJson preserva todas as categorias', () {
        for (final category in PlaceCategory.values) {
          final json = <String, dynamic>{
            'id': 'p1',
            'name': 'X',
            'ownerId': 'u1',
            'lat': 0.0,
            'lng': 0.0,
            'category': category.name,
            'createdAt': kTestDate.toIso8601String(),
          };
          expect(Place.fromJson(json).category, category);
        }
      });
    });

    group('PlaceCategory', () {
      test('contém todas as categorias esperadas', () {
        expect(
          PlaceCategory.values,
          containsAll([
            PlaceCategory.home,
            PlaceCategory.work,
            PlaceCategory.gym,
            PlaceCategory.restaurant,
            PlaceCategory.shop,
            PlaceCategory.other,
          ]),
        );
      });

      test('total de 6 categorias', () {
        expect(PlaceCategory.values.length, 6);
      });
    });
  });
}

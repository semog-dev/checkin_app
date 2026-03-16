import 'dart:async';

import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/group/presentation/pages/group_member_history_page.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/entities/user_profile.dart';
import 'package:domain/src/repositories/check_in_repository.dart';
import 'package:domain/src/repositories/place_repository.dart';
import 'package:domain/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ── Helpers locais ────────────────────────────────────────────────────────────

UserProfile _makeProfile({
  String uid = 'u1',
  String displayName = 'Alice',
  String email = 'alice@test.com',
  UserStatus status = UserStatus.online,
}) =>
    UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      status: status,
    );

CheckInEvent _makeEvent({
  String id = 'e1',
  String userId = 'u1',
  String placeId = 'p1',
  CheckInEventType type = CheckInEventType.enter,
  DateTime? timestamp,
}) =>
    CheckInEvent(
      id: id,
      userId: userId,
      placeId: placeId,
      type: type,
      timestamp: timestamp ?? DateTime(2024, 3, 15, 10, 30),
    );

Place _makePlace({String id = 'p1', String name = 'Casa'}) => Place(
      id: id,
      name: name,
      ownerId: 'u1',
      lat: -23.5,
      lng: -46.6,
      createdAt: DateTime(2024, 1, 1),
    );

// ── Fakes ─────────────────────────────────────────────────────────────────────

class _FakeUserRepository implements UserRepository {
  _FakeUserRepository({UserProfile? profile}) : _profile = profile;
  final UserProfile? _profile;

  @override
  Stream<UserProfile?> watchCurrentUser() => Stream.value(_profile);

  @override
  Stream<UserProfile?> watchUserById(String uid) => Stream.value(_profile);

  @override
  Future<UserProfile?> getUserById(String uid) async => _profile;

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {}
}

class _FakeCheckInRepository implements CheckInRepository {
  _FakeCheckInRepository({this.events = const [], this.error});

  final List<CheckInEvent> events;
  final Exception? error;

  @override
  Future<void> recordEvent(CheckInEvent event) async {}

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) =>
      const Stream.empty();

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async {
    if (error != null) throw error!;
    return events;
  }
}

// Repositório que nunca resolve — mantém o FutureProvider em loading para sempre
class _PendingCheckInRepository implements CheckInRepository {
  @override
  Future<void> recordEvent(CheckInEvent event) async {}

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) =>
      const Stream.empty();

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) =>
      Completer<List<CheckInEvent>>().future;
}

class _FakePlaceRepository implements PlaceRepository {
  _FakePlaceRepository({this.places = const {}});
  final Map<String, Place> places;

  @override
  Stream<List<Place>> watchPlaces(String userId) => const Stream.empty();

  @override
  Future<Place?> getPlaceById(String id) async => places[id];

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

// ── _buildPage helper ─────────────────────────────────────────────────────────

Widget _buildPage({
  String memberId = 'u1',
  UserProfile? profile,
  List<CheckInEvent> events = const [],
  Map<String, Place> places = const {},
  Exception? checkInError,
}) {
  return ProviderScope(
    overrides: [
      userRepositoryProvider.overrideWithValue(
        _FakeUserRepository(profile: profile),
      ),
      checkInRepositoryProvider.overrideWithValue(
        _FakeCheckInRepository(events: events, error: checkInError),
      ),
      placeRepositoryProvider.overrideWithValue(
        _FakePlaceRepository(places: places),
      ),
    ],
    child: MaterialApp(
      home: GroupMemberHistoryPage(groupId: 'g1', memberId: memberId),
    ),
  );
}

// ── Testes ────────────────────────────────────────────────────────────────────

void main() {
  group('GroupMemberHistoryPage', () {
    group('AppBar', () {
      testWidgets('exibe "Histórico" enquanto perfil não carregou', (
        tester,
      ) async {
        await tester.pumpWidget(_buildPage());
        // Apenas um frame — antes das streams resolverem
        await tester.pump();
        expect(find.text('Histórico'), findsOneWidget);
      });

      testWidgets('exibe nome do membro no AppBar após perfil carregado', (
        tester,
      ) async {
        final profile = _makeProfile(displayName: 'Carlos');
        await tester.pumpWidget(_buildPage(profile: profile));
        await tester.pumpAndSettle();
        expect(find.text('Histórico de Carlos'), findsOneWidget);
      });

      testWidgets('exibe "Histórico" quando perfil é nulo', (tester) async {
        await tester.pumpWidget(_buildPage(profile: null));
        await tester.pumpAndSettle();
        expect(find.text('Histórico'), findsOneWidget);
      });
    });

    group('ProfileHeader', () {
      testWidgets('exibe nome e email do membro', (tester) async {
        final profile = _makeProfile(
          displayName: 'Alice',
          email: 'alice@test.com',
        );
        await tester.pumpWidget(_buildPage(profile: profile));
        await tester.pumpAndSettle();
        expect(find.text('Alice'), findsAtLeastNWidgets(1));
        expect(find.text('alice@test.com'), findsOneWidget);
      });

      testWidgets('exibe chip de status Online', (tester) async {
        final profile = _makeProfile(status: UserStatus.online);
        await tester.pumpWidget(_buildPage(profile: profile));
        await tester.pumpAndSettle();
        expect(find.text('Online'), findsOneWidget);
      });

      testWidgets('exibe chip de status Offline', (tester) async {
        final profile = _makeProfile(status: UserStatus.offline);
        await tester.pumpWidget(_buildPage(profile: profile));
        await tester.pumpAndSettle();
        expect(find.text('Offline'), findsOneWidget);
      });

      testWidgets('exibe inicial do nome no avatar quando sem foto', (
        tester,
      ) async {
        final profile = _makeProfile(displayName: 'Bob');
        await tester.pumpWidget(_buildPage(profile: profile));
        await tester.pumpAndSettle();
        expect(find.text('B'), findsOneWidget);
      });
    });

    group('Filtro de tempo', () {
      testWidgets('exibe SegmentedButton com opções 7, 30 e 90 dias', (
        tester,
      ) async {
        await tester.pumpWidget(_buildPage());
        await tester.pumpAndSettle();
        expect(find.text('7 dias'), findsOneWidget);
        expect(find.text('30 dias'), findsOneWidget);
        expect(find.text('90 dias'), findsOneWidget);
      });

      testWidgets('seleção padrão é 30 dias', (tester) async {
        await tester.pumpWidget(_buildPage());
        await tester.pumpAndSettle();
        final segButton =
            tester.widget<SegmentedButton<int>>(find.byType(SegmentedButton<int>));
        expect(segButton.selected, equals({30}));
      });

      testWidgets('trocando para 7 dias atualiza seleção do filtro', (
        tester,
      ) async {
        await tester.pumpWidget(_buildPage());
        await tester.pumpAndSettle();

        await tester.tap(find.text('7 dias'));
        await tester.pumpAndSettle();

        final segButton =
            tester.widget<SegmentedButton<int>>(find.byType(SegmentedButton<int>));
        expect(segButton.selected, equals({7}));
      });

      testWidgets('trocando para 90 dias atualiza seleção do filtro', (
        tester,
      ) async {
        await tester.pumpWidget(_buildPage());
        await tester.pumpAndSettle();

        await tester.tap(find.text('90 dias'));
        await tester.pumpAndSettle();

        final segButton =
            tester.widget<SegmentedButton<int>>(find.byType(SegmentedButton<int>));
        expect(segButton.selected, equals({90}));
      });
    });

    group('Lista de eventos', () {
      testWidgets('exibe CircularProgressIndicator durante carregamento', (
        tester,
      ) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userRepositoryProvider.overrideWithValue(
                _FakeUserRepository(profile: _makeProfile()),
              ),
              checkInRepositoryProvider.overrideWithValue(
                _PendingCheckInRepository(),
              ),
              placeRepositoryProvider.overrideWithValue(
                _FakePlaceRepository(),
              ),
            ],
            child: const MaterialApp(
              home: GroupMemberHistoryPage(groupId: 'g1', memberId: 'u1'),
            ),
          ),
        );
        await tester.pump(); // 1 frame — future ainda pendente
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      });

      testWidgets('exibe "Nenhum check-in no período" quando lista vazia', (
        tester,
      ) async {
        await tester.pumpWidget(_buildPage(events: []));
        await tester.pumpAndSettle();
        expect(find.text('Nenhum check-in no período'), findsOneWidget);
      });

      testWidgets('exibe tile para cada evento', (tester) async {
        final events = [
          _makeEvent(id: 'e1'),
          _makeEvent(id: 'e2', type: CheckInEventType.exit),
        ];
        await tester.pumpWidget(_buildPage(events: events));
        await tester.pumpAndSettle();
        // Cada tile mostra "Entrada" ou "Saída"
        expect(find.text('Entrada'), findsOneWidget);
        expect(find.text('Saída'), findsOneWidget);
      });

      testWidgets('exibe nome do local no tile', (tester) async {
        final event = _makeEvent(placeId: 'p1');
        final place = _makePlace(id: 'p1', name: 'Escritório');
        await tester.pumpWidget(
          _buildPage(events: [event], places: {'p1': place}),
        );
        await tester.pumpAndSettle();
        expect(find.text('Escritório'), findsOneWidget);
      });

      testWidgets('exibe placeId quando local não encontrado', (tester) async {
        final event = _makeEvent(placeId: 'p-unknown');
        await tester.pumpWidget(_buildPage(events: [event]));
        await tester.pumpAndSettle();
        expect(find.text('p-unknown'), findsOneWidget);
      });

      testWidgets('exibe data e hora formatadas do evento', (tester) async {
        final event = _makeEvent(
          timestamp: DateTime(2024, 3, 15, 10, 30),
        );
        await tester.pumpWidget(_buildPage(events: [event]));
        await tester.pumpAndSettle();
        expect(find.textContaining('15/03/2024'), findsOneWidget);
        expect(find.textContaining('10:30'), findsOneWidget);
      });

      testWidgets('evento de entrada exibe label "Entrada"', (tester) async {
        final event = _makeEvent(type: CheckInEventType.enter);
        await tester.pumpWidget(_buildPage(events: [event]));
        await tester.pumpAndSettle();
        expect(find.text('Entrada'), findsOneWidget);
      });

      testWidgets('evento de saída exibe label "Saída"', (tester) async {
        final event = _makeEvent(type: CheckInEventType.exit);
        await tester.pumpWidget(_buildPage(events: [event]));
        await tester.pumpAndSettle();
        expect(find.text('Saída'), findsOneWidget);
      });

      testWidgets('exibe múltiplos eventos com locais diferentes', (
        tester,
      ) async {
        final events = [
          _makeEvent(id: 'e1', placeId: 'p1', type: CheckInEventType.enter),
          _makeEvent(id: 'e2', placeId: 'p2', type: CheckInEventType.exit),
        ];
        final places = {
          'p1': _makePlace(id: 'p1', name: 'Casa'),
          'p2': _makePlace(id: 'p2', name: 'Academia'),
        };
        await tester.pumpWidget(_buildPage(events: events, places: places));
        await tester.pumpAndSettle();
        expect(find.text('Casa'), findsOneWidget);
        expect(find.text('Academia'), findsOneWidget);
      });
    });

    group('Estado de erro', () {
      testWidgets('exibe mensagem de erro quando provider falha', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildPage(checkInError: Exception('conexão perdida')),
        );
        await tester.pumpAndSettle();
        expect(find.textContaining('Erro:'), findsOneWidget);
      });
    });
  });
}

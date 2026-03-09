import 'package:checkin_app/app.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/group/presentation/providers/group_provider.dart' show groupRepositoryProvider;
import 'package:checkin_app/features/notifications/data/services/messaging_service.dart';
import 'package:checkin_app/features/notifications/data/services/notification_service.dart';
import 'package:checkin_app/features/notifications/presentation/providers/notification_provider.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:checkin_app/features/settings/presentation/providers/theme_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Stubs ─────────────────────────────────────────────────────────────────────

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<String?> watchAuthStateChanges() => const Stream.empty();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async =>
      'fake-uid';

  @override
  Future<void> signOut() async {}
}

class FakePlaceRepository implements PlaceRepository {
  @override
  Stream<List<Place>> watchPlaces(String userId) => const Stream.empty();

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace(Place place) async {}

  @override
  Future<void> updatePlace(Place place) async {}

  @override
  Future<void> deletePlace(String id) async {}
}

class FakeCheckInRepository implements CheckInRepository {
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
  }) async =>
      [];
}

class FakeGroupRepository implements GroupRepository {
  @override
  Stream<List<Group>> watchGroupsForUser(String userId) => const Stream.empty();

  @override
  Future<Group?> getGroupById(String id) async => null;

  @override
  Future<void> createGroup(Group group) async {}

  @override
  Future<void> addMember(String groupId, String userId) async {}

  @override
  Future<void> removeMember(String groupId, String userId) async {}

  @override
  Future<Group?> findByInviteCode(String inviteCode) async => null;
}

class FakeUserRepository implements UserRepository {
  @override
  Stream<UserProfile?> watchCurrentUser() => const Stream.empty();

  @override
  Stream<UserProfile?> watchUserById(String uid) => const Stream.empty();

  @override
  Future<UserProfile?> getUserById(String uid) async => null;

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {}
}

class FakeNotificationService extends NotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<void> showCheckIn({
    required String placeName,
    required CheckInEventType type,
  }) async {}

  @override
  Future<void> showRemote({
    required String title,
    required String body,
  }) async {}
}

class FakeMessagingService implements MessagingService {
  @override
  Future<void> init(String userId) async {}

  @override
  Future<void> dispose() async {}
}

class _FakeThemeModeNotifier extends ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  @override
  void setMode(ThemeMode mode) => state = mode;
}

// ── Widget helper ─────────────────────────────────────────────────────────────

Widget testApp() => ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        placeRepositoryProvider.overrideWithValue(FakePlaceRepository()),
        checkInRepositoryProvider.overrideWithValue(FakeCheckInRepository()),
        groupRepositoryProvider.overrideWithValue(FakeGroupRepository()),
        userRepositoryProvider.overrideWithValue(FakeUserRepository()),
        notificationServiceProvider
            .overrideWithValue(FakeNotificationService()),
        firebaseMessagingServiceProvider
            .overrideWithValue(FakeMessagingService()),
        themeModeProvider.overrideWith(() => _FakeThemeModeNotifier()),
      ],
      child: const CheckInApp(),
    );

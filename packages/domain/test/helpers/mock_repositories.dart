import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/entities/geofence_zone.dart';
import 'package:domain/src/entities/group.dart';
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/entities/user_profile.dart';
import 'package:domain/src/repositories/check_in_repository.dart';
import 'package:domain/src/repositories/geofence_repository.dart';
import 'package:domain/src/repositories/group_repository.dart';
import 'package:domain/src/repositories/place_repository.dart';
import 'package:domain/src/repositories/user_repository.dart';

// ─── PlaceRepository ──────────────────────────────────────────────────────────

class MockPlaceRepository implements PlaceRepository {
  String? lastWatchedUserId;
  String? lastGetByIdArg;
  Place? lastCreatedPlace;
  Place? lastUpdatedPlace;
  String? lastDeletedId;
  Exception? errorToThrow;

  List<Place> placesToEmit = [];
  Place? placeToReturn;

  @override
  Stream<List<Place>> watchPlaces(String userId) {
    lastWatchedUserId = userId;
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(placesToEmit);
  }

  @override
  Future<Place?> getPlaceById(String id) async {
    lastGetByIdArg = id;
    if (errorToThrow != null) throw errorToThrow!;
    return placeToReturn;
  }

  @override
  Future<void> createPlace(Place place) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastCreatedPlace = place;
  }

  @override
  Future<void> updatePlace(Place place) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastUpdatedPlace = place;
  }

  @override
  Future<void> deletePlace(String id) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastDeletedId = id;
  }
}

// ─── UserRepository ───────────────────────────────────────────────────────────

class MockUserRepository implements UserRepository {
  String? lastGetByIdArg;
  UserProfile? lastUpdatedProfile;
  String? lastStatusUid;
  UserStatus? lastStatusValue;
  Exception? errorToThrow;

  UserProfile? profileToEmit;
  UserProfile? profileToReturn;

  @override
  Stream<UserProfile?> watchCurrentUser() {
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(profileToEmit);
  }

  @override
  Future<UserProfile?> getUserById(String uid) async {
    lastGetByIdArg = uid;
    if (errorToThrow != null) throw errorToThrow!;
    return profileToReturn;
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastUpdatedProfile = profile;
  }

  @override
  Future<void> updateStatus(String uid, UserStatus status) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastStatusUid = uid;
    lastStatusValue = status;
  }
}

// ─── GroupRepository ──────────────────────────────────────────────────────────

class MockGroupRepository implements GroupRepository {
  String? lastWatchedUserId;
  String? lastGetByIdArg;
  Group? lastCreatedGroup;
  String? lastAddMemberGroupId;
  String? lastAddMemberUserId;
  String? lastRemoveMemberGroupId;
  String? lastRemoveMemberUserId;
  String? lastInviteCodeArg;
  Exception? errorToThrow;

  List<Group> groupsToEmit = [];
  Group? groupToReturn;
  Group? groupByInviteCode;

  @override
  Stream<List<Group>> watchGroupsForUser(String userId) {
    lastWatchedUserId = userId;
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(groupsToEmit);
  }

  @override
  Future<Group?> getGroupById(String id) async {
    lastGetByIdArg = id;
    if (errorToThrow != null) throw errorToThrow!;
    return groupToReturn;
  }

  @override
  Future<void> createGroup(Group group) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastCreatedGroup = group;
  }

  @override
  Future<void> addMember(String groupId, String userId) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastAddMemberGroupId = groupId;
    lastAddMemberUserId = userId;
  }

  @override
  Future<void> removeMember(String groupId, String userId) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastRemoveMemberGroupId = groupId;
    lastRemoveMemberUserId = userId;
  }

  @override
  Future<Group?> findByInviteCode(String inviteCode) async {
    lastInviteCodeArg = inviteCode;
    if (errorToThrow != null) throw errorToThrow!;
    return groupByInviteCode;
  }
}

// ─── CheckInRepository ────────────────────────────────────────────────────────

class MockCheckInRepository implements CheckInRepository {
  CheckInEvent? lastRecordedEvent;
  String? lastWatchedPlaceId;
  int? lastWatchedLimit;
  String? lastGetEventsUserId;
  DateTime? lastGetEventsSince;
  Exception? errorToThrow;

  List<CheckInEvent> eventsToEmit = [];
  List<CheckInEvent> eventsToReturn = [];

  @override
  Future<void> recordEvent(CheckInEvent event) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastRecordedEvent = event;
  }

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) {
    lastWatchedPlaceId = placeId;
    lastWatchedLimit = limit;
    if (errorToThrow != null) return Stream.error(errorToThrow!);
    return Stream.value(eventsToEmit);
  }

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async {
    lastGetEventsUserId = userId;
    lastGetEventsSince = since;
    if (errorToThrow != null) throw errorToThrow!;
    return eventsToReturn;
  }
}

// ─── GeofenceRepository ───────────────────────────────────────────────────────

class MockGeofenceRepository implements GeofenceRepository {
  String? lastGetZonesUserId;
  GeofenceZone? lastUpsertedZone;
  String? lastDeletedId;
  Exception? errorToThrow;

  List<GeofenceZone> zonesToReturn = [];

  @override
  Future<List<GeofenceZone>> getZonesForUser(String userId) async {
    lastGetZonesUserId = userId;
    if (errorToThrow != null) throw errorToThrow!;
    return zonesToReturn;
  }

  @override
  Future<void> upsertZone(GeofenceZone zone) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastUpsertedZone = zone;
  }

  @override
  Future<void> deleteZone(String id) async {
    if (errorToThrow != null) throw errorToThrow!;
    lastDeletedId = id;
  }
}

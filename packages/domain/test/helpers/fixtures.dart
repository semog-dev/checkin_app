import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/entities/geofence_zone.dart';
import 'package:domain/src/entities/group.dart';
import 'package:domain/src/entities/place.dart';
import 'package:domain/src/entities/user_profile.dart';

/// Data de referência usada nos testes (evita flakiness com DateTime.now()).
final kTestDate = DateTime(2024, 6, 15, 12, 0);

// ─── Place ────────────────────────────────────────────────────────────────────

Place makePlace({
  String id = 'place-1',
  String name = 'Casa',
  String ownerId = 'user-1',
  double lat = -23.5505,
  double lng = -46.6333,
  String? description,
  List<String> memberIds = const [],
  PlaceCategory category = PlaceCategory.home,
  DateTime? createdAt,
}) =>
    Place(
      id: id,
      name: name,
      ownerId: ownerId,
      lat: lat,
      lng: lng,
      description: description,
      memberIds: memberIds,
      category: category,
      createdAt: createdAt ?? kTestDate,
    );

// ─── UserProfile ──────────────────────────────────────────────────────────────

UserProfile makeUserProfile({
  String uid = 'user-1',
  String displayName = 'Alice',
  String email = 'alice@example.com',
  String? photoUrl,
  UserStatus status = UserStatus.online,
  List<String> groupIds = const [],
  DateTime? lastSeenAt,
}) =>
    UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
      status: status,
      groupIds: groupIds,
      lastSeenAt: lastSeenAt,
    );

// ─── Group ────────────────────────────────────────────────────────────────────

Group makeGroup({
  String id = 'group-1',
  String name = 'Família',
  String adminId = 'user-1',
  List<String> memberIds = const ['user-1', 'user-2'],
  List<String> placeIds = const [],
  String inviteCode = 'ABC123',
  DateTime? createdAt,
}) =>
    Group(
      id: id,
      name: name,
      adminId: adminId,
      memberIds: memberIds,
      placeIds: placeIds,
      inviteCode: inviteCode,
      createdAt: createdAt ?? kTestDate,
    );

// ─── CheckInEvent ─────────────────────────────────────────────────────────────

CheckInEvent makeCheckInEvent({
  String id = 'event-1',
  String userId = 'user-1',
  String placeId = 'place-1',
  CheckInEventType type = CheckInEventType.enter,
  DateTime? timestamp,
  double? accuracyMeters,
}) =>
    CheckInEvent(
      id: id,
      userId: userId,
      placeId: placeId,
      type: type,
      timestamp: timestamp ?? kTestDate,
      accuracyMeters: accuracyMeters,
    );

// ─── GeofenceZone ─────────────────────────────────────────────────────────────

GeofenceZone makeGeofenceZone({
  String id = 'zone-1',
  String placeId = 'place-1',
  double lat = -23.5505,
  double lng = -46.6333,
  double radiusMeters = 100.0,
  bool isActive = true,
}) =>
    GeofenceZone(
      id: id,
      placeId: placeId,
      lat: lat,
      lng: lng,
      radiusMeters: radiusMeters,
      isActive: isActive,
    );

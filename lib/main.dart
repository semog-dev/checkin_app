import 'package:checkin_app/app.dart';
import 'package:checkin_app/bootstrap.dart';
import 'package:checkin_app/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_app/features/geofencing/data/repositories/firebase_check_in_repository.dart';
import 'package:checkin_app/features/geofencing/presentation/providers/geofencing_provider.dart';
import 'package:checkin_app/features/notifications/data/services/notification_service.dart';
import 'package:checkin_app/features/notifications/presentation/providers/notification_provider.dart';
import 'package:checkin_app/features/places/data/repositories/firebase_place_repository.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();

  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          FirebaseAuthRepository(FirebaseAuth.instance),
        ),
        placeRepositoryProvider.overrideWithValue(
          FirebasePlaceRepository(FirebaseFirestore.instance),
        ),
        checkInRepositoryProvider.overrideWithValue(
          FirebaseCheckInRepository(FirebaseFirestore.instance),
        ),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const CheckInApp(),
    ),
  );
}

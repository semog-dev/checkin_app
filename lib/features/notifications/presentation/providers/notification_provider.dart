import 'package:checkin_app/features/notifications/data/services/firebase_messaging_service.dart';
import 'package:checkin_app/features/notifications/data/services/notification_service.dart';
import 'package:checkin_app/features/places/presentation/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) =>
      throw UnimplementedError('notificationServiceProvider not overridden'),
);

final firebaseMessagingServiceProvider = Provider<FirebaseMessagingService>(
  (ref) => throw UnimplementedError(
    'firebaseMessagingServiceProvider not overridden',
  ),
);

/// Observa o UID autenticado e inicializa (ou limpa) o FCM automaticamente.
/// Deve ser lido na raiz da árvore de widgets — ex: CheckInApp.build().
final fcmListenerProvider = Provider<void>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  final service = ref.read(firebaseMessagingServiceProvider);

  if (uid != null) {
    service.init(uid);
  } else {
    service.dispose();
  }
});

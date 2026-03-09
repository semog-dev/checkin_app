import 'package:checkin_app/firebase_options.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Handler de mensagens FCM em background/terminated.
/// DEVE ser top-level — não pode ser método de classe.
/// Mensagens com payload `notification` são exibidas automaticamente pelo
/// sistema (Android/iOS) em background — este handler cuida apenas de
/// mensagens data-only (sem payload notification).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppLogger.d(
    'FCM background: ${message.messageId} — ${message.notification?.title}',
  );

  // Mensagens com notification payload: o sistema já as exibe automaticamente.
  if (message.notification != null) return;

  // Mensagens data-only: extrair título/body do mapa de dados e exibir manualmente.
  final title = message.data['title'] as String?;
  final body = message.data['body'] as String?;
  if (title == null && body == null) return;

  const channelId = 'checkin_geofence';
  const channelName = 'Check-ins';

  final plugin = FlutterLocalNotificationsPlugin();
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );
  await plugin.show(
    message.hashCode,
    title ?? 'CheckIn',
    body ?? '',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    ),
  );
}

Future<void> bootstrap() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registrar handler de background ANTES de qualquer listener de foreground.
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();

  AppLogger.i('Bootstrap concluído — flavor: ${AppConfig.flavor}');
}

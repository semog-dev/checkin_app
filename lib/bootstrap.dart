import 'package:checkin_app/firebase_options.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Handler de mensagens FCM em background/terminated.
/// DEVE ser top-level — não pode ser método de classe.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase já está inicializado pelo sistema quando este handler é chamado.
  AppLogger.d('FCM background: ${message.messageId} — ${message.notification?.title}');
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

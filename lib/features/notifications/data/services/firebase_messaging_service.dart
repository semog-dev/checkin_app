import 'dart:async';

import 'package:checkin_app/features/notifications/data/services/messaging_service.dart';
import 'package:checkin_app/features/notifications/data/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService implements MessagingService {
  FirebaseMessagingService({
    required FirebaseFirestore firestore,
    required NotificationService notificationService,
  })  : _firestore = firestore,
        _notificationService = notificationService;

  final FirebaseFirestore _firestore;
  final NotificationService _notificationService;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;

  /// Inicializa o FCM para o usuário autenticado.
  /// Idempotente — cancela subscriptions anteriores antes de recriar.
  @override
  Future<void> init(String userId) async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();

    // 1. Solicitar permissão (Android 13+ / iOS)
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger.i('FCM permission: ${settings.authorizationStatus}');

    // 2. iOS: apresentar notificações no foreground
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 3. Obter e salvar token atual
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _saveToken(userId, token);

    // 4. Atualizar token quando ele for renovado pelo FCM
    _tokenRefreshSub = FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) => _saveToken(userId, token),
    );

    // 5. Exibir notificação local para mensagens recebidas em foreground
    _foregroundSub = FirebaseMessaging.onMessage.listen(
      (message) => _handleForeground(message),
    );
  }

  /// Limpa subscriptions ao fazer logout.
  @override
  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    _tokenRefreshSub = null;
    _foregroundSub = null;
  }

  Future<void> _saveToken(String userId, String token) async {
    AppLogger.d('FCM token atualizado para $userId');
    await _firestore.collection('users').doc(userId).set(
      {
        'fcmToken': token,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  void _handleForeground(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    AppLogger.i('FCM foreground: ${notification.title}');
    _notificationService.showRemote(
      title: notification.title ?? 'CheckIn',
      body: notification.body ?? '',
    );
  }
}

import 'package:domain/domain.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const _channelId = 'checkin_geofence';
  static const _channelName = 'Check-ins';
  static const _channelDesc =
      'Notificações de entrada e saída em locais cadastrados';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );

    // Cria o canal no Android (no-op em versões < 8.0 e no iOS)
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDesc,
            importance: Importance.high,
          ),
        );
  }

  Future<void> showRemote({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showCheckIn({
    required String placeName,
    required CheckInEventType type,
  }) async {
    final isEnter = type == CheckInEventType.enter;

    await _plugin.show(
      // ID único por local + tipo para evitar sobreposição
      placeName.hashCode ^ type.index,
      isEnter ? 'Check-in realizado' : 'Check-out realizado',
      isEnter ? 'Você entrou em $placeName' : 'Você saiu de $placeName',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
  }
}

import 'package:checkin_app/firebase_options.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bootstrap() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  AppLogger.i('Bootstrap concluído — flavor: ${AppConfig.flavor}');
}

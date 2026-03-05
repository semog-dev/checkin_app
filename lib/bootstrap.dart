import 'package:core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bootstrap() async {
  // Firebase.initializeApp() deve ser chamado após `flutterfire configure`
  // gerar lib/firebase_options.dart.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Hive.initFlutter();

  AppLogger.i('Bootstrap concluído — flavor: ${AppConfig.flavor}');
}

import 'package:checkin_app/app.dart';
import 'package:checkin_app/bootstrap.dart';
import 'package:checkin_app/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  runApp(
    ProviderScope(
      overrides: [
        // TODO: substituir por FirebaseAuthRepository após `flutterfire configure`
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      ],
      child: const CheckInApp(),
    ),
  );
}

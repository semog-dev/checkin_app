import 'package:checkin_app/features/notifications/presentation/providers/notification_provider.dart';
import 'package:checkin_app/features/settings/presentation/providers/theme_provider.dart';
import 'package:checkin_app/router/app_router.dart';
import 'package:core/core.dart' hide appRouterProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInApp extends ConsumerWidget {
  const CheckInApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ativa o listener de FCM: inicializa quando autenticado, limpa no logout.
    ref.watch(fcmListenerProvider);

    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.isDev,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}

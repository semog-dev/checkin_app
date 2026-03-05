abstract final class AppConfig {
  static const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  static const appName = String.fromEnvironment('APP_NAME', defaultValue: 'CheckIn Dev');
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
  static const wsUrl = String.fromEnvironment('WS_URL', defaultValue: 'ws://localhost:3000');
  static const mapsApiKey = String.fromEnvironment('MAPS_API_KEY', defaultValue: '');

  // Feature flags
  /// Usa coordenadas fixas em vez do GPS real. Permite testar geofencing sem sair de casa.
  static const mockLocation = bool.fromEnvironment('MOCK_LOCATION', defaultValue: false);

  /// Exibe overlay com lat/lng, velocidade e status de geofences ativos.
  static const showDebugOverlay = bool.fromEnvironment('SHOW_DEBUG_OVERLAY', defaultValue: false);

  /// Usa notificações locais em vez de push remoto. Útil em dev sem servidor de push configurado.
  static const useLocalNotifications = bool.fromEnvironment('USE_LOCAL_NOTIFICATIONS', defaultValue: false);

  static bool get isDev => flavor == 'dev';
  static bool get isStaging => flavor == 'staging';
  static bool get isProd => flavor == 'prod';
}

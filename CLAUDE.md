# CheckIn App — Contexto para Claude

## O que é este projeto
App Flutter de "Check-in Inteligente": o usuário cadastra locais no mapa, o app detecta entrada/saída em background via geofencing e dispara notificações contextuais. Grupos de usuários veem status em tempo real via Firestore streams.

## Status das funcionalidades

| Feature | Status |
|---|---|
| Auth (Firebase Email/Senha) | ✅ implementado |
| Places (CRUD + mapa) | ✅ implementado |
| Geofencing (background location) | ✅ implementado |
| Notificações locais + FCM push | ✅ implementado |
| Grupos em tempo real (Firestore) | ✅ implementado |
| Auth real (registro de usuário) | 🔜 pendente |
| Home dashboard com status do grupo | 🔜 pendente |

## Stack (decisões tomadas)
- **Framework**: Flutter / Dart
- **Backend**: Firebase (firebase_core, firebase_auth, cloud_firestore, firebase_messaging)
- **Mapas**: `flutter_map` + `latlong2`
- **State management**: Riverpod (`flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`)
- **Navegação**: `go_router`
- **Storage local**: `hive_flutter`
- **Geolocation**: `geolocator`
- **Notificações locais**: `flutter_local_notifications`

## Arquitetura — Monorepo com Melos
```
checkin_app/           ← app Flutter (entry point)
packages/
  domain/              ← Dart puro: entities, repositories (interfaces), use cases
  core/                ← Flutter: theme, router placeholder, AppConfig, AppLogger, extensions
```

### Regras de dependência
- `domain` não depende de nada interno
- `core` depende de `domain`
- `app` depende de `core` e `domain`
- Features dentro de `lib/features/` são independentes entre si (comunicam via shared state)

## Como rodar
```bash
make bootstrap    # dart pub global activate melos && melos bootstrap
make codegen      # build_runner em todos os packages
make analyze      # format:check + analyze + analyze:app
make test         # testes de packages + app

make run-dev      # flavor dev  + envs/dev.json
make run-staging  # flavor staging + envs/staging.json
make run-prod     # flavor prod + envs/prod.json
make build-prod   # APK de produção
make icons-all    # Gerar ícones (requer PNGs em assets/icons/)
```

## Codegen
Os arquivos `.g.dart` e `.freezed.dart` **são commitados** (não estão no .gitignore).
Sempre rodar `make codegen` após:
- Adicionar/modificar entities com `@freezed` em `packages/domain`

Obs: codegen só roda em `packages/domain` (entities `@freezed`). Providers no app são declarados manualmente — **não** usar `@riverpod` codegen no app ou em `packages/core`.

## Ambientes (Flavors)
Três ambientes isolados via `--dart-define-from-file` + Android `productFlavors` + iOS schemes:

| Ambiente | Android App ID suffix | iOS Bundle ID |
|---|---|---|
| dev | `.dev` | `com.example.checkinApp.dev` |
| staging | `.staging` | `com.example.checkinApp.staging` |
| prod | *(sem sufixo)* | `com.example.checkinApp` |

### Adicionar uma nova variável de ambiente
1. Adicionar nos três arquivos `envs/{dev,staging,prod}.json` e em `envs/prod.json.example`
2. Expor como `static const` em `packages/core/lib/src/config/app_config.dart`

## Arquivos críticos
- `packages/core/lib/src/config/app_config.dart` — toda config e feature flags
- `packages/core/lib/src/logger/app_logger.dart` — usar `AppLogger` em vez de `print()`
- `packages/core/lib/src/router/app_routes.dart` — constantes de rota (`AppRoutes`)
- `packages/domain/lib/domain.dart` — barrel de entities, repositories, use cases
- `lib/router/app_router.dart` — GoRouter real do app (com redirect de auth)
- `lib/bootstrap.dart` — inicialização (Firebase.initializeApp ativo)
- `lib/main.dart` — `ProviderScope` com overrides de todos os repositórios Firebase
- `android/app/build.gradle.kts` — flavors Android + leitura de `local.properties`
- `android/local.properties` — chaves nativas por ambiente (não commitada; usar `.example`)
- `envs/*.json` — valores Dart por ambiente (`prod.json` está no `.gitignore`)
- `melos.yaml` — scripts de monorepo
- `ios/Runner.xcodeproj/project.pbxproj` — build configurations iOS por flavor

## Providers — padrão de injeção
Todos os providers seguem o padrão de **declaração manual** com `throw UnimplementedError` como default e override via `main.dart`:

```dart
// provider declarado na feature
final groupRepositoryProvider = Provider<GroupRepository>(
  (ref) => throw UnimplementedError('groupRepositoryProvider not overridden'),
);

// override em main.dart
groupRepositoryProvider.overrideWithValue(FirestoreGroupRepository(...))
```

Nunca usar `@riverpod` codegen no app — apenas `@freezed` no domain.

## Padrão de testes
- `test/helpers/test_providers.dart` — stubs de todos os providers + helper `testApp()`
- Testes de widget devem usar `testApp()` em vez de `ProviderScope(child: CheckInApp())` puro
- Testes de domain ficam em `packages/domain/test/`

## Convenções de código
- `AppLogger.d/i/w/e()` para todos os logs — nunca `print()` diretamente
- Feature flags em `AppConfig` (compile-time `bool.fromEnvironment`) — nunca checar `AppConfig.isDev` para lógica de negócio
- Sempre `package:` imports absolutos — nunca imports relativos
- Estrutura de feature: `lib/features/{nome}/{data,presentation}/`
- Features são independentes entre si — sem imports cruzados entre features
- Interfaces de serviços devem ser extraídas quando necessário para testabilidade (ex: `MessagingService`)

## O que não fazer
- Não commitar `envs/prod.json` nem `android/local.properties`
- Não usar `print()` — usar `AppLogger`
- Não checar `kDebugMode` para separar comportamento por ambiente — usar `AppConfig.flavor`
- Não adicionar dependências sem considerar compatibilidade com background execution
- Não usar imports relativos — sempre `package:` imports
- Não usar `@riverpod` codegen no app — declarar providers manualmente
- Não criar imports entre features (`lib/features/auth/` não importa de `lib/features/places/`)
- Não usar `const ProviderScope(child: CheckInApp())` em testes — usar `testApp()`

# CheckIn App — Contexto para Claude

## O que é este projeto
App Flutter de "Check-in Inteligente": o usuário cadastra locais no mapa, o app detecta entrada/saída em background via geofencing e dispara notificações contextuais. Grupos de usuários veem status em tempo real via WebSockets.

Funcionalidades previstas: geofencing, background location, WebSockets, push notifications inteligentes, mapas nativos.

## Stack
- **Framework**: Flutter / Dart
- **Backend**: não decidido (candidatos: Firebase, Supabase, servidor próprio)
- **Mapas**: não decidido (candidatos: `google_maps_flutter`, `flutter_map`)
- **State management**: não decidido

## Como rodar
```bash
make run-dev      # flavor dev  + envs/dev.json
make run-staging  # flavor staging + envs/staging.json
make run-prod     # flavor prod + envs/prod.json
make build-prod   # APK de produção
make icons-all    # Gerar ícones (requer PNGs em assets/icons/)
```

## Ambientes (Flavors)
Três ambientes isolados via `--dart-define-from-file` + Android `productFlavors` + iOS schemes:

| Ambiente | Android App ID suffix | iOS Bundle ID |
|---|---|---|
| dev | `.dev` | `com.example.checkinApp.dev` |
| staging | `.staging` | `com.example.checkinApp.staging` |
| prod | *(sem sufixo)* | `com.example.checkinApp` |

### Adicionar uma nova variável de ambiente
1. Adicionar nos três arquivos `envs/{dev,staging,prod}.json` e em `envs/prod.json.example`
2. Expor como `static const` em `lib/core/config/app_config.dart` via `String.fromEnvironment()` ou `bool.fromEnvironment()`

## Arquivos críticos
- `lib/core/config/app_config.dart` — toda config e feature flags vêm daqui
- `lib/core/logger/app_logger.dart` — usar `AppLogger` em vez de `print()`
- `android/app/build.gradle.kts` — flavors Android + leitura de `local.properties`
- `android/local.properties` — chaves nativas por ambiente (não commitada; usar `.example` como template)
- `envs/*.json` — valores Dart por ambiente (`prod.json` está no `.gitignore`)
- `ios/Runner.xcodeproj/project.pbxproj` — build configurations iOS por flavor

## Convenções de código
- `AppLogger.d/i/w/e()` para todos os logs — nunca `print()` diretamente
- Feature flags em `AppConfig` (compile-time `bool.fromEnvironment`) — nunca checar `AppConfig.isDev` para lógica de negócio
- Estrutura de pastas: `lib/core/` para infraestrutura, `lib/features/{nome}/` para features
- Arquivos de feature: `data/`, `domain/`, `presentation/` dentro de cada feature

## O que não fazer
- Não commitar `envs/prod.json` nem `android/local.properties`
- Não usar `print()` — usar `AppLogger`
- Não checar `kDebugMode` para separar comportamento por ambiente — usar `AppConfig.flavor`
- Não adicionar dependências sem considerar compatibilidade com background execution (geofencing requer pacotes específicos)

# CheckIn App

App Flutter de **check-in inteligente**: cadastre locais no mapa, detecte entradas e saídas em background via geofencing e acompanhe o status da sua equipe em tempo real.

---

## Funcionalidades

| Feature | Status |
|---|---|
| Autenticação (e-mail + senha, registro) | ✅ |
| Cadastro e gerenciamento de locais (CRUD + mapa) | ✅ |
| Geofencing em background (entrada/saída automática) | ✅ |
| Histórico de check-ins por local | ✅ |
| Notificações locais + FCM push (foreground e background) | ✅ |
| Grupos em tempo real (Firestore streams) | ✅ |
| Perfil de usuário (avatar, nome, status) | ✅ |
| Tema claro / escuro / automático | ✅ |

---

## Stack

| Camada | Tecnologia |
|---|---|
| Framework | Flutter / Dart |
| Backend | Firebase (Auth, Firestore, Messaging) |
| State management | Riverpod 3.x |
| Navegação | go\_router |
| Mapas | flutter\_map + latlong2 (OpenStreetMap) |
| Storage local | Hive |
| Geolocalização | geolocator |
| Notificações | flutter\_local\_notifications |

---

## Arquitetura

Monorepo com [Melos](https://melos.invertase.dev/) (pub workspaces):

```
checkin_app/           ← app Flutter (entry point)
packages/
  domain/              ← Dart puro: entities, repositories (interfaces), use cases
  core/                ← Flutter: tema, router, AppConfig, AppLogger, extensions
```

**Regras de dependência:**
- `domain` → sem dependências internas
- `core` → depende de `domain`
- `app` → depende de `core` e `domain`
- Features em `lib/features/` são independentes entre si

**Providers** são declarados manualmente (sem `@riverpod` codegen no app) com `throw UnimplementedError` como padrão e override via `main.dart`.

---

## Ambientes (Flavors)

| Ambiente | Android App ID | Uso |
|---|---|---|
| `dev` | `com.example.checkinApp.dev` | Desenvolvimento local |
| `staging` | `com.example.checkinApp.staging` | Testes / QA |
| `prod` | `com.example.checkinApp` | Produção |

Configurações via `--dart-define-from-file=envs/{flavor}.json`. O arquivo `envs/prod.json` **não é commitado** — use `envs/prod.json.example` como referência.

---

## Como rodar

### Pré-requisitos

- Flutter (channel stable)
- Java 17+ (recomendado: Android Studio JBR)
- Firebase configurado (`google-services.json` e `GoogleService-Info.plist`)

### Primeira vez

```bash
# Instalar Melos e resolver dependências
make bootstrap

# Gerar código (entities @freezed)
make codegen
```

### Rodar o app

```bash
make run-dev       # flavor dev
make run-staging   # flavor staging
make run-prod      # flavor prod
```

### Qualidade de código

```bash
make analyze   # format:check + dart analyze + flutter analyze
make test      # testes de packages + core + app (com cobertura)
make format    # formatar todos os arquivos
```

### Build de produção

```bash
make build-prod   # gera APK em build/app/outputs/flutter-apk/
```

---

## CI/CD (GitHub Actions)

| Job | Trigger | O que faz |
|---|---|---|
| `analyze` | todo push / PR | Formatação + análise estática |
| `test` | todo push / PR | Testes com cobertura (Codecov) |
| `build` (dev + staging) | todo push / PR | Compila os dois flavors |
| `build-prod` | push em `main` | Compila APK prod com secrets |
| `release` | push em `main` | Cria GitHub Release com APK |

**Versionamento automático:**
Tag = `v{semver}+{run_number}` — ex: `v1.0.0+42`
O semver vem do `pubspec.yaml` (bump manual a cada release público). O build number é o `github.run_number` (auto-incremental).

**Secrets necessários para o job `build-prod`:**
- `PROD_API_BASE_URL`
- `PROD_WS_URL`
- `PROD_MAPS_API_KEY`
- `PROD_MAPS_API_KEY_NATIVE`

---

## Variáveis de ambiente

Para adicionar uma nova variável:

1. Adicionar nos três arquivos `envs/{dev,staging,prod}.json` e em `envs/prod.json.example`
2. Expor como `static const` em `packages/core/lib/src/config/app_config.dart`

---

## Convenções de código

- `AppLogger.d/i/w/e()` para todos os logs — nunca `print()`
- Sempre `package:` imports absolutos — nunca imports relativos
- Feature flags em `AppConfig` (compile-time) — nunca checar `AppConfig.isDev` para lógica de negócio
- Testes de widget usam `testApp()` de `test/helpers/test_providers.dart`

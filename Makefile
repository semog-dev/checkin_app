.PHONY: bootstrap codegen codegen-clean analyze test format clean \
        run-dev run-staging run-prod build-prod \
        icons-dev icons-staging icons-prod icons-all

# ─── Monorepo ────────────────────────────────────────────────────────────────

bootstrap:
	dart pub global activate melos
	melos bootstrap

codegen:
	melos run codegen

codegen-clean:
	melos exec --depends-on="build_runner" -- \
		dart run build_runner clean
	melos run codegen

analyze:
	melos run format:check
	melos run analyze
	melos run analyze:app

test:
	melos run test
	melos run test:app

format:
	melos run format

clean:
	melos exec -- flutter clean
	flutter clean

# ─── Run ─────────────────────────────────────────────────────────────────────

run-dev:
	flutter run --flavor dev --dart-define-from-file=envs/dev.json

run-staging:
	flutter run --flavor staging --dart-define-from-file=envs/staging.json

run-prod:
	flutter run --flavor prod --dart-define-from-file=envs/prod.json

build-prod:
	flutter build apk --flavor prod --dart-define-from-file=envs/prod.json

# ─── Icons ───────────────────────────────────────────────────────────────────
# Requer assets/icons/icon-{flavor}.png

icons-dev:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-dev.yaml

icons-staging:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-staging.yaml

icons-prod:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-prod.yaml

icons-all: icons-dev icons-staging icons-prod

.PHONY: run-dev run-staging run-prod build-prod icons-dev icons-staging icons-prod icons-all

run-dev:
	flutter run --flavor dev --dart-define-from-file=envs/dev.json

run-staging:
	flutter run --flavor staging --dart-define-from-file=envs/staging.json

run-prod:
	flutter run --flavor prod --dart-define-from-file=envs/prod.json

build-prod:
	flutter build apk --flavor prod --dart-define-from-file=envs/prod.json

# Gerar ícones por ambiente (requer assets/icons/icon-{flavor}.png)
icons-dev:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-dev.yaml

icons-staging:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-staging.yaml

icons-prod:
	dart run flutter_launcher_icons:main -f flutter_launcher_icons-prod.yaml

icons-all: icons-dev icons-staging icons-prod

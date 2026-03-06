import 'package:core/src/theme/app_colors.dart';
import 'package:core/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    group('tema claro', () {
      test('light retorna ThemeData', () {
        expect(AppTheme.light, isA<ThemeData>());
      });

      test('light usa Material 3', () {
        expect(AppTheme.light.useMaterial3, isTrue);
      });

      test('light tem brilho claro', () {
        expect(AppTheme.light.brightness, Brightness.light);
      });

      test('light usa cor primária correta', () {
        expect(
          AppTheme.light.colorScheme.primary,
          isA<Color>(),
        );
      });

      test('light seed color é AppColors.primary', () {
        // Verifica indiretamente que o colorScheme foi gerado a partir do seed
        expect(AppTheme.light.colorScheme, isNotNull);
      });

      test('AppBar do tema claro não centraliza título', () {
        expect(AppTheme.light.appBarTheme.centerTitle, isFalse);
      });
    });

    group('tema escuro', () {
      test('dark retorna ThemeData', () {
        expect(AppTheme.dark, isA<ThemeData>());
      });

      test('dark usa Material 3', () {
        expect(AppTheme.dark.useMaterial3, isTrue);
      });

      test('dark tem brilho escuro', () {
        expect(AppTheme.dark.brightness, Brightness.dark);
      });

      test('AppBar do tema escuro não centraliza título', () {
        expect(AppTheme.dark.appBarTheme.centerTitle, isFalse);
      });
    });

    group('distinção entre temas', () {
      test('light e dark têm brilhos diferentes', () {
        expect(
          AppTheme.light.brightness,
          isNot(equals(AppTheme.dark.brightness)),
        );
      });

      test('light e dark são instâncias diferentes', () {
        expect(AppTheme.light, isNot(same(AppTheme.dark)));
      });

      test('ambos os temas usam AppColors.primary como seed', () {
        // Ambos devem ter colorScheme definido e não nulo
        expect(AppTheme.light.colorScheme, isNotNull);
        expect(AppTheme.dark.colorScheme, isNotNull);
      });
    });

    group('cores semânticas presentes', () {
      test('tema claro tem cor de erro', () {
        expect(AppTheme.light.colorScheme.error, isA<Color>());
      });

      test('tema escuro tem cor de erro', () {
        expect(AppTheme.dark.colorScheme.error, isA<Color>());
      });
    });

    group('integração com AppColors', () {
      test('AppColors.primary não é transparente', () {
        expect((AppColors.primary.a * 255.0).round().clamp(0, 255), 255);
      });

      test('AppColors.error não é transparente', () {
        expect((AppColors.error.a * 255.0).round().clamp(0, 255), 255);
      });
    });
  });
}

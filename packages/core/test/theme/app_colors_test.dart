import 'package:core/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    group('cores primárias', () {
      test('primary é definida', () {
        expect(AppColors.primary, isA<Color>());
      });

      test('primaryLight é mais clara que primary', () {
        // primaryLight deve ter valor ARGB diferente de primary
        expect(AppColors.primaryLight, isNot(equals(AppColors.primary)));
      });

      test('primaryDark é mais escura que primary', () {
        expect(AppColors.primaryDark, isNot(equals(AppColors.primary)));
      });
    });

    group('cores secundárias', () {
      test('secondary é definida', () {
        expect(AppColors.secondary, isA<Color>());
      });

      test('secondaryLight é definida', () {
        expect(AppColors.secondaryLight, isA<Color>());
      });

      test('secondaryDark é definida', () {
        expect(AppColors.secondaryDark, isA<Color>());
      });
    });

    group('cores semânticas', () {
      test('error é definida', () {
        expect(AppColors.error, isA<Color>());
      });

      test('success é definida', () {
        expect(AppColors.success, isA<Color>());
      });

      test('warning é definida', () {
        expect(AppColors.warning, isA<Color>());
      });
    });

    group('cores neutras', () {
      test('surface é definida', () {
        expect(AppColors.surface, isA<Color>());
      });

      test('surfaceDark é definida', () {
        expect(AppColors.surfaceDark, isA<Color>());
      });

      test('onSurface é definida', () {
        expect(AppColors.onSurface, isA<Color>());
      });

      test('onSurfaceDark é definida', () {
        expect(AppColors.onSurfaceDark, isA<Color>());
      });
    });

    group('opacidade', () {
      test('todas as cores têm opacidade total (alpha = 255)', () {
        final colors = [
          AppColors.primary,
          AppColors.primaryLight,
          AppColors.primaryDark,
          AppColors.secondary,
          AppColors.secondaryLight,
          AppColors.secondaryDark,
          AppColors.error,
          AppColors.success,
          AppColors.warning,
          AppColors.surface,
          AppColors.surfaceDark,
          AppColors.onSurface,
          AppColors.onSurfaceDark,
        ];

        for (final color in colors) {
          expect(
            (color.a * 255.0).round().clamp(0, 255),
            255,
            reason: '$color deve ter alpha = 255',
          );
        }
      });
    });

    group('distinção entre paletas', () {
      test('primary e secondary são cores distintas', () {
        expect(AppColors.primary, isNot(equals(AppColors.secondary)));
      });

      test('surface e surfaceDark são cores distintas', () {
        expect(AppColors.surface, isNot(equals(AppColors.surfaceDark)));
      });

      test('error e success são cores distintas', () {
        expect(AppColors.error, isNot(equals(AppColors.success)));
      });
    });
  });
}

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter_test/flutter_test.dart';

/// Vocabulario, no valores: nombra los tamaños y estados del sistema.
void main() {
  group('UiSize', () {
    test('tiene tres escalones, de menor a mayor', () {
      expect(UiSize.values, <UiSize>[
        UiSize.small,
        UiSize.medium,
        UiSize.large,
      ]);
    });
  });

  group('UiStatus', () {
    test('cubre los cuatro estados que comunican los componentes', () {
      expect(UiStatus.values, <UiStatus>[
        UiStatus.info,
        UiStatus.success,
        UiStatus.warning,
        UiStatus.error,
      ]);
    });
  });

  group('UiSizes', () {
    test('la escala cruda no tiene valores repetidos', () {
      // Dos nombres para el mismo número confundirían al cambiar uno.
      const List<double> scale = <double>[
        UiSizes.size2,
        UiSizes.size3,
        UiSizes.size4,
        UiSizes.size8,
        UiSizes.size16,
        UiSizes.size18,
        UiSizes.size22,
        UiSizes.size24,
        UiSizes.size28,
        UiSizes.size32,
        UiSizes.size44,
        UiSizes.size48,
        UiSizes.size56,
        UiSizes.size64,
        UiSizes.size80,
        UiSizes.size200,
        UiSizes.size600,
        UiSizes.size900,
        UiSizes.size1200,
      ];

      expect(scale.toSet(), hasLength(scale.length));
      expect(scale, orderedEquals(<double>[...scale]..sort()));
    });

    test('cada constante vale lo que dice su nombre', () {
      // El nombre es el contrato: un `size16` que midiera 18 sería una trampa.
      expect(UiSizes.size16, 16);
      expect(UiSizes.size64, 64);
      expect(UiSizes.size1200, 1200);
    });
  });
}

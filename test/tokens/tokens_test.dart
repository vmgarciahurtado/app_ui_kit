import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Decisiones que heredan todos los componentes de la app consumidora.
void main() {
  group('UiSpacing', () {
    test('la escala crece de forma monótona y sin repetidos', () {
      const List<double> scale = <double>[
        UiSpacing.extraExtraSmall,
        UiSpacing.extraSmall,
        UiSpacing.small,
        UiSpacing.medium,
        UiSpacing.large,
        UiSpacing.extraLarge,
        UiSpacing.extraExtraLarge,
      ];

      expect(scale, orderedEquals(<double>[...scale]..sort()));
      expect(scale.toSet(), hasLength(scale.length));
    });
  });

  group('UiRadius', () {
    test('los radios crecen y el completo es el mayor', () {
      expect(UiRadius.small, lessThan(UiRadius.medium));
      expect(UiRadius.medium, lessThan(UiRadius.large));
      expect(UiRadius.full, greaterThanOrEqualTo(UiRadius.large));
    });

    test('los BorderRadius listos coinciden con su valor crudo', () {
      // Los componentes usan las dos formas: separarlas daría dos esquinas.
      expect(
        UiRadius.borderMedium,
        BorderRadius.circular(UiRadius.medium),
      );
      expect(
        UiRadius.borderLarge,
        BorderRadius.circular(UiRadius.large),
      );
    });
  });

  group('UiIconSize', () {
    test('la escala crece de forma monótona', () {
      const List<double> scale = <double>[
        UiIconSize.small,
        UiIconSize.medium,
        UiIconSize.extraLarge,
      ];

      expect(scale, orderedEquals(<double>[...scale]..sort()));
    });
  });

  group('UiBreakpoints', () {
    test('los puntos de quiebre crecen de móvil a escritorio', () {
      expect(UiBreakpoints.mobile, lessThan(UiBreakpoints.tablet));
      expect(UiBreakpoints.tablet, lessThan(UiBreakpoints.desktop));
    });

    test('salen de la escala cruda, no de números sueltos', () {
      expect(UiBreakpoints.mobile, UiSizes.size600);
      expect(UiBreakpoints.tablet, UiSizes.size900);
      expect(UiBreakpoints.desktop, UiSizes.size1200);
    });
  });
}

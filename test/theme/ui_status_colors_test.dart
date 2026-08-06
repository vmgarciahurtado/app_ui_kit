import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('defaults', () {
    test('claro y oscuro son juegos distintos', () {
      expect(UiStatusColors.light.success, isNot(UiStatusColors.dark.success));
      expect(UiStatusColors.light.warning, isNot(UiStatusColors.dark.warning));
      expect(UiStatusColors.light.info, isNot(UiStatusColors.dark.info));
    });
  });

  group('copyWith', () {
    test('cambiar el éxito deja intactos los otros dos', () {
      final UiStatusColors changed = UiStatusColors.light.copyWith(
        success: const Color(0xFF00FF00),
      );

      expect(changed.success, const Color(0xFF00FF00));
      expect(changed.warning, UiStatusColors.light.warning);
      expect(changed.info, UiStatusColors.light.info);
    });

    test('cambiar solo la advertencia conserva el éxito y la info', () {
      // El caso espejo: cada campo cae en su valor previo, no en el de al lado.
      final UiStatusColors changed = UiStatusColors.light.copyWith(
        warning: const Color(0xFFFFFF00),
      );

      expect(changed.warning, const Color(0xFFFFFF00));
      expect(changed.success, UiStatusColors.light.success);
      expect(changed.info, UiStatusColors.light.info);
    });

    test('sin argumentos devuelve los mismos colores', () {
      final UiStatusColors same = UiStatusColors.dark.copyWith();

      expect(same.success, UiStatusColors.dark.success);
      expect(same.warning, UiStatusColors.dark.warning);
      expect(same.info, UiStatusColors.dark.info);
    });
  });

  group('lerp', () {
    test('al final de la interpolación llega al otro juego', () {
      final UiStatusColors end = UiStatusColors.light.lerp(
        UiStatusColors.dark,
        1,
      );

      expect(end.success, UiStatusColors.dark.success);
      expect(end.warning, UiStatusColors.dark.warning);
      expect(end.info, UiStatusColors.dark.info);
    });

    test('a mitad de camino no coincide con ninguno de los extremos', () {
      final UiStatusColors mid = UiStatusColors.light.lerp(
        UiStatusColors.dark,
        0.5,
      );

      expect(mid.success, isNot(UiStatusColors.light.success));
      expect(mid.success, isNot(UiStatusColors.dark.success));
    });

    test('contra otra extensión se queda como está', () {
      // Material llama a lerp en las transiciones de tema.
      expect(
        UiStatusColors.light.lerp(null, 0.5).success,
        UiStatusColors.light.success,
      );
    });
  });
}

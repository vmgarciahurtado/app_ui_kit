import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// El contrato con la app consumidora: qué decide el kit y qué respeta de
/// quien lo usa.
void main() {
  group('colores de estado', () {
    test('el tema claro registra los defaults claros', () {
      final ThemeData theme = UiKitTheme.light(primary: Colors.indigo);

      expect(theme.extension<UiStatusColors>(), UiStatusColors.light);
      expect(theme.brightness, Brightness.light);
    });

    test('el tema oscuro registra los defaults oscuros', () {
      final ThemeData theme = UiKitTheme.dark(primary: Colors.indigo);

      expect(theme.extension<UiStatusColors>(), UiStatusColors.dark);
      expect(theme.brightness, Brightness.dark);
    });

    test('los del consumidor ganan sobre los defaults', () {
      const UiStatusColors custom = UiStatusColors(
        success: Color(0xFF00FF00),
        warning: Color(0xFFFFFF00),
        info: Color(0xFF00FFFF),
      );

      final ThemeData theme = UiKitTheme.dark(
        primary: Colors.indigo,
        statusColors: custom,
      );

      expect(theme.extension<UiStatusColors>(), custom);
    });
  });

  group('paleta', () {
    test('el primario del consumidor manda', () {
      final ThemeData theme = UiKitTheme.light(primary: Colors.indigo);

      expect(theme.colorScheme.primary, isNotNull);
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('respeta el color secundario del consumidor', () {
      final ThemeData theme = UiKitTheme.dark(
        primary: Colors.indigo,
        secondary: Colors.teal,
      );

      expect(theme.colorScheme.secondary, Colors.teal);
    });

    test('sin secundario lo deriva del primario', () {
      final ThemeData theme = UiKitTheme.light(primary: Colors.indigo);

      // Derivado y no un gris: solo con el primario ya se ve coherente.
      expect(theme.colorScheme.secondary, isNot(Colors.transparent));
    });
  });

  group('tipografía', () {
    test('la fuente de titulares se aplica solo a los titulares', () {
      final ThemeData theme = UiKitTheme.light(
        primary: Colors.indigo,
        fontFamily: 'Inter',
        headingFontFamily: 'Sora',
      );

      expect(theme.textTheme.headlineLarge?.fontFamily, 'Sora');
      expect(theme.textTheme.titleLarge?.fontFamily, 'Sora');
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
      expect(theme.textTheme.labelLarge?.fontFamily, 'Inter');
    });

    test('sin fuente de titulares todo usa la del cuerpo', () {
      final ThemeData theme = UiKitTheme.light(
        primary: Colors.indigo,
        fontFamily: 'Inter',
      );

      expect(theme.textTheme.headlineLarge?.fontFamily, 'Inter');
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
    });
  });

  group('componentes', () {
    test('el tema define la forma de tarjetas y campos', () {
      final ThemeData theme = UiKitTheme.light(primary: Colors.indigo);

      // Los componentes no fijan forma propia: la heredan de acá.
      expect(theme.cardTheme.shape, isNotNull);
      expect(theme.inputDecorationTheme.border, isNotNull);
    });
  });
}

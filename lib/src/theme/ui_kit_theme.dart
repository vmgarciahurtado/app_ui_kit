import 'package:flutter/material.dart';

import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';
import 'ui_status_colors.dart';

/// Construye el [ThemeData] del sistema de diseño.
///
/// El consumidor controla la identidad visual (colores de marca, fuentes y
/// colores de estado); el sistema aporta la consistencia (radios, espaciados
/// y estilos de componentes derivados de los tokens).
///
/// ```dart
/// MaterialApp(
///   theme: UiKitTheme.light(primary: Colors.indigo),
///   darkTheme: UiKitTheme.dark(primary: Colors.indigo),
/// );
/// ```
abstract final class UiKitTheme {
  static ThemeData light({
    required Color primary,
    Color? secondary,
    String? fontFamily,
    String? headingFontFamily,
    UiStatusColors statusColors = UiStatusColors.light,
  }) {
    return _build(
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      fontFamily: fontFamily,
      headingFontFamily: headingFontFamily,
      statusColors: statusColors,
    );
  }

  static ThemeData dark({
    required Color primary,
    Color? secondary,
    String? fontFamily,
    String? headingFontFamily,
    UiStatusColors statusColors = UiStatusColors.dark,
  }) {
    return _build(
      brightness: Brightness.dark,
      primary: primary,
      secondary: secondary,
      fontFamily: fontFamily,
      headingFontFamily: headingFontFamily,
      statusColors: statusColors,
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color? secondary,
    required String? fontFamily,
    required String? headingFontFamily,
    required UiStatusColors statusColors,
  }) {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    );
    if (secondary != null) {
      colorScheme = colorScheme.copyWith(secondary: secondary);
    }

    const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
      borderRadius: UiRadius.borderMedium,
    );
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: UiSpacing.large,
      vertical: UiSpacing.medium,
    );

    final ThemeData theme = ThemeData(
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      extensions: <ThemeExtension<dynamic>>[statusColors],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: UiSpacing.medium,
          vertical: UiSpacing.medium,
        ),
        border: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        shape: const RoundedRectangleBorder(borderRadius: UiRadius.borderLarge),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        margin: EdgeInsets.zero,
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: UiRadius.borderFull),
        padding: EdgeInsets.symmetric(
          horizontal: UiSpacing.small,
          vertical: UiSpacing.extraSmall,
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(
            colorScheme.surfaceContainer,
          ),
          surfaceTintColor: const WidgetStatePropertyAll<Color>(
            Colors.transparent,
          ),
          elevation: const WidgetStatePropertyAll<double>(6),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: UiRadius.borderMedium),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              vertical: UiSpacing.small,
              horizontal: UiSpacing.extraSmall,
            ),
          ),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: MenuItemButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: UiRadius.borderSmall,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UiSpacing.medium,
            vertical: UiSpacing.small,
          ),
        ),
      ),
    );

    if (headingFontFamily == null) return theme;
    return theme.copyWith(
      textTheme: _withHeadingFont(
        base: theme.textTheme,
        fontFamily: headingFontFamily,
      ),
    );
  }

  /// Aplica la fuente de titulares a los estilos display, headline y
  /// titleLarge, dejando el resto con la fuente base.
  static TextTheme _withHeadingFont({
    required TextTheme base,
    required String fontFamily,
  }) {
    TextStyle? heading({TextStyle? style}) =>
        style?.copyWith(fontFamily: fontFamily);
    return base.copyWith(
      displayLarge: heading(style: base.displayLarge),
      displayMedium: heading(style: base.displayMedium),
      displaySmall: heading(style: base.displaySmall),
      headlineLarge: heading(style: base.headlineLarge),
      headlineMedium: heading(style: base.headlineMedium),
      headlineSmall: heading(style: base.headlineSmall),
      titleLarge: heading(style: base.titleLarge),
    );
  }
}

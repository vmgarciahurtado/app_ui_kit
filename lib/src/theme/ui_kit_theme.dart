import 'package:flutter/material.dart';

import '../tokens/ui_fonts.dart';
import '../tokens/ui_palette.dart';
import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';
import '../tokens/ui_status_colors.dart';

/// Construye el [ThemeData] del sistema de diseño. Sin argumentos ya trae la
/// paleta, las fuentes y los colores de estado del sistema.
///
/// ```dart
/// MaterialApp(
///   theme: UiKitTheme.light(),
///   darkTheme: UiKitTheme.dark(),
/// );
/// ```
abstract final class UiKitTheme {
  static ThemeData light({
    UiPalette palette = UiPalette.light,
    String fontFamily = UiFonts.body,
    String headingFontFamily = UiFonts.heading,
    UiStatusColors statusColors = UiStatusColors.light,
  }) {
    return _build(
      brightness: Brightness.light,
      palette: palette,
      fontFamily: fontFamily,
      headingFontFamily: headingFontFamily,
      statusColors: statusColors,
    );
  }

  static ThemeData dark({
    UiPalette palette = UiPalette.dark,
    String fontFamily = UiFonts.body,
    String headingFontFamily = UiFonts.heading,
    UiStatusColors statusColors = UiStatusColors.dark,
  }) {
    return _build(
      brightness: Brightness.dark,
      palette: palette,
      fontFamily: fontFamily,
      headingFontFamily: headingFontFamily,
      statusColors: statusColors,
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required UiPalette palette,
    required String fontFamily,
    required String headingFontFamily,
    required UiStatusColors statusColors,
  }) {
    final ColorScheme colorScheme = _schemeFrom(
      palette: palette,
      brightness: brightness,
    );

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
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      dividerColor: palette.outline,
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
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: palette.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: UiSpacing.medium,
          vertical: UiSpacing.medium,
        ),
        border: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: palette.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: palette.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: palette.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: palette.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: UiRadius.borderMedium,
          borderSide: BorderSide(color: palette.danger, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: UiRadius.borderLarge,
          side: BorderSide(color: palette.outline),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: palette.surface,
        margin: EdgeInsets.zero,
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: UiRadius.borderFull),
        padding: EdgeInsets.symmetric(
          horizontal: UiSpacing.small,
          vertical: UiSpacing.extraSmall,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.surfaceRaised,
        contentTextStyle: TextStyle(color: palette.onSurface),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: UiRadius.borderMedium,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(UiRadius.large),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(palette.surfaceRaised),
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

    return theme.copyWith(
      textTheme: _textTheme(
        base: theme.textTheme,
        headingFontFamily: headingFontFamily,
        onSurface: palette.onSurface,
      ),
    );
  }

  /// Mapea la paleta a los roles de [ColorScheme].
  ///
  /// Deriva del acento los roles que la paleta no nombra (contenedores,
  /// terciarios) e impone los que sí: Material 3 no deriva bien las
  /// superficies a partir de un acento muy saturado.
  static ColorScheme _schemeFrom({
    required UiPalette palette,
    required Brightness brightness,
  }) {
    return ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: brightness,
    ).copyWith(
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      surface: palette.background,
      onSurface: palette.onSurface,
      surfaceContainerLowest: palette.background,
      surfaceContainerLow: palette.surface,
      surfaceContainer: palette.surface,
      surfaceContainerHigh: palette.surfaceRaised,
      surfaceContainerHighest: palette.surfaceRaised,
      onSurfaceVariant: palette.onSurfaceMuted,
      outline: palette.outline,
      outlineVariant: palette.outline,
      error: palette.danger,
      onError: palette.onDanger,
    );
  }

  /// Tipografía del sistema: titulares compactos en peso alto y etiquetas con
  /// más peso y tracking. [headingFontFamily] solo alcanza a los titulares.
  static TextTheme _textTheme({
    required TextTheme base,
    required String headingFontFamily,
    required Color onSurface,
  }) {
    TextStyle? heading(TextStyle? style) => style?.copyWith(
      fontFamily: headingFontFamily,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.8,
      height: 1.05,
      color: onSurface,
    );
    return base.copyWith(
      displayLarge: heading(base.displayLarge),
      displayMedium: heading(base.displayMedium),
      displaySmall: heading(base.displaySmall),
      headlineLarge: heading(base.headlineLarge),
      headlineMedium: heading(base.headlineMedium),
      headlineSmall: heading(base.headlineSmall),
      titleLarge: heading(base.titleLarge),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
    );
  }
}

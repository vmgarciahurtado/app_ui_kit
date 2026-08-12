import 'package:flutter/material.dart';

import '../tokens/ui_status_colors.dart';

/// Acceso directo y limpio al diseño (Theme y colores de estado) desde el
/// [BuildContext].
///
/// ```dart
/// Text(
///   '¡Operación exitosa!',
///   style: context.textTheme.bodyLarge?.copyWith(
///     color: context.statusColors.success,
///   ),
/// );
/// ```
extension BuildContextThemeExtension on BuildContext {
  /// Acceso rápido al [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Acceso directo al [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Acceso directo al [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Colores de estado personalizados del sistema.
  /// Si no están registrados en el tema, usa los valores por defecto (light).
  UiStatusColors get statusColors =>
      theme.extension<UiStatusColors>() ?? UiStatusColors.light;
}

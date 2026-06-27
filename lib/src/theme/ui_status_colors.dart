import 'package:flutter/material.dart';

/// Colores de estado que Material [ColorScheme] no cubre nativamente
/// (solo trae `error`). Los usan componentes como banners y chips.
///
/// Se registra como [ThemeExtension] en `UiKitTheme`, por lo que el
/// consumidor puede sobreescribir los defaults al construir su tema y
/// leerlos en cualquier parte con `context.statusColors`.
@immutable
class UiStatusColors extends ThemeExtension<UiStatusColors> {
  const UiStatusColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color info;

  /// Valores por defecto para tema claro.
  static const UiStatusColors light = UiStatusColors(
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    info: Color(0xFF2563EB),
  );

  /// Valores por defecto para tema oscuro.
  static const UiStatusColors dark = UiStatusColors(
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
  );

  @override
  UiStatusColors copyWith({Color? success, Color? warning, Color? info}) {
    return UiStatusColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  UiStatusColors lerp(ThemeExtension<UiStatusColors>? other, double t) {
    if (other is! UiStatusColors) return this;
    return UiStatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

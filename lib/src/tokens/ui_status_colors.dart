import 'package:flutter/material.dart';

import '../foundations/ui_colors.dart';

/// Colores de estado que Material [ColorScheme] no cubre nativamente
/// (solo trae `error`). Se leen con `context.statusColors`.
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
    success: UiColors.greenDeep,
    warning: UiColors.orangeDeep,
    info: UiColors.blueDeep,
  );

  /// Valores por defecto para tema oscuro.
  static const UiStatusColors dark = UiStatusColors(
    success: UiColors.green,
    warning: UiColors.orange,
    info: UiColors.magenta,
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
    if (other is UiStatusColors) {
      return UiStatusColors(
        success: Color.lerp(success, other.success, t) ?? other.success,
        warning: Color.lerp(warning, other.warning, t) ?? other.warning,
        info: Color.lerp(info, other.info, t) ?? other.info,
      );
    }
    return this;
  }
}

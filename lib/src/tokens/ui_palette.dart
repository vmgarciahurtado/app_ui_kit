import 'package:flutter/material.dart';

import '../foundations/ui_colors.dart';

/// Paleta semántica del sistema de diseño: cada campo nombra un rol de la
/// interfaz, no un color concreto.
@immutable
class UiPalette {
  const UiPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.surfaceRaised,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.outline,
    required this.danger,
    required this.onDanger,
  });

  /// Acento principal de la marca.
  final Color primary;

  /// Contenido que va encima de [primary].
  final Color onPrimary;

  /// Acento secundario, para realces y elementos de apoyo.
  final Color secondary;

  /// Contenido que va encima de [secondary].
  final Color onSecondary;

  /// Fondo de la app (scaffold y canvas).
  final Color background;

  /// Fondo de tarjetas y campos, un paso por encima de [background].
  final Color surface;

  /// Fondo de elementos elevados: menús, snackbars, chips sin seleccionar.
  final Color surfaceRaised;

  /// Contenido principal sobre [background] y [surface].
  final Color onSurface;

  /// Contenido secundario: subtítulos, hints, íconos de apoyo.
  final Color onSurfaceMuted;

  /// Bordes y separadores.
  final Color outline;

  /// Error y acciones destructivas. Alimenta `ColorScheme.error`; el resto de
  /// los estados vive en [UiStatusColors].
  final Color danger;

  /// Contenido que va encima de [danger].
  final Color onDanger;

  /// Identidad por defecto del sistema en oscuro: acentos neón sobre negro.
  static const UiPalette dark = UiPalette(
    primary: UiColors.yellow,
    onPrimary: UiColors.black,
    secondary: UiColors.magenta,
    onSecondary: UiColors.black,
    background: UiColors.ink900,
    surface: UiColors.ink800,
    surfaceRaised: UiColors.ink700,
    onSurface: UiColors.white,
    onSurfaceMuted: UiColors.ink300,
    outline: UiColors.ink600,
    danger: UiColors.red,
    onDanger: UiColors.black,
  );

  /// Identidad por defecto del sistema en claro: los mismos acentos sobre
  /// neutros claros, con estados en tono saturado para que contrasten.
  static const UiPalette light = UiPalette(
    primary: UiColors.yellow,
    onPrimary: UiColors.black,
    secondary: UiColors.magenta,
    onSecondary: UiColors.white,
    background: UiColors.white,
    surface: UiColors.paper100,
    surfaceRaised: UiColors.paper200,
    onSurface: UiColors.ink900,
    onSurfaceMuted: UiColors.paper700,
    outline: UiColors.paper300,
    danger: UiColors.redDeep,
    onDanger: UiColors.white,
  );

  UiPalette copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? surface,
    Color? surfaceRaised,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? outline,
    Color? danger,
    Color? onDanger,
  }) {
    return UiPalette(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      outline: outline ?? this.outline,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
    );
  }
}

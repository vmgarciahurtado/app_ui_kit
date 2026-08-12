import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';

/// Roles tipográficos del sistema de diseño.
enum UiTextStyle {
  /// Cifra o palabra protagonista de una pantalla.
  display,

  /// Título de pantalla.
  headline,

  /// Título de sección.
  title,

  /// Título de una tarjeta o de un bloque dentro de una sección.
  subtitle,

  /// Texto corrido.
  body,

  /// Texto corrido secundario: apoyo, descripciones, metadatos.
  bodySmall,

  /// Etiqueta corta: estados, contadores, pies.
  label,
}

/// Texto del sistema de diseño.
///
/// Toma el estilo de un rol y no de un `TextStyle` suelto, para que la
/// tipografía se decida en el tema y no en cada pantalla.
///
/// ```dart
/// UiText('Festival Indie', style: UiTextStyle.subtitle, maxLines: 1);
/// ```
class UiText extends StatelessWidget {
  const UiText(
    this.data, {
    super.key,
    this.style = UiTextStyle.body,
    this.color,
    this.align,
    this.maxLines,
    this.weight,
    this.letterSpacing,
  });

  final String data;
  final UiTextStyle style;

  /// Por defecto, el color que el tema asigna al rol.
  final Color? color;
  final TextAlign? align;

  /// Si se indica, el texto se recorta con puntos suspensivos.
  final int? maxLines;

  /// Refuerzo puntual del peso. Usarlo solo cuando el rol no alcance.
  final FontWeight? weight;

  /// Tracking puntual, para textos en mayúsculas que necesitan aire.
  final double? letterSpacing;

  TextStyle? _resolve(BuildContext context) {
    final TextTheme theme = context.textTheme;
    return switch (style) {
      UiTextStyle.display => theme.displaySmall,
      UiTextStyle.headline => theme.headlineSmall,
      UiTextStyle.title => theme.titleLarge,
      UiTextStyle.subtitle => theme.titleMedium,
      UiTextStyle.body => theme.bodyLarge,
      UiTextStyle.bodySmall => theme.bodyMedium,
      UiTextStyle.label => theme.labelSmall,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: _resolve(context)?.copyWith(
        color: color,
        fontWeight: weight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

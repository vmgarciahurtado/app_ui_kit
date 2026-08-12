import 'package:flutter/material.dart';

import '../foundations/ui_colors.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';

/// Etiqueta compacta de solo lectura.
///
/// A diferencia de `UiChip`, no es interactiva ni ocupa altura de control:
/// sirve para marcar contenido (un estado, una categoría, un precio).
///
/// ```dart
/// UiTag(label: 'Confirmada', color: context.statusColors.success);
/// UiTag(label: 'Gratis', onImage: true);   // encima de una foto
/// ```
class UiTag extends StatelessWidget {
  const UiTag({
    required this.label,
    super.key,
    this.color,
    this.onImage = false,
  });

  final String label;

  /// Tiñe la etiqueta: el texto toma este color y el fondo, una versión
  /// translúcida del mismo. Pensado para estados.
  final Color? color;

  /// Etiqueta pensada para ir encima de una imagen: fondo oscuro translúcido
  /// y texto claro, legible sobre cualquier foto.
  final bool onImage;

  /// Opacidad del fondo cuando la etiqueta va teñida.
  static const double _tint = 0.15;

  /// Opacidad del velo cuando la etiqueta va encima de una imagen.
  static const double _veil = 0.35;

  @override
  Widget build(BuildContext context) {
    final Color foreground;
    final Color background;
    if (onImage) {
      foreground = UiColors.white;
      background = UiColors.black.withValues(alpha: _veil);
    } else if (color != null) {
      foreground = color!;
      background = color!.withValues(alpha: _tint);
    } else {
      foreground = context.colorScheme.onSurfaceVariant;
      background = context.colorScheme.surfaceContainerHigh;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: UiSpacing.small,
        vertical: UiSpacing.extraExtraSmall,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: UiRadius.borderFull,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

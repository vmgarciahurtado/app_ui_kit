import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';
import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';

/// Tipos de mensaje de [UiBanner].
enum UiBannerVariant { info, success, warning, error }

/// Banner para mensajes contextuales (información, éxito, advertencia o
/// error).
///
/// Los colores salen de `UiStatusColors` (registrado por `UiKitTheme`) y del
/// `ColorScheme`, por lo que se adaptan al tema claro/oscuro y a los
/// overrides del consumidor.
///
/// ```dart
/// UiBanner(
///   variant: .success,
///   title: 'Cambios guardados',
///   message: 'Tu perfil se actualizó correctamente.',
///   onClose: () => setState(() => showBanner = false),
/// );
/// ```
class UiBanner extends StatelessWidget {
  const UiBanner({
    super.key,
    required this.message,
    this.variant = .info,
    this.title,
    this.onClose,
  });

  final String message;
  final UiBannerVariant variant;

  /// Título opcional en negrita sobre el mensaje.
  final String? title;

  /// Si no es null, muestra el botón de cerrar.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final color = switch (variant) {
      .info => context.statusColors.info,
      .success => context.statusColors.success,
      .warning => context.statusColors.warning,
      .error => context.colorScheme.error,
    };
    final icon = switch (variant) {
      .info => Icons.info_outline,
      .success => Icons.check_circle_outline,
      .warning => Icons.warning_amber_outlined,
      .error => Icons.error_outline,
    };

    return Container(
      padding: const EdgeInsets.all(UiSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: UiRadius.borderMd,
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: UiSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: color,
                    ),
                  ),
                  const SizedBox(height: UiSpacing.xs),
                ],
                Text(message, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close, size: 18),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../foundations/ui_status.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_icon_size.dart';
import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';

/// Banner para mensajes contextuales (información, éxito, advertencia o
/// error).
///
/// El estado se expresa con el vocabulario compartido [UiStatus]; los
/// colores salen de `UiStatusColors` (registrado por `UiKitTheme`) y del
/// `ColorScheme`, por lo que se adaptan al tema claro/oscuro y a los
/// overrides del consumidor.
///
/// ```dart
/// UiBanner(
///   status: UiStatus.success,
///   title: 'Cambios guardados',
///   message: 'Tu perfil se actualizó correctamente.',
///   onClose: () => setState(() => showBanner = false),
/// );
/// ```
class UiBanner extends StatelessWidget {
  const UiBanner({
    required this.message,
    super.key,
    this.status = UiStatus.info,
    this.title,
    this.onClose,
  });

  final String message;
  final UiStatus status;

  /// Título opcional en negrita sobre el mensaje.
  final String? title;

  /// Si no es null, muestra el botón de cerrar.
  final VoidCallback? onClose;

  /// Opacidad del color de estado usada como fondo del banner.
  static const double _backgroundAlpha = 0.12;

  /// Opacidad del color de estado usada en el borde del banner.
  static const double _borderAlpha = 0.4;

  @override
  Widget build(BuildContext context) {
    final String? title = this.title;
    final Color color = switch (status) {
      UiStatus.info => context.statusColors.info,
      UiStatus.success => context.statusColors.success,
      UiStatus.warning => context.statusColors.warning,
      UiStatus.error => context.colorScheme.error,
    };
    final IconData icon = switch (status) {
      UiStatus.info => Icons.info_outline,
      UiStatus.success => Icons.check_circle_outline,
      UiStatus.warning => Icons.warning_amber_outlined,
      UiStatus.error => Icons.error_outline,
    };

    return Container(
      padding: const EdgeInsets.all(UiSpacing.medium),
      decoration: BoxDecoration(
        color: color.withValues(alpha: _backgroundAlpha),
        borderRadius: UiRadius.borderMedium,
        border: Border.all(color: color.withValues(alpha: _borderAlpha)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: UiIconSize.medium),
          const SizedBox(width: UiSpacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null) ...<Widget>[
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: color,
                    ),
                  ),
                  const SizedBox(height: UiSpacing.extraSmall),
                ],
                Text(message, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close, size: UiIconSize.small),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

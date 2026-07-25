import 'package:flutter/material.dart';

import '../atoms/ui_button.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_icon_size.dart';
import '../tokens/ui_spacing.dart';

/// Vista de confirmación con ícono, título, mensaje y acción principal.
///
/// Pensada para pantallas de éxito (ej. "¡Contraseña actualizada!"). Si no se
/// pasa [icon], usa un check con el color de éxito del tema, por lo que no
/// requiere ningún asset del consumidor.
class UiSuccessView extends StatelessWidget {
  const UiSuccessView({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    super.key,
    this.message,
    this.icon,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;
  final String? message;

  /// Ícono superior. Por defecto un check con `statusColors.success`.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final String? message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(UiSpacing.extraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon ??
                Icon(
                  Icons.check_circle_rounded,
                  size: UiIconSize.extraLarge,
                  color: context.statusColors.success,
                ),
            const SizedBox(height: UiSpacing.large),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: UiSpacing.small),
              Text(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: UiSpacing.extraLarge),
            UiButton(label: actionLabel, expanded: true, onPressed: onAction),
          ],
        ),
      ),
    );
  }
}

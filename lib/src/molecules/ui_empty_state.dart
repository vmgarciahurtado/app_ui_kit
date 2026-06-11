import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Estado vacío para listas o pantallas sin contenido.
///
/// ```dart
/// UiEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'Sin mensajes',
///   message: 'Cuando recibas mensajes aparecerán aquí.',
///   action: UiButton(label: 'Actualizar', onPressed: _refresh),
/// );
/// ```
class UiEmptyState extends StatelessWidget {
  const UiEmptyState({
    super.key,
    required this.title,
    this.icon = Icons.inbox_outlined,
    this.message,
    this.action,
  });

  final String title;
  final IconData icon;
  final String? message;

  /// Acción opcional debajo del mensaje, típicamente un `UiButton`.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(UiSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 56,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: UiSpacing.md),
            Text(
              title,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: UiSpacing.sm),
              Text(
                message!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: UiSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

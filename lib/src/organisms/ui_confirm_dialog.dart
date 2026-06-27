import 'package:flutter/material.dart';

import '../atoms/ui_button.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_radius.dart';
import '../tokens/ui_spacing.dart';

/// Diálogo de confirmación del sistema de diseño.
///
/// Organismo que compone átomos ([UiButton]) y tokens para ofrecer una
/// confirmación consistente en toda la app. Usar [show] para abrirlo:
///
/// ```dart
/// final confirmed = await UiConfirmDialog.show(
///   context,
///   title: '¿Eliminar elemento?',
///   message: 'Esta acción no se puede deshacer.',
///   confirmLabel: 'Eliminar',
///   danger: true,
/// );
/// if (confirmed == true) _delete();
/// ```
class UiConfirmDialog extends StatelessWidget {
  const UiConfirmDialog({
    required this.title,
    required this.message,
    super.key,
    this.confirmLabel = 'Confirmar',
    this.cancelLabel = 'Cancelar',
    this.danger = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  /// Resalta la acción de confirmar con el color de error del tema.
  final bool danger;

  /// Abre el diálogo y resuelve con `true` si el usuario confirma,
  /// `false` si cancela y `null` si lo descarta.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool danger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => UiConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        danger: danger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: UiRadius.borderLg),
      icon: danger
          ? Icon(Icons.warning_amber_outlined, color: context.colorScheme.error)
          : null,
      title: Text(title),
      content: Text(message, style: context.textTheme.bodyMedium),
      actionsPadding: const EdgeInsets.all(UiSpacing.md),
      actions: <Widget>[
        UiButton(
          label: cancelLabel,
          variant: .ghost,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        UiButton(
          label: confirmLabel,
          variant: danger ? .danger : .primary,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

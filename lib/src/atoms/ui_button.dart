import 'package:flutter/material.dart';

import '../foundations/ui_size.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_icon_size.dart';
import '../tokens/ui_spacing.dart';
import 'ui_loader.dart';

/// Variantes visuales de [UiButton], en orden de énfasis.
enum UiButtonVariant {
  /// Acción principal de la pantalla (relleno con el color primario).
  primary,

  /// Acción secundaria (relleno tonal).
  secondary,

  /// Acción de énfasis medio (solo borde).
  outline,

  /// Acción de bajo énfasis (solo texto).
  ghost,

  /// Acción destructiva (relleno con el color de error del tema).
  danger,
}

/// Botón del sistema de diseño.
///
/// Actúa como fachada sobre los botones de Material para que hereden el
/// estilo definido en `UiKitTheme`, agregando estado de carga y variantes
/// con una sola API.
///
/// ```dart
/// UiButton(
///   label: 'Guardar',
///   icon: Icons.check,
///   loading: saving,
///   onPressed: _save,
/// );
/// ```
class UiButton extends StatelessWidget {
  const UiButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = UiButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.expanded = false,
  });

  final String label;

  /// Si es null (o [loading] es true) el botón se muestra deshabilitado.
  final VoidCallback? onPressed;
  final UiButtonVariant variant;
  final IconData? icon;

  /// Muestra un indicador de progreso y deshabilita el botón.
  final bool loading;

  /// Ocupa todo el ancho disponible.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = loading ? null : onPressed;
    final Widget child = _content();

    final ButtonStyleButton button = switch (variant) {
      UiButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      UiButtonVariant.secondary => FilledButton.tonal(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      UiButtonVariant.outline => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      UiButtonVariant.ghost => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      UiButtonVariant.danger => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colorScheme.error,
          foregroundColor: context.colorScheme.onError,
        ),
        child: child,
      ),
    };

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _content() {
    if (loading) return const UiLoader(size: UiSize.small);
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: UiIconSize.small),
        const SizedBox(width: UiSpacing.small),
        Text(label),
      ],
    );
  }
}

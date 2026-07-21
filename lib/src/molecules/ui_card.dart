import 'package:flutter/material.dart';

import '../tokens/ui_spacing.dart';

/// Tarjeta del sistema de diseño.
///
/// Hereda forma, color y elevación de `UiKitTheme` y agrega padding
/// consistente y soporte opcional de tap con efecto ripple.
///
/// ```dart
/// UiCard(
///   onTap: () => context.push('/detail'),
///   child: Text('Contenido'),
/// );
/// ```
class UiCard extends StatelessWidget {
  const UiCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(UiSpacing.medium),
  });

  final Widget child;

  /// Si no es null, la tarjeta es interactiva (ripple incluido).
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final Padding content = Padding(padding: padding, child: child);

    return Card(
      child: onTap != null ? InkWell(onTap: onTap, child: content) : content,
    );
  }
}

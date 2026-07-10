import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Caja de relleno que representa el lugar de un organismo en una plantilla.
class PlaceholderBox extends StatelessWidget {
  const PlaceholderBox({required this.label, super.key, this.height = 120});

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: .center,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: UiRadius.borderLg,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Text(
        label,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

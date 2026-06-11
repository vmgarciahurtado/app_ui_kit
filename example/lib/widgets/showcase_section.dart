import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Sección del showcase: título, descripción opcional y las variantes
/// del componente dispuestas en un [Wrap].
class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: context.textTheme.titleMedium),
        if (description != null) ...[
          const SizedBox(height: UiSpacing.xs),
          Text(
            description!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: UiSpacing.md),
        Wrap(
          spacing: UiSpacing.md,
          runSpacing: UiSpacing.md,
          crossAxisAlignment: .center,
          children: children,
        ),
      ],
    );
  }
}

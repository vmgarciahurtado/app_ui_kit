import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Escala tipográfica de Material aplicada por UiKitTheme.
class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final styles = <(String, TextStyle?)>[
      ('displayLarge', text.displayLarge),
      ('headlineLarge', text.headlineLarge),
      ('headlineMedium', text.headlineMedium),
      ('titleLarge', text.titleLarge),
      ('titleMedium', text.titleMedium),
      ('bodyLarge', text.bodyLarge),
      ('bodyMedium', text.bodyMedium),
      ('bodySmall', text.bodySmall),
      ('labelLarge', text.labelLarge),
      ('labelSmall', text.labelSmall),
    ];

    return ShowcaseList(
      children: [
        ShowcaseSection(
          title: 'Escala tipográfica',
          description:
              'Tamaños de la escala Material. La fuente base y la de titulares '
              '(display, headline y titleLarge) se configuran en UiKitTheme.',
          children: [
            for (final (name, style) in styles)
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: .baseline,
                  textBaseline: .alphabetic,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        '$name · ${style?.fontSize?.toStringAsFixed(0)}px',
                        style: text.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(width: UiSpacing.md),
                    Expanded(
                      child: Text(
                        'Sistema de diseño',
                        style: style,
                        overflow: .ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

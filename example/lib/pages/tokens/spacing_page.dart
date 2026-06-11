import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Tokens de espaciado, radios y breakpoints.
class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const spacings = <(String, double)>[
      ('xxs', UiSpacing.xxs),
      ('xs', UiSpacing.xs),
      ('sm', UiSpacing.sm),
      ('md', UiSpacing.md),
      ('lg', UiSpacing.lg),
      ('xl', UiSpacing.xl),
      ('xxl', UiSpacing.xxl),
    ];
    const radii = <(String, double)>[
      ('sm', UiRadius.sm),
      ('md', UiRadius.md),
      ('lg', UiRadius.lg),
      ('full', UiRadius.full),
    ];
    const breakpoints = <(String, double)>[
      ('mobile', UiBreakpoints.mobile),
      ('tablet', UiBreakpoints.tablet),
      ('desktop', UiBreakpoints.desktop),
    ];

    return ShowcaseList(
      children: [
        ShowcaseSection(
          title: 'Espaciado (UiSpacing)',
          description: 'Escala basada en una grilla de 4px.',
          children: [
            for (final (name, value) in spacings)
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        '$name · ${value.toStringAsFixed(0)}px',
                        style: context.textTheme.labelSmall,
                      ),
                    ),
                    Container(
                      width: value * 4,
                      height: UiSpacing.md,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: UiRadius.borderSm,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        ShowcaseSection(
          title: 'Radios (UiRadius)',
          children: [
            for (final (name, value) in radii)
              Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(value),
                    ),
                  ),
                  const SizedBox(height: UiSpacing.xs),
                  Text(name, style: context.textTheme.labelSmall),
                ],
              ),
          ],
        ),
        ShowcaseSection(
          title: 'Breakpoints (UiBreakpoints)',
          description: 'Anchos de referencia para layouts responsivos.',
          children: [
            for (final (name, value) in breakpoints)
              UiChip(label: '$name ≥ ${value.toStringAsFixed(0)}px'),
          ],
        ),
      ],
    );
  }
}

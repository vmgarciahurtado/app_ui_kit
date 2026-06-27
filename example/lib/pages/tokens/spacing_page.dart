import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Tokens de espaciado, radios y breakpoints.
class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<(String, double)> spacings = <(String, double)>[
      ('xxs', UiSpacing.xxs),
      ('xs', UiSpacing.xs),
      ('sm', UiSpacing.sm),
      ('md', UiSpacing.md),
      ('lg', UiSpacing.lg),
      ('xl', UiSpacing.xl),
      ('xxl', UiSpacing.xxl),
    ];
    const List<(String, double)> radii = <(String, double)>[
      ('sm', UiRadius.sm),
      ('md', UiRadius.md),
      ('lg', UiRadius.lg),
      ('full', UiRadius.full),
    ];
    const List<(String, double)> breakpoints = <(String, double)>[
      ('mobile', UiBreakpoints.mobile),
      ('tablet', UiBreakpoints.tablet),
      ('desktop', UiBreakpoints.desktop),
    ];

    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Espaciado (UiSpacing)',
          description: 'Escala basada en una grilla de 4px.',
          children: <Widget>[
            for (final (String name, double value) in spacings)
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
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
          children: <Widget>[
            for (final (String name, double value) in radii)
              Column(
                children: <Widget>[
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
          children: <Widget>[
            for (final (String name, double value) in breakpoints)
              UiChip(label: '$name ≥ ${value.toStringAsFixed(0)}px'),
          ],
        ),
      ],
    );
  }
}

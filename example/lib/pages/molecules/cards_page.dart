import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiCard].
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: [
        ShowcaseSection(
          title: 'Básica',
          children: [
            SizedBox(
              width: 320,
              child: UiCard(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Título', style: context.textTheme.titleMedium),
                    const SizedBox(height: UiSpacing.xs),
                    Text(
                      'Contenido de la tarjeta con el estilo del tema.',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Interactiva',
          description: 'Con onTap la tarjeta responde con ripple.',
          children: [
            SizedBox(
              width: 320,
              child: UiCard(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tarjeta tocada')),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.touch_app_outlined),
                    SizedBox(width: UiSpacing.sm),
                    Expanded(child: Text('Tócame')),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Compuesta',
          description: 'Composición con otros componentes del sistema.',
          children: [
            SizedBox(
              width: 380,
              child: UiCard(
                child: Row(
                  children: [
                    const UiAvatar(name: 'Victor García'),
                    const SizedBox(width: UiSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text('Victor García',
                              style: context.textTheme.titleMedium),
                          Text('Flutter developer',
                              style: context.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const UiChip(label: 'Pro'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

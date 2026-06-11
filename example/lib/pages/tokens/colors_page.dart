import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Paleta semántica del tema activo: ColorScheme + UiStatusColors.
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final status = context.statusColors;

    return ShowcaseList(
      children: [
        ShowcaseSection(
          title: 'Colores de marca',
          description:
              'Derivados del primary/secondary que el consumidor pasa a UiKitTheme.',
          children: [
            _Swatch('primary', scheme.primary, scheme.onPrimary),
            _Swatch('primaryContainer', scheme.primaryContainer,
                scheme.onPrimaryContainer),
            _Swatch('secondary', scheme.secondary, scheme.onSecondary),
            _Swatch('secondaryContainer', scheme.secondaryContainer,
                scheme.onSecondaryContainer),
            _Swatch('tertiary', scheme.tertiary, scheme.onTertiary),
          ],
        ),
        ShowcaseSection(
          title: 'Superficies',
          children: [
            _Swatch('surface', scheme.surface, scheme.onSurface),
            _Swatch('surfaceContainerLow', scheme.surfaceContainerLow,
                scheme.onSurface),
            _Swatch('surfaceContainerHigh', scheme.surfaceContainerHigh,
                scheme.onSurface),
            _Swatch('outline', scheme.outline, scheme.surface),
          ],
        ),
        ShowcaseSection(
          title: 'Estados',
          description:
              'error viene del ColorScheme; el resto de UiStatusColors '
              '(ThemeExtension sobreescribible).',
          children: [
            _Swatch('error', scheme.error, scheme.onError),
            _Swatch('success', status.success, scheme.surface),
            _Swatch('warning', status.warning, scheme.surface),
            _Swatch('info', status.info, scheme.surface),
          ],
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color, this.onColor);

  final String name;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 72,
      padding: const EdgeInsets.all(UiSpacing.sm),
      decoration: BoxDecoration(
        color: color,
        borderRadius: UiRadius.borderMd,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Align(
        alignment: .bottomLeft,
        child: Text(
          name,
          style: context.textTheme.labelSmall?.copyWith(color: onColor),
        ),
      ),
    );
  }
}

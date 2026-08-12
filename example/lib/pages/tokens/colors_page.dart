import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Paleta del sistema (UiPalette) y su traducción al tema activo
/// (ColorScheme + UiStatusColors).
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final UiStatusColors status = context.statusColors;
    final UiPalette palette = scheme.brightness == Brightness.dark
        ? UiPalette.dark
        : UiPalette.light;

    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Paleta del sistema (UiPalette)',
          description:
              'Marca y superficies: nombra roles de interfaz, no colores. Es '
              'lo que el tema traduce a ColorScheme. Los estados van aparte, '
              'en UiStatusColors.',
          children: <Widget>[
            _Swatch('primary', palette.primary, palette.onPrimary),
            _Swatch('secondary', palette.secondary, palette.onSecondary),
            _Swatch('background', palette.background, palette.onSurface),
            _Swatch('surface', palette.surface, palette.onSurface),
            _Swatch('surfaceRaised', palette.surfaceRaised, palette.onSurface),
            _Swatch('outline', palette.outline, palette.onSurface),
            _Swatch('onSurfaceMuted', palette.onSurfaceMuted, palette.surface),
            _Swatch('danger', palette.danger, palette.onDanger),
          ],
        ),
        ShowcaseSection(
          title: 'Colores de marca',
          description:
              'Los roles de ColorScheme: primary/secondary vienen de la '
              'paleta; los contenedores y el terciario los deriva Material.',
          children: <Widget>[
            _Swatch('primary', scheme.primary, scheme.onPrimary),
            _Swatch(
              'primaryContainer',
              scheme.primaryContainer,
              scheme.onPrimaryContainer,
            ),
            _Swatch('secondary', scheme.secondary, scheme.onSecondary),
            _Swatch(
              'secondaryContainer',
              scheme.secondaryContainer,
              scheme.onSecondaryContainer,
            ),
            _Swatch('tertiary', scheme.tertiary, scheme.onTertiary),
          ],
        ),
        ShowcaseSection(
          title: 'Superficies',
          children: <Widget>[
            _Swatch('surface', scheme.surface, scheme.onSurface),
            _Swatch(
              'surfaceContainerLow',
              scheme.surfaceContainerLow,
              scheme.onSurface,
            ),
            _Swatch(
              'surfaceContainerHigh',
              scheme.surfaceContainerHigh,
              scheme.onSurface,
            ),
            _Swatch('outline', scheme.outline, scheme.surface),
          ],
        ),
        ShowcaseSection(
          title: 'Estados',
          description:
              'error viene del ColorScheme; el resto de UiStatusColors '
              '(ThemeExtension sobreescribible).',
          children: <Widget>[
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
      padding: const EdgeInsets.all(UiSpacing.small),
      decoration: BoxDecoration(
        color: color,
        borderRadius: UiRadius.borderMedium,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          name,
          style: context.textTheme.labelSmall?.copyWith(color: onColor),
        ),
      ),
    );
  }
}

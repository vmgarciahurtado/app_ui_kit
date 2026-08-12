import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Roles de [UiText]: la pantalla elige un papel, no un `TextStyle`.
class TextsPage extends StatelessWidget {
  const TextsPage({super.key});

  static const Map<UiTextStyle, String> _roles = <UiTextStyle, String>{
    UiTextStyle.display: 'Cifra o palabra protagonista',
    UiTextStyle.headline: 'Título de pantalla',
    UiTextStyle.title: 'Título de sección',
    UiTextStyle.subtitle: 'Título de tarjeta',
    UiTextStyle.body: 'Texto corrido',
    UiTextStyle.bodySmall: 'Texto corrido secundario',
    UiTextStyle.label: 'Etiqueta corta',
  };

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Roles',
          description:
              'Cada rol resuelve contra el TextTheme, así que la tipografía '
              'se cambia en el tema y no pantalla por pantalla.',
          children: <Widget>[
            for (final MapEntry<UiTextStyle, String> role in _roles.entries)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UiText(role.key.name, style: UiTextStyle.label),
                    UiText(role.value, style: role.key),
                    const SizedBox(height: UiSpacing.small),
                  ],
                ),
              ),
          ],
        ),
        ShowcaseSection(
          title: 'Color y peso',
          description:
              'El color por defecto lo pone el tema; el peso solo se refuerza '
              'cuando el rol no alcanza.',
          children: <Widget>[
            const UiText('Por defecto'),
            UiText('Coloreado', color: context.colorScheme.primary),
            const UiText('Reforzado', weight: FontWeight.bold),
            const UiText(
              'CON TRACKING',
              style: UiTextStyle.label,
              letterSpacing: 2.4,
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Recorte',
          description: 'Con maxLines el texto se corta con puntos suspensivos.',
          children: <Widget>[
            SizedBox(
              width: 220,
              child: UiText(
                'Un texto largo que no cabe en el ancho disponible',
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: 220,
              child: UiText(
                'Un texto largo que no cabe en el ancho disponible',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

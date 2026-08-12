import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiIconText]: proporciones, color y recorte.
///
/// El texto ocupa el ancho disponible, así que cada ejemplo va dentro de un
/// ancho acotado, igual que ocurriría dentro de una tarjeta.
class IconTextsPage extends StatelessWidget {
  const IconTextsPage({super.key});

  static const double _width = 260;

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Proporciones',
          description:
              'small para datos secundarios de una tarjeta; medium para '
              'información destacada; large para encabezados.',
          children: <Widget>[
            _Slot(
              child: UiIconText(
                icon: Icons.location_on_outlined,
                text: 'Medellín, Colombia',
              ),
            ),
            _Slot(
              child: UiIconText(
                icon: Icons.location_on_outlined,
                text: 'Medellín, Colombia',
                size: UiSize.medium,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Color',
          description:
              'Sin color toma el de contenido secundario. El ícono y el texto '
              'se pueden separar para destacar solo el ícono.',
          children: <Widget>[
            const _Slot(
              child: UiIconText(
                icon: Icons.calendar_today_outlined,
                text: 'Por defecto',
              ),
            ),
            _Slot(
              child: UiIconText(
                icon: Icons.calendar_today_outlined,
                text: 'Ícono en primary',
                size: UiSize.medium,
                iconColor: context.colorScheme.primary,
                textColor: context.colorScheme.onSurface,
              ),
            ),
            _Slot(
              child: UiIconText(
                icon: Icons.check_circle_outline,
                text: 'Todo en success',
                iconColor: context.statusColors.success,
              ),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Recorte',
          description:
              'Con maxLines el texto largo se corta con puntos suspensivos; '
              'sin él, fluye en varias líneas.',
          children: <Widget>[
            _Slot(
              child: UiIconText(
                icon: Icons.info_outline,
                text: 'Un texto largo que no cabe en el ancho disponible',
                maxLines: 1,
              ),
            ),
            _Slot(
              child: UiIconText(
                icon: Icons.info_outline,
                text: 'Un texto largo que no cabe en el ancho disponible',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: IconTextsPage._width, child: child);
  }
}

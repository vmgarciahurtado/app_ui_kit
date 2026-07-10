import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiListTile].
class ListTilesPage extends StatelessWidget {
  const ListTilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Fila completa',
          description:
              'Molécula que une átomos (UiAvatar, UiChip) y texto.'
              'consume el organismo UiListSection, pero puede '
              'usarse individual.',
          children: <Widget>[
            UiCard(
              padding: EdgeInsets.zero,
              child: UiListTile(
                title: 'Victor García',
                subtitle: 'Desarrollador móvil',
                avatarName: 'Victor García',
                tag: 'Admin',
                onTap: () {},
              ),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Variantes mínimas',
          description: 'Avatar, subtítulo y etiqueta son opcionales.',
          children: <Widget>[
            UiCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  UiListTile(title: 'Solo título'),
                  UiListTile(
                    title: 'Con subtítulo',
                    subtitle: 'Sin avatar ni etiqueta',
                  ),
                  UiListTile(title: 'Con etiqueta', tag: 'Nuevo'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

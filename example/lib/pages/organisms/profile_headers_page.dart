import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiProfileHeader].
class ProfileHeadersPage extends StatelessWidget {
  const ProfileHeadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Encabezado completo',
          description:
              'Organismo que une átomos (UiAvatar, UiChip) y moléculas '
              '(UiCard) en la cabecera de una entidad: avatar, nombre, '
              'subtítulo, etiquetas y acciones.',
          children: <Widget>[
            UiProfileHeader(
              name: 'Victor García',
              subtitle: 'Desarrollador móvil',
              tags: const <String>['Flutter', 'Dart', 'UI'],
              actions: <Widget>[
                UiButton(label: 'Seguir', onPressed: () {}),
                UiButton(
                  label: 'Mensaje',
                  variant: .outline,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Encabezado mínimo',
          description: 'Solo avatar y nombre; el resto es opcional.',
          children: <Widget>[
            UiProfileHeader(name: 'Laura Pérez'),
          ],
        ),
      ],
    );
  }
}

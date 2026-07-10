import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiListSection].
class ListSectionsPage extends StatelessWidget {
  const ListSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Lista con encabezado y acción',
          description:
              'Organismo que une átomos (UiAvatar, UiChip) y moléculas '
              '(UiCard, UiEmptyState).',
          children: <Widget>[
            UiListSection(
              title: 'Integrantes',
              action: UiButton(
                label: 'Agregar',
                variant: .ghost,
                icon: Icons.add,
                onPressed: () {},
              ),
              items: const <UiListItem>[
                UiListItem(
                  title: 'Victor García',
                  subtitle: 'victor.garcia@correo.com',
                  avatarName: 'Victor García',
                  tag: 'Admin',
                ),
                UiListItem(
                  title: 'Laura Pérez',
                  subtitle: 'laura.perez@correo.com',
                  avatarName: 'Laura Pérez',
                  tag: 'Editor',
                ),
                UiListItem(
                  title: 'Andrés Rojas',
                  subtitle: 'andres.rojas@correo.com',
                  avatarName: 'Andrés Rojas',
                ),
              ],
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Lista simple',
          description: 'Sin avatares ni acción: solo títulos y subtítulos.',
          children: <Widget>[
            UiListSection(
              title: 'Notificaciones',
              items: <UiListItem>[
                UiListItem(
                  title: 'Nuevo comentario',
                  subtitle: 'Hace 5 minutos',
                  tag: 'Nuevo',
                ),
                UiListItem(title: 'Build completado', subtitle: 'Hace 1 hora'),
              ],
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Lista vacía',
          description:
              'Cuando no hay elementos se muestra el emptyState, '
              'reutilizando la molécula UiEmptyState.',
          children: <Widget>[
            UiListSection(
              title: 'Invitaciones',
              items: const <UiListItem>[],
              emptyState: UiEmptyState(
                icon: Icons.mail_outline,
                title: 'Sin invitaciones',
                message: 'Cuando invites a alguien aparecerá aquí.',
                action: UiButton(label: 'Invitar', onPressed: () {}),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

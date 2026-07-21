import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Nivel Páginas: instancia de [UiDetailPageTemplate] con datos reales.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _openDemo({required BuildContext context}) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const _ProfileDemoPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Página de perfil',
          description:
              'Instancia de UiDetailPageTemplate con contenido real: '
              'UiProfileHeader como encabezado fijo y organismos '
              'UiListSection desplazándose debajo.',
          children: <Widget>[
            UiButton(
              label: 'Ver página a pantalla completa',
              icon: Icons.open_in_full,
              onPressed: () => _openDemo(context: context),
            ),
          ],
        ),
      ],
    );
  }
}

/// Página "Perfil": la plantilla de detalle llenada con contenido real.
class _ProfileDemoPage extends StatelessWidget {
  const _ProfileDemoPage();

  @override
  Widget build(BuildContext context) {
    return UiDetailPageTemplate(
      title: 'Perfil',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Cerrar',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      header: UiProfileHeader(
        name: 'Victor García',
        subtitle: 'Desarrollador móvil',
        tags: const <String>['Flutter', 'Dart', 'UI'],
        actions: <Widget>[
          UiButton(
            label: 'Seguir',
            icon: Icons.person_add_alt,
            onPressed: () {},
          ),
          UiButton(
            label: 'Mensaje',
            variant: UiButtonVariant.outline,
            onPressed: () {},
          ),
        ],
      ),
      sections: const <Widget>[
        UiListSection(
          title: 'Actividad reciente',
          items: <UiListItem>[
            UiListItem(
              title: 'Publicó app_ui_kit 1.1.0',
              subtitle: 'Hace 2 horas',
              tag: 'Release',
            ),
            UiListItem(
              title: 'Cerró el issue #42',
              subtitle: 'Ayer',
            ),
            UiListItem(
              title: 'Abrió el PR "Niveles de Atomic Design"',
              subtitle: 'Hace 3 días',
              tag: 'PR',
            ),
          ],
        ),
        UiListSection(
          title: 'Proyectos',
          items: <UiListItem>[
            UiListItem(
              title: 'app_ui_kit',
              subtitle: 'Sistema de diseño con Atomic Design',
              avatarName: 'Ui Kit',
            ),
            UiListItem(
              title: 'showcase',
              subtitle: 'Catálogo visual de componentes',
              avatarName: 'Show Case',
            ),
          ],
        ),
      ],
    );
  }
}

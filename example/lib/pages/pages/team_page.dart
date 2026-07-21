import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Nivel Páginas: instancia de [UiPageTemplate] con datos reales.
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  void _openDemo({required BuildContext context}) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const _TeamDemoPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Página de equipo',
          description:
              'Una página es la instancia de una plantilla con contenido '
              'real: UiPageTemplate + organismos (UiListSection), moléculas '
              '(UiBanner, UiConfirmDialog) y átomos con datos concretos.',
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

/// Página "Mi equipo": la plantilla llenada con contenido real.
class _TeamDemoPage extends StatefulWidget {
  const _TeamDemoPage();

  @override
  State<_TeamDemoPage> createState() => _TeamDemoPageState();
}

class _TeamDemoPageState extends State<_TeamDemoPage> {
  static const List<UiListItem> _invitations = <UiListItem>[];

  final List<UiListItem> _members = <UiListItem>[
    const UiListItem(
      title: 'Victor García',
      subtitle: 'victor.garcia@correo.com',
      avatarName: 'Victor García',
      tag: 'Admin',
    ),
    const UiListItem(
      title: 'Laura Pérez',
      subtitle: 'laura.perez@correo.com',
      avatarName: 'Laura Pérez',
      tag: 'Editor',
    ),
    const UiListItem(
      title: 'Andrés Rojas',
      subtitle: 'andres.rojas@correo.com',
      avatarName: 'Andrés Rojas',
      tag: 'Lector',
    ),
  ];

  bool _showBanner = true;

  Future<void> _removeLastMember() async {
    final bool? confirmed = await UiConfirmDialog.show(
      context: context,
      title: '¿Quitar integrante?',
      message: 'Perderá el acceso al proyecto de inmediato.',
      confirmLabel: 'Quitar',
      danger: true,
    );
    if (confirmed == true && _members.isNotEmpty) {
      setState(_members.removeLast);
    }
  }

  @override
  Widget build(BuildContext context) {
    return UiPageTemplate(
      title: 'Mi equipo',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Cerrar',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      sections: <Widget>[
        if (_showBanner)
          UiBanner(
            title: 'Plan Pro',
            message: 'Tu equipo puede tener hasta 10 integrantes.',
            onClose: () => setState(() => _showBanner = false),
          ),
        UiListSection(
          title: 'Integrantes',
          action: UiButton(
            label: 'Quitar último',
            variant: UiButtonVariant.ghost,
            icon: Icons.person_remove_outlined,
            onPressed: _members.isEmpty ? null : _removeLastMember,
          ),
          items: _members,
        ),
        const UiListSection(
          title: 'Invitaciones pendientes',
          items: _invitations,
          emptyState: UiEmptyState(
            icon: Icons.mail_outline,
            title: 'Sin invitaciones',
            message: 'Invita a un integrante para verlo aquí.',
          ),
        ),
      ],
      footer: UiButton(
        label: 'Invitar integrante',
        icon: Icons.person_add_outlined,
        expanded: true,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

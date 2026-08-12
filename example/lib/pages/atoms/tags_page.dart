import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiTag]: neutra, teñida por estado y sobre imagen.
class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UiStatusColors status = context.statusColors;

    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Neutra',
          description:
              'Sin color: toma la superficie elevada del tema. Para marcar '
              'contenido sin cargarlo de significado.',
          children: <Widget>[
            UiTag(label: 'Borrador'),
            UiTag(label: 'Nuevo'),
          ],
        ),
        ShowcaseSection(
          title: 'Teñida',
          description:
              'Con un color de estado: el texto lo toma entero y el fondo, '
              'una versión translúcida.',
          children: <Widget>[
            UiTag(label: 'Confirmada', color: status.success),
            UiTag(label: 'Pendiente', color: status.warning),
            UiTag(label: 'Informativa', color: status.info),
            UiTag(label: 'Cancelada', color: context.colorScheme.error),
          ],
        ),
        const ShowcaseSection(
          title: 'Sobre imagen',
          description:
              'Velo oscuro y texto claro, para que se lea encima de '
              'cualquier foto sin depender del tema.',
          children: <Widget>[_OnImageDemo()],
        ),
      ],
    );
  }
}

/// Simula una foto de portada con etiquetas superpuestas en las esquinas.
class _OnImageDemo extends StatelessWidget {
  const _OnImageDemo();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 280,
      height: 140,
      child: ClipRRect(
        borderRadius: UiRadius.borderLarge,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[UiColors.magenta, UiColors.orange],
                ),
              ),
            ),
            Positioned(
              top: UiSpacing.small,
              left: UiSpacing.small,
              child: UiTag(label: 'Conciertos', onImage: true),
            ),
            Positioned(
              top: UiSpacing.small,
              right: UiSpacing.small,
              child: UiTag(label: 'Gratis', onImage: true),
            ),
          ],
        ),
      ),
    );
  }
}

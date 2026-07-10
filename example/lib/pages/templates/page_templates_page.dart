import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/placeholder_box.dart';
import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Demostración de [UiPageTemplate].
class PageTemplatesPage extends StatelessWidget {
  const PageTemplatesPage({super.key});

  void _openDemo(BuildContext context) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => UiPageTemplate(
            title: 'Plantilla de página',
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Cerrar',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
            sections: const <Widget>[
              PlaceholderBox(label: 'Organismo · encabezado'),
              PlaceholderBox(label: 'Organismo · listado', height: 220),
              PlaceholderBox(label: 'Organismo · resumen'),
            ],
            footer: UiButton(
              label: 'Acción principal',
              expanded: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'UiPageTemplate',
          description:
              'La plantilla define la estructura de una pantalla — AppBar, '
              'secciones con ancho máximo responsive y barra de acción '
              'inferior — sin contenido real. Aquí los organismos se '
              'representan como cajas de relleno; las páginas la instancian '
              'con datos concretos.',
          children: <Widget>[
            UiButton(
              label: 'Ver plantilla a pantalla completa',
              icon: Icons.open_in_full,
              onPressed: () => _openDemo(context),
            ),
          ],
        ),
      ],
    );
  }
}

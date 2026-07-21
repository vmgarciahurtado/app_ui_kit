import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/placeholder_box.dart';
import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Demostración de [UiDetailPageTemplate].
class DetailTemplatesPage extends StatelessWidget {
  const DetailTemplatesPage({super.key});

  void _openDemo({required BuildContext context}) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => UiDetailPageTemplate(
            title: 'Plantilla de detalle',
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Cerrar',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
            header: const PlaceholderBox(label: 'Organismo · encabezado fijo'),
            sections: const <Widget>[
              PlaceholderBox(label: 'Organismo · sección 1', height: 220),
              PlaceholderBox(label: 'Organismo · sección 2', height: 220),
              PlaceholderBox(label: 'Organismo · sección 3', height: 220),
            ],
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
          title: 'UiDetailPageTemplate',
          description:
              'Variante con encabezado fijo bajo el AppBar: el encabezado '
              'permanece visible mientras las secciones se desplazan debajo. '
              'Igual que toda plantilla, solo define estructura.',
          children: <Widget>[
            UiButton(
              label: 'Ver plantilla a pantalla completa',
              icon: Icons.open_in_full,
              onPressed: () => _openDemo(context: context),
            ),
          ],
        ),
      ],
    );
  }
}

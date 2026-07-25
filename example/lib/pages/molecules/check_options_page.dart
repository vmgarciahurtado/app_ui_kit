import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes e interacción de [UiCheckOption].
class CheckOptionsPage extends StatefulWidget {
  const CheckOptionsPage({super.key});

  @override
  State<CheckOptionsPage> createState() => _CheckOptionsPageState();
}

class _CheckOptionsPageState extends State<CheckOptionsPage> {
  bool _terms = false;
  bool _news = true;

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Con enlace',
          description:
              'Toca el enlace para abrir los términos; toca el '
              'resto de la fila para marcar.',
          children: <Widget>[
            SizedBox(
              width: 360,
              child: UiCheckOption(
                value: _terms,
                label: 'Acepto los',
                linkText: 'Términos y condiciones',
                onChanged: (bool value) => setState(() => _terms = value),
                onLinkTap: () {},
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Simple',
          children: <Widget>[
            SizedBox(
              width: 360,
              child: UiCheckOption(
                value: _news,
                label: 'Quiero recibir novedades por correo',
                onChanged: (bool value) => setState(() => _news = value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

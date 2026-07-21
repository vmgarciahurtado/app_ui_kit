import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Tamaños y variantes de [UiLoader].
class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Tamaños',
          children: <Widget>[
            UiLoader(size: UiSize.small),
            UiLoader(),
            UiLoader(size: UiSize.large),
          ],
        ),
        ShowcaseSection(
          title: 'Con etiqueta',
          children: <Widget>[
            UiLoader(size: UiSize.large, label: 'Cargando…'),
          ],
        ),
      ],
    );
  }
}

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
      children: [
        ShowcaseSection(
          title: 'Tamaños',
          children: [
            UiLoader(size: .sm),
            UiLoader(),
            UiLoader(size: .lg),
          ],
        ),
        ShowcaseSection(
          title: 'Con etiqueta',
          children: [
            UiLoader(size: .lg, label: 'Cargando…'),
          ],
        ),
      ],
    );
  }
}

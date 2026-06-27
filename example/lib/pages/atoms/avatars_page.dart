import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Tamaños y variantes de [UiAvatar].
class AvatarsPage extends StatelessWidget {
  const AvatarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Tamaños',
          description: 'Sin imagen muestra las iniciales del nombre.',
          children: <Widget>[
            UiAvatar(name: 'Victor García', size: .sm),
            UiAvatar(name: 'Victor García'),
            UiAvatar(name: 'Victor García', size: .lg),
          ],
        ),
        ShowcaseSection(
          title: 'Una sola palabra',
          children: <Widget>[
            UiAvatar(name: 'Flutter', size: .lg),
          ],
        ),
      ],
    );
  }
}

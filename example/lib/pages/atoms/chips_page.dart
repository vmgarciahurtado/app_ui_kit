import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiChip]: estáticos, seleccionables y eliminables.
class ChipsPage extends StatefulWidget {
  const ChipsPage({super.key});

  @override
  State<ChipsPage> createState() => _ChipsPageState();
}

class _ChipsPageState extends State<ChipsPage> {
  final Set<String> _selected = {'Flutter'};
  final List<String> _tags = ['Diseño', 'Mobile', 'Web'];

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: [
        const ShowcaseSection(
          title: 'Estáticos',
          children: [
            UiChip(label: 'Etiqueta'),
            UiChip(label: 'Con ícono', icon: Icons.tag),
          ],
        ),
        ShowcaseSection(
          title: 'Seleccionables (filtros)',
          description: 'Tocar para alternar la selección.',
          children: [
            for (final tech in const ['Flutter', 'Dart', 'Material'])
              UiChip(
                label: tech,
                selected: _selected.contains(tech),
                onSelected: (value) => setState(() {
                  value ? _selected.add(tech) : _selected.remove(tech);
                }),
              ),
          ],
        ),
        ShowcaseSection(
          title: 'Eliminables',
          children: [
            for (final tag in _tags)
              UiChip(
                label: tag,
                onDeleted: () => setState(() => _tags.remove(tag)),
              ),
            if (_tags.isEmpty)
              UiButton(
                label: 'Restaurar',
                variant: .ghost,
                onPressed: () => setState(
                  () => _tags.addAll(['Diseño', 'Mobile', 'Web']),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

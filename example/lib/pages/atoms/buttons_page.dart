import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes y estados de [UiButton].
class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  bool _loading = false;

  Future<void> _simulateLoad() async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Variantes',
          description: 'Cinco niveles de énfasis con una sola API.',
          children: <Widget>[
            UiButton(label: 'Primary', onPressed: () {}),
            UiButton(label: 'Secondary', variant: .secondary, onPressed: () {}),
            UiButton(label: 'Outline', variant: .outline, onPressed: () {}),
            UiButton(label: 'Ghost', variant: .ghost, onPressed: () {}),
            UiButton(label: 'Danger', variant: .danger, onPressed: () {}),
          ],
        ),
        ShowcaseSection(
          title: 'Con ícono',
          children: <Widget>[
            UiButton(label: 'Guardar', icon: Icons.check, onPressed: () {}),
            UiButton(
              label: 'Compartir',
              icon: Icons.share_outlined,
              variant: .outline,
              onPressed: () {},
            ),
            UiButton(
              label: 'Eliminar',
              icon: Icons.delete_outline,
              variant: .danger,
              onPressed: () {},
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Estados',
          description: 'Toca "Cargar" para ver el estado de carga real.',
          children: <Widget>[
            UiButton(
              label: 'Cargar',
              loading: _loading,
              onPressed: _simulateLoad,
            ),
            const UiButton(label: 'Deshabilitado'),
            const UiButton(label: 'Deshabilitado', variant: .outline),
          ],
        ),
        ShowcaseSection(
          title: 'Expandido',
          description: 'expanded: true ocupa todo el ancho disponible.',
          children: <Widget>[
            UiButton(label: 'Continuar', expanded: true, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

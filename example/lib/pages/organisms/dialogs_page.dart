import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiConfirmDialog].
class DialogsPage extends StatefulWidget {
  const DialogsPage({super.key});

  @override
  State<DialogsPage> createState() => _DialogsPageState();
}

class _DialogsPageState extends State<DialogsPage> {
  String _lastResult = 'Sin interacción todavía.';

  Future<void> _openConfirm() async {
    final bool? confirmed = await UiConfirmDialog.show(
      context,
      title: '¿Publicar cambios?',
      message: 'Los cambios serán visibles para todos los usuarios.',
      confirmLabel: 'Publicar',
    );
    setState(() => _lastResult = 'Resultado: $confirmed');
  }

  Future<void> _openDanger() async {
    final bool? confirmed = await UiConfirmDialog.show(
      context,
      title: '¿Eliminar cuenta?',
      message: 'Esta acción es permanente y no se puede deshacer.',
      confirmLabel: 'Eliminar',
      danger: true,
    );
    setState(() => _lastResult = 'Resultado: $confirmed');
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Diálogo de confirmación',
          description:
              'Organismo que compone UiButton y los tokens del sistema. '
              'Resuelve true / false / null según la interacción.',
          children: <Widget>[
            UiButton(label: 'Confirmación normal', onPressed: _openConfirm),
            UiButton(
              label: 'Confirmación destructiva',
              variant: .danger,
              onPressed: _openDanger,
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Resultado',
          children: <Widget>[
            UiBanner(message: _lastResult),
          ],
        ),
      ],
    );
  }
}

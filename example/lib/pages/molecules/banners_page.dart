import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiBanner].
class BannersPage extends StatefulWidget {
  const BannersPage({super.key});

  @override
  State<BannersPage> createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Variantes',
          description:
              'Los colores salen de UiStatusColors y del ColorScheme, '
              'así que se adaptan al tema claro/oscuro.',
          children: <Widget>[
            UiBanner(message: 'Hay una nueva versión disponible.'),
            UiBanner(
              status: UiStatus.success,
              message: 'Tu perfil se actualizó correctamente.',
            ),
            UiBanner(
              status: UiStatus.warning,
              message: 'Tu sesión expira en 5 minutos.',
            ),
            UiBanner(
              status: UiStatus.error,
              message: 'No pudimos procesar el pago.',
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Con título',
          children: <Widget>[
            UiBanner(
              title: 'Mantenimiento programado',
              message:
                  'El servicio estará en mantenimiento el sábado '
                  'de 2:00 a 4:00 a.m.',
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Cerrable',
          children: <Widget>[
            if (_visible)
              UiBanner(
                status: UiStatus.success,
                title: 'Cambios guardados',
                message: 'Puedes cerrar este mensaje.',
                onClose: () => setState(() => _visible = false),
              )
            else
              UiButton(
                label: 'Mostrar de nuevo',
                variant: UiButtonVariant.ghost,
                onPressed: () => setState(() => _visible = true),
              ),
          ],
        ),
      ],
    );
  }
}

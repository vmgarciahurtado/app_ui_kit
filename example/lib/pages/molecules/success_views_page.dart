import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiSuccessView].
class SuccessViewsPage extends StatelessWidget {
  const SuccessViewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Básico',
          children: <Widget>[
            SizedBox(
              width: 360,
              child: UiSuccessView(
                title: '¡Contraseña actualizada!',
                message: 'Ya puedes iniciar sesión con tu nueva contraseña.',
                actionLabel: 'Continuar',
                onAction: () {},
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Ícono personalizado',
          children: <Widget>[
            SizedBox(
              width: 360,
              child: UiSuccessView(
                icon: Icon(
                  Icons.mark_email_read_outlined,
                  size: UiIconSize.extraLarge,
                  color: context.colorScheme.primary,
                ),
                title: 'Correo verificado',
                actionLabel: 'Ir al inicio',
                onAction: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes y estados de [UiTextField].
class TextFieldsPage extends StatelessWidget {
  const TextFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseList(
      children: [
        ShowcaseSection(
          title: 'Básicos',
          children: [
            SizedBox(
              width: 320,
              child: UiTextField(label: 'Nombre', hint: 'Tu nombre completo'),
            ),
            SizedBox(
              width: 320,
              child: UiTextField(
                label: 'Correo',
                hint: 'tu@correo.com',
                prefixIcon: Icons.mail_outline,
                helperText: 'Nunca compartiremos tu correo.',
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Contraseña',
          description: 'Incluye toggle de visibilidad automático.',
          children: [
            SizedBox(
              width: 320,
              child: UiTextField(
                label: 'Contraseña',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Estados',
          children: [
            SizedBox(
              width: 320,
              child: UiTextField(
                label: 'Correo',
                errorText: 'El correo no es válido.',
              ),
            ),
            SizedBox(
              width: 320,
              child: UiTextField(label: 'Deshabilitado', enabled: false),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Multilínea',
          children: [
            SizedBox(
              width: 480,
              child: UiTextField(
                label: 'Descripción',
                hint: 'Cuéntanos más…',
                maxLines: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

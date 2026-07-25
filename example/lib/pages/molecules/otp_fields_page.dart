import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Interacción de [UiOtpField].
class OtpFieldsPage extends StatefulWidget {
  const OtpFieldsPage({super.key});

  @override
  State<OtpFieldsPage> createState() => _OtpFieldsPageState();
}

class _OtpFieldsPageState extends State<OtpFieldsPage> {
  String? _completedCode;

  @override
  Widget build(BuildContext context) {
    final String? code = _completedCode;
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: '6 dígitos',
          description:
              'El foco avanza y retrocede solo; onCompleted se '
              'dispara una sola vez al llenar el código.',
          children: <Widget>[
            SizedBox(
              width: 320,
              child: UiOtpField(
                onCompleted: (String value) =>
                    setState(() => _completedCode = value),
              ),
            ),
            if (code != null)
              Text(
                'Código: $code',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
          ],
        ),
        ShowcaseSection(
          title: '4 dígitos',
          children: <Widget>[
            SizedBox(
              width: 240,
              child: UiOtpField(length: 4, onCompleted: (_) {}),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';
import '../tokens/ui_icon_size.dart';
import '../tokens/ui_spacing.dart';

/// Opción de aceptación con círculo seleccionable y texto que puede incluir
/// un enlace (ej. "Acepto **Términos y condiciones**").
///
/// El enlace ([linkText]) se pinta con el color primario y dispara [onLinkTap]
/// (típicamente abre un diálogo legal).
class UiCheckOption extends StatefulWidget {
  const UiCheckOption({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
    this.linkText,
    this.onLinkTap,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final String? linkText;
  final VoidCallback? onLinkTap;

  @override
  State<UiCheckOption> createState() => _UiCheckOptionState();
}

class _UiCheckOptionState extends State<UiCheckOption> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () => widget.onLinkTap?.call();
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Circle(value: widget.value),
          const SizedBox(width: UiSpacing.small),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: widget.label,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  if (widget.linkText != null) ...<InlineSpan>[
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: widget.linkText,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _recognizer,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.value});

  /// Diámetro del indicador de selección.
  static const double _diameter = 24;

  /// Grosor del borde del círculo.
  static const double _borderWidth = 2;

  final bool value;

  @override
  Widget build(BuildContext context) {
    final Color primary = context.colorScheme.primary;
    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value ? primary : Colors.transparent,
        border: Border.all(
          color: value ? primary : context.colorScheme.outline,
          width: _borderWidth,
        ),
      ),
      child: value
          ? Icon(
              Icons.check,
              size: UiIconSize.small,
              color: context.colorScheme.onPrimary,
            )
          : null,
    );
  }
}

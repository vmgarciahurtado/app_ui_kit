import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Campo de ingreso de código (OTP) con casillas individuales.
///
/// [length] es configurable. El OTP por correo de Supabase es de 6 dígitos,
/// por eso el valor por defecto es 6. Avanza/retrocede el foco automáticamente
/// y notifica con [onChanged] y [onCompleted].
///
/// ```dart
/// UiOtpField(
///   onCompleted: (code) => _verify(code),
/// );
/// ```
class UiOtpField extends StatefulWidget {
  const UiOtpField({
    required this.onCompleted,
    super.key,
    this.length = 6,
    this.onChanged,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  State<UiOtpField> createState() => _UiOtpFieldState();
}

class _UiOtpFieldState extends State<UiOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  /// Evita que [UiOtpField.onCompleted] se dispare más de una vez por código
  /// completo (p. ej. al reeditar el último dígito ya lleno).
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _nodes = List<FocusNode>.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
    for (final FocusNode node in _nodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers
      .map((TextEditingController controller) => controller.text)
      .join();

  void _onChanged({required int index, required String value}) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _nodes[index + 1].requestFocus();
    }
    final String code = _code;
    widget.onChanged?.call(code);
    final bool isComplete = code.length == widget.length;
    if (isComplete && !_completed) {
      _completed = true;
      _nodes[index].unfocus();
      widget.onCompleted(code);
    } else if (!isComplete) {
      _completed = false;
    }
  }

  KeyEventResult _onKey({required int index, required KeyEvent event}) {
    final bool isBackspace =
        event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace;
    if (isBackspace && _controllers[index].text.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      _completed = false;
      widget.onChanged?.call(_code);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    const double gap = UiSpacing.small;
    const double maxBox = 64;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double raw =
            (constraints.maxWidth - gap * (widget.length - 1)) / widget.length;
        final double size = raw.clamp(0, maxBox);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            widget.length,
            (int index) => Padding(
              padding: EdgeInsets.only(
                right: index == widget.length - 1 ? 0 : gap,
              ),
              child: SizedBox(
                width: size,
                height: size,
                child: Focus(
                  onKeyEvent: (FocusNode node, KeyEvent event) =>
                      _onKey(index: index, event: event),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _nodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: context.textTheme.titleMedium,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (String value) =>
                        _onChanged(index: index, value: value),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

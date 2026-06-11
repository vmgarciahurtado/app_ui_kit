import 'package:flutter/material.dart';

/// Campo de texto del sistema de diseño.
///
/// Hereda la decoración definida en `UiKitTheme` (bordes, relleno, estados
/// de foco y error) y agrega manejo automático de visibilidad para campos
/// de contraseña.
///
/// ```dart
/// UiTextField(
///   label: 'Correo',
///   hint: 'tu@correo.com',
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) => value!.contains('@') ? null : 'Correo inválido',
/// );
/// ```
class UiTextField extends StatefulWidget {
  const UiTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;

  /// Mensaje de error manual. Para validación de formularios usar [validator].
  final String? errorText;
  final IconData? prefixIcon;

  /// Oculta el texto y muestra un botón para alternar la visibilidad.
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  State<UiTextField> createState() => _UiTextFieldState();
}

class _UiTextFieldState extends State<UiTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscured,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
      ),
    );
  }
}

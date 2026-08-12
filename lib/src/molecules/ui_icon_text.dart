import 'package:flutter/material.dart';

import '../foundations/ui_size.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_icon_size.dart';
import '../tokens/ui_spacing.dart';

/// Línea de información: un ícono y un texto que ocupa el resto del ancho.
///
/// ```dart
/// UiIconText(icon: Icons.location_on_outlined, text: 'Medellín');
/// ```
class UiIconText extends StatelessWidget {
  const UiIconText({
    required this.icon,
    required this.text,
    super.key,
    this.size = UiSize.small,
    this.iconColor,
    this.textColor,
    this.maxLines,
  });

  final IconData icon;
  final String text;

  /// Proporción de la línea: [UiSize.small] para datos secundarios,
  /// [UiSize.medium] para información destacada.
  final UiSize size;

  /// Por defecto, el color de contenido secundario del tema.
  final Color? iconColor;

  /// Por defecto, sigue a [iconColor].
  final Color? textColor;

  /// Si se indica, el texto se recorta con puntos suspensivos.
  final int? maxLines;

  double get _iconSize => switch (size) {
    UiSize.small => UiIconSize.small,
    UiSize.medium => UiIconSize.medium,
    UiSize.large => UiIconSize.extraLarge,
  };

  double get _gap => switch (size) {
    UiSize.small => UiSpacing.extraSmall,
    UiSize.medium || UiSize.large => UiSpacing.small,
  };

  TextStyle? _textStyle(BuildContext context) => switch (size) {
    UiSize.small => context.textTheme.bodyMedium,
    UiSize.medium => context.textTheme.bodyLarge,
    UiSize.large => context.textTheme.titleMedium,
  };

  @override
  Widget build(BuildContext context) {
    final Color resolvedIcon =
        iconColor ?? context.colorScheme.onSurfaceVariant;
    return Row(
      children: <Widget>[
        Icon(icon, size: _iconSize, color: resolvedIcon),
        SizedBox(width: _gap),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: maxLines == null ? null : TextOverflow.ellipsis,
            style: _textStyle(
              context,
            )?.copyWith(color: textColor ?? resolvedIcon),
          ),
        ),
      ],
    );
  }
}

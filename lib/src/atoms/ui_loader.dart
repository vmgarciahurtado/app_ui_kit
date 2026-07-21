import 'package:flutter/material.dart';

import '../foundations/ui_size.dart';
import '../foundations/ui_sizes.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Indicador de carga del sistema de diseño.
///
/// ```dart
/// UiLoader(size: UiSize.large, label: 'Cargando…');
/// ```
class UiLoader extends StatelessWidget {
  const UiLoader({super.key, this.size = UiSize.medium, this.label});

  final UiSize size;

  /// Texto opcional debajo del indicador.
  final String? label;

  /// Traduce el vocabulario [UiSize] al diámetro del indicador,
  /// tomando los valores de la escala cruda [UiSizes].
  double get _dimension => switch (size) {
    UiSize.small => UiSizes.size16,
    UiSize.medium => UiSizes.size28,
    UiSize.large => UiSizes.size44,
  };

  /// Grosor del trazo proporcional a cada tamaño.
  double get _strokeWidth => switch (size) {
    UiSize.small => UiSizes.size2,
    UiSize.medium => UiSizes.size3,
    UiSize.large => UiSizes.size4,
  };

  @override
  Widget build(BuildContext context) {
    final SizedBox indicator = SizedBox.square(
      dimension: _dimension,
      child: CircularProgressIndicator(strokeWidth: _strokeWidth),
    );

    final String? label = this.label;
    if (label == null) return indicator;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        indicator,
        const SizedBox(height: UiSpacing.small),
        Text(label, style: context.textTheme.bodySmall),
      ],
    );
  }
}

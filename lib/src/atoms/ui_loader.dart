import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Tamaños disponibles para [UiLoader].
enum UiLoaderSize {
  sm(16, 2),
  md(28, 3),
  lg(44, 4);

  const UiLoaderSize(this.dimension, this.strokeWidth);

  final double dimension;
  final double strokeWidth;
}

/// Indicador de carga del sistema de diseño.
///
/// ```dart
/// UiLoader(size: UiLoaderSize.lg, label: 'Cargando…');
/// ```
class UiLoader extends StatelessWidget {
  const UiLoader({super.key, this.size = .md, this.label});

  final UiLoaderSize size;

  /// Texto opcional debajo del indicador.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final SizedBox indicator = SizedBox.square(
      dimension: size.dimension,
      child: CircularProgressIndicator(strokeWidth: size.strokeWidth),
    );

    if (label == null) return indicator;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        indicator,
        const SizedBox(height: UiSpacing.sm),
        Text(label!, style: context.textTheme.bodySmall),
      ],
    );
  }
}

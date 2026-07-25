import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../foundations/ui_size.dart';
import '../foundations/ui_sizes.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Indicador de carga del sistema de diseño.
///
/// Renderiza una animación Lottie empaquetada dentro del propio `app_ui_kit`,
/// por lo que las apps consumidoras no necesitan declarar ningún asset.
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

  @override
  Widget build(BuildContext context) {
    final Widget indicator = SizedBox.square(
      dimension: _dimension,
      child: Lottie.asset(
        'assets/animations/loading.json',
        package: 'app_ui_kit',
        fit: BoxFit.contain,
      ),
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

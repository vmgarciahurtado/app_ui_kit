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
  const UiLoader({
    super.key,
    this.size = UiSize.medium,
    this.label,
    this.color,
  });

  final UiSize size;

  /// Texto opcional debajo del indicador.
  final String? label;

  /// Color de los puntos. Si es null hereda el del `IconTheme`, que es lo que
  /// hace que dentro de un botón tomen el color de su texto.
  final Color? color;

  /// Traduce el vocabulario [UiSize] al **ancho** del indicador, tomando los
  /// valores de la escala cruda [UiSizes].
  double get _width => switch (size) {
    UiSize.small => UiSizes.size48,
    UiSize.medium => UiSizes.size80,
    UiSize.large => UiSizes.size200,
  };

  @override
  Widget build(BuildContext context) {
    // Se dimensiona por ancho y el alto lo define la relación de aspecto de la
    // animación: los dots están en fila, así que una caja cuadrada los dejaría
    // diminutos entre franjas vacías.
    final Widget indicator = Lottie.asset(
      'assets/animations/loading.json',
      package: 'app_ui_kit',
      width: _width,
      fit: BoxFit.contain,
      delegates: LottieDelegates(
        values: <ValueDelegate<dynamic>>[
          ValueDelegate.color(
            const <String>['**'],
            value:
                color ??
                IconTheme.of(context).color ??
                context.colorScheme.onSurface,
          ),
        ],
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

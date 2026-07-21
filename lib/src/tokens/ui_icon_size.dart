import '../foundations/ui_sizes.dart';

/// Escala de tamaños de ícono del sistema de diseño.
///
/// Da misión de "tamaño de ícono" a la escala cruda de [UiSizes]. Usar estos
/// valores en lugar de números hardcodeados para que los íconos mantengan
/// proporciones consistentes entre componentes.
abstract final class UiIconSize {
  /// Íconos dentro de componentes compactos (botones, chips, cierre).
  static const double small = UiSizes.size18;

  /// Íconos acompañando contenido (banners, listas).
  static const double medium = UiSizes.size22;

  /// Íconos protagonistas (estados vacíos, ilustraciones).
  static const double extraLarge = UiSizes.size56;
}

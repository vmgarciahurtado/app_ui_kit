import '../foundations/ui_sizes.dart';

/// Escala de espaciado del sistema de diseño.
///
/// Da misión de "espaciado" a la escala cruda de [UiSizes] (grilla de 4px).
/// Usar estos valores en lugar de números hardcodeados para mantener un
/// ritmo visual consistente entre pantallas.
abstract final class UiSpacing {
  static const double extraExtraSmall = UiSizes.size2;
  static const double extraSmall = UiSizes.size4;
  static const double small = UiSizes.size8;
  static const double medium = UiSizes.size16;
  static const double large = UiSizes.size24;
  static const double extraLarge = UiSizes.size32;
  static const double extraExtraLarge = UiSizes.size48;
}

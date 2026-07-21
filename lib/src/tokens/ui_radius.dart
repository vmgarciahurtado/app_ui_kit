import 'package:flutter/widgets.dart';

import '../foundations/ui_sizes.dart';

/// Escala de radios de borde del sistema de diseño.
///
/// Da misión de "radio de esquina" a la escala cruda de [UiSizes].
abstract final class UiRadius {
  static const double small = UiSizes.size4;
  static const double medium = UiSizes.size8;
  static const double large = UiSizes.size16;
  static const double full = 999;

  static const BorderRadius borderSmall = BorderRadius.all(
    Radius.circular(small),
  );
  static const BorderRadius borderMedium = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius borderLarge = BorderRadius.all(
    Radius.circular(large),
  );
  static const BorderRadius borderFull = BorderRadius.all(
    Radius.circular(full),
  );
}

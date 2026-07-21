import '../foundations/ui_sizes.dart';

/// Breakpoints de ancho (en píxeles lógicos) para layouts responsivos.
///
/// Da misión de "punto de quiebre" a la escala cruda de [UiSizes].
abstract final class UiBreakpoints {
  static const double mobile = UiSizes.size600;
  static const double tablet = UiSizes.size900;
  static const double desktop = UiSizes.size1200;
}

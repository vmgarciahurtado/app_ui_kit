import 'package:flutter/widgets.dart';

/// Escala de radios de borde del sistema de diseño.
abstract final class UiRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double full = 999;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderFull = BorderRadius.all(
    Radius.circular(full),
  );
}

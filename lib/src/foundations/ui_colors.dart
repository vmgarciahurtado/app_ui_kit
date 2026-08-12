import 'package:flutter/material.dart';

/// Escala cruda de color del sistema de diseño.
abstract final class UiColors {
  // Marca.
  static const Color yellow = Color(0xFFF2F04B);
  static const Color magenta = Color(0xFFE64BC8);

  // Estado, tono neón (fondos oscuros).
  static const Color green = Color(0xFF6BF29B);
  static const Color orange = Color(0xFFF2793D);
  static const Color red = Color(0xFFFF5A5A);

  // Estado, tono saturado (fondos claros).
  static const Color greenDeep = Color(0xFF16A34A);
  static const Color orangeDeep = Color(0xFFD97706);
  static const Color redDeep = Color(0xFFDC2626);
  static const Color blueDeep = Color(0xFF2563EB);

  // Neutros oscuros: negro con un punto de calidez para que no se vea plano.
  static const Color ink900 = Color(0xFF0B0709);
  static const Color ink800 = Color(0xFF171214);
  static const Color ink700 = Color(0xFF241C1F);
  static const Color ink600 = Color(0xFF3A2F33);
  static const Color ink300 = Color(0xFFA89BA0);

  // Neutros claros.
  static const Color paper100 = Color(0xFFF7F5F6);
  static const Color paper200 = Color(0xFFEFEBED);
  static const Color paper300 = Color(0xFFDDD6D9);
  static const Color paper700 = Color(0xFF6B6064);

  // Extremos.
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}

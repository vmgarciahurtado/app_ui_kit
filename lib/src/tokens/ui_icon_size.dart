/// Escala de tamaños de ícono del sistema de diseño, en píxeles lógicos.
///
/// Usar estos valores en lugar de números hardcodeados para que los íconos
/// mantengan proporciones consistentes entre componentes.
abstract final class UiIconSize {
  /// Íconos dentro de componentes compactos (botones, chips, cierre).
  static const double sm = 18;

  /// Íconos acompañando contenido (banners, listas).
  static const double md = 22;

  /// Íconos protagonistas (estados vacíos, ilustraciones).
  static const double xl = 56;
}

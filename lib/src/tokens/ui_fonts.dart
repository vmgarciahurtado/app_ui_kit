/// Tipografías del sistema de diseño, empaquetadas en el propio paquete: la
/// app consumidora no declara ningún asset.
abstract final class UiFonts {
  /// Prefijo que Flutter exige para las fuentes que vienen de un paquete.
  static const String _package = 'packages/app_ui_kit/';

  /// Fuente base: cuerpos de texto, etiquetas y controles.
  static const String body = '${_package}Poppins';

  /// Fuente de titulares: display, headline y titleLarge.
  static const String heading = '${_package}Poppins';
}

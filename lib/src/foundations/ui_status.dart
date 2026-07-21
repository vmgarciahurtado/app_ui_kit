/// Estados semánticos del sistema de diseño.
///
/// Vocabulario compartido por los componentes que comunican estado
/// (banners, y a futuro badges, toasts o chips de estado). Cada valor se
/// resuelve a color vía `UiStatusColors` (o `ColorScheme.error` para
/// [error]), nunca a colores hardcodeados.
enum UiStatus {
  /// Información neutral.
  info,

  /// Operación exitosa.
  success,

  /// Advertencia que requiere atención.
  warning,

  /// Error o acción destructiva.
  error,
}

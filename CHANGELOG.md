## 0.0.1

Versión inicial del sistema de diseño.

* **Tokens**: `UiSpacing`, `UiRadius`, `UiBreakpoints`.
* **Theme**: `UiKitTheme.light/dark` configurable (primary, secondary, fuente
  base y de titulares, colores de estado), `UiStatusColors` como
  `ThemeExtension` y extensión de `BuildContext` (`context.colorScheme`,
  `context.textTheme`, `context.statusColors`).
* **Átomos**: `UiButton` (5 variantes, loading, ícono, expanded),
  `UiTextField` (contraseña con toggle, estados), `UiChip`, `UiLoader`,
  `UiAvatar`.
* **Moléculas**: `UiCard`, `UiBanner`, `UiEmptyState`.
* **Organismos**: `UiConfirmDialog`.
* **Showcase** en `example/` con navegación por `MenuAnchor`, variantes por
  componente y tema claro/oscuro.

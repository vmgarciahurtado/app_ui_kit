## 0.1.0

Reorganización de la base en un pipeline de capas y unificación del
vocabulario del sistema. Incluye cambios que rompen la API respecto a la
0.0.1 (ver **Cambios que rompen compatibilidad**).

### Arquitectura

* Base organizada como pipeline `foundations → tokens → theme → componentes`:
  * **`foundations/`**: escala cruda de valores sin misión (`UiSizes`) y
    vocabulario del sistema sin valores (`UiSize`, `UiStatus`).
  * **`tokens/`**: dan misión a los valores crudos (`UiSpacing`, `UiRadius`,
    `UiIconSize`, `UiBreakpoints`).
  * **`theme/`**: `UiKitTheme`, `UiStatusColors` y la extensión de
    `BuildContext`.

### Agregado

* **Vocabulario del sistema**: `UiSize` (`small`, `medium`, `large`) y
  `UiStatus` (`info`, `success`, `warning`, `error`) como enums compartidos
  sin valores; cada componente traduce el vocabulario a su propia proporción.
* **Foundations**: `UiSizes` como única escala cruda de píxeles lógicos.
* **Tokens**: `UiIconSize`.
* **Moléculas**: `UiListTile`.
* **Organismos**: `UiListSection`, `UiProfileHeader`.
* **Plantillas**: `UiPageTemplate`, `UiDetailPageTemplate`.
* **Showcase**: páginas de ejemplo `Página de perfil` y `Página de equipo`
  como instancias reales de las plantillas.

### Cambios que rompen compatibilidad

* Escala de tokens renombrada a nombres explícitos: `UiSpacing.sm/md/lg…` →
  `small/medium/large` (y `xxs/xxl` → `extraExtraSmall/extraExtraLarge`);
  igual en `UiRadius` (`borderSm` → `borderSmall`, …) y `UiIconSize`.
* `UiBanner` ahora recibe `status: UiStatus` en lugar de
  `variant: UiBannerVariant`; se eliminó `UiBannerVariant`.
* `UiAvatar` y `UiLoader` reciben `size: UiSize`; se eliminaron los enums
  `UiAvatarSize` y `UiLoaderSize` (sus dimensiones son ahora detalle interno
  de cada componente).
* `UiConfirmDialog.show` recibe `context` como parámetro nombrado
  (`show(context: context, …)`).

### Movido

* `UiConfirmDialog` reclasificado de organismo a molécula.

## 0.0.1

Versión inicial interna del sistema de diseño (no publicada).

* **Tokens**: `UiSpacing`, `UiRadius`, `UiBreakpoints`.
* **Theme**: `UiKitTheme.light/dark` configurable (primary, secondary, fuente
  base y de titulares, colores de estado), `UiStatusColors` como
  `ThemeExtension` y extensión de `BuildContext`.
* **Átomos**: `UiButton`, `UiTextField`, `UiChip`, `UiLoader`, `UiAvatar`.
* **Moléculas**: `UiCard`, `UiBanner`, `UiEmptyState`.
* **Showcase** en `example/` con navegación por `MenuAnchor` y tema
  claro/oscuro.

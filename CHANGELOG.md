## 1.2.0

Tipografía y dimensiones dejan de decidirse en cada pantalla. Sin cambios
que rompan la API pública respecto a la 1.1.0.

### Agregado

* **Átomos**:
  * `UiText`: texto que toma su estilo de un rol (`display`, `headline`,
    `title`, `subtitle`, `body`, `bodySmall`, `label`) en lugar de un
    `TextStyle` suelto, con color, alineación, peso, tracking y recorte
    opcional por `maxLines`. Evita el `Text(x, style: context.textTheme.y)`
    repartido por la app.
* **Foundations**: `UiSizes` amplía la escala con `size96`, `size112`,
  `size120`, `size140`, `size180` y `size220`, los altos que las apps
  estaban declarando como constantes sueltas (portadas, ilustraciones,
  logos).
* **Showcase**: página `Textos` con los siete roles, color, peso, tracking y
  recorte.

## 1.1.0

Dos componentes que las apps consumidoras estaban reimplementando a mano.
Sin cambios que rompan la API pública respecto a la 1.0.0.

### Agregado

* **Átomos**:
  * `UiTag`: etiqueta compacta de solo lectura, para marcar contenido (un
    estado, una categoría, un precio). A diferencia de `UiChip` no es
    interactiva. Con `color` se tiñe (texto del color, fondo translúcido) y
    con `onImage` toma fondo oscuro y texto claro para ir encima de una foto.
* **Moléculas**:
  * `UiIconText`: línea de ícono + texto que ocupa el resto del ancho, con
    proporción por `UiSize`, colores de ícono y texto configurables y recorte
    opcional con puntos suspensivos.

## 1.0.0

El color entra al pipeline de capas del sistema. Hasta ahora era el único
token que se saltaba `foundations → tokens → theme`: la app pasaba sus
colores directo al theme y tenía que reconstruir a mano las superficies con
un `copyWith` sobre el `ColorScheme`, porque Material 3 no las deriva bien a
partir de un acento muy saturado. Ahora el color tiene sus dos capas, como
los tamaños (`UiSizes` → `UiSpacing`), y el sistema trae una identidad por
defecto que la app sobreescribe solo si su marca lo pide.

Incluye cambios que rompen la API respecto a la 0.2.0 (ver **Cambios que
rompen compatibilidad**).

### Agregado

* **Foundations**: `UiColors`, escala cruda de color del sistema (marca,
  estado, neutros oscuros y claros). Valores sin misión, como `UiSizes`.
* **Tokens**: `UiPalette`, paleta semántica que da misión a `UiColors`:
  `primary`/`onPrimary`, `secondary`/`onSecondary`, `background`, `surface`,
  `surfaceRaised`, `onSurface`, `onSurfaceMuted`, `outline` y
  `danger`/`onDanger`. Trae `UiPalette.dark` y `UiPalette.light` como
  identidad por defecto, y `copyWith` para sobreescribir solo lo que cambie.
  Los colores de estado siguen en `UiStatusColors`, sin solaparse con la
  paleta.
* **Tipografía empaquetada**: la fuente del sistema (Poppins) viaja en el
  propio paquete, como ya hacía la animación de `UiLoader`. `UiFonts.body` y
  `UiFonts.heading` son los tokens; las apps consumidoras no declaran el
  asset ni pasan `fontFamily`.
* **Theme**: `UiKitTheme` ahora resuelve las superficies, los temas de
  componente (`appBarTheme`, `snackBarTheme`, `bottomSheetTheme`,
  `dialogTheme`, `cardTheme` con borde, `scaffoldBackgroundColor`,
  `canvasColor`, `dividerColor`) y la tipografía del sistema —titulares en
  peso alto con tracking negativo, etiquetas con más peso y tracking
  positivo— que antes cada app duplicaba.

### Movido

* `UiStatusColors` pasa de `theme/` a `tokens/`: es un token semántico de
  color, no parte de la construcción del `ThemeData`. `theme/` queda solo con
  `UiKitTheme` y la extensión de `BuildContext`. El import público no cambia
  (todo sale de `package:app_ui_kit/app_ui_kit.dart`).

### Cambios que rompen compatibilidad

* `UiKitTheme.light/dark` ya no reciben `primary` ni `secondary` (el
  `primary` era obligatorio). Reciben `palette: UiPalette`, con default del
  sistema. Migración:

  ```dart
  // Antes
  UiKitTheme.dark(primary: brandPrimary, secondary: brandSecondary);
  // Ahora
  UiKitTheme.dark(
    palette: UiPalette.dark.copyWith(
      primary: brandPrimary,
      secondary: brandSecondary,
    ),
  );
  ```

* `UiStatusColors.light` y `UiStatusColors.dark` cambian de valor: ahora son
  los estados de la identidad del sistema.
* El tema ya no deriva las superficies de `ColorScheme.fromSeed`: las impone
  la paleta. Una app que dependiera de los tonos derivados verá otros
  fondos.
* La tipografía del sistema se aplica siempre. Los titulares pasan a
  `FontWeight.w900` con `letterSpacing: -0.8` y `height: 1.05`.
* `fontFamily` y `headingFontFamily` dejan de ser opcionales (`String?`) y
  pasan a `String` con Poppins por defecto. Una app que no pasaba fuente
  usaba la del sistema operativo; ahora usa la del sistema de diseño.

### Cambiado

* El README deja de declarar que "la marca se inyecta en runtime y no hay
  alias estáticos de color": ahora sí los hay (`UiPalette`), y el override
  es explícito.

## 0.2.0

Nuevas moléculas para flujos de autenticación y confirmación, y el
indicador de carga ahora usa una animación Lottie empaquetada. Sin cambios
que rompan la API pública respecto a la 0.1.0.

### Agregado

* **Moléculas**:
  * `UiOtpField`: campo de ingreso de código (OTP) con casillas
    individuales, avance y retroceso de foco automático y callbacks
    `onChanged`/`onCompleted` (este último se dispara una sola vez por
    código completo).
  * `UiCheckOption`: opción de aceptación con círculo seleccionable y texto
    que puede incluir un enlace (ej. términos y condiciones); toda la fila
    es área táctil.
  * `UiSuccessView`: vista de confirmación centrada con ícono, título,
    mensaje y acción principal.
* **Showcase**: páginas de ejemplo para las tres moléculas nuevas
  (`Opción de aceptación`, `Código OTP`, `Vista de éxito`).
* **Dependencia**: `lottie` para animaciones empaquetadas en el paquete.

### Cambiado

* `UiLoader` ahora renderiza una animación Lottie empaquetada en el propio
  paquete (`assets/animations/loading.json`) en lugar de un
  `CircularProgressIndicator`. La API pública (`size: UiSize`, `label`) no
  cambia y las apps consumidoras no necesitan declarar ningún asset.

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

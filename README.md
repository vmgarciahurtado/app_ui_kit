# app_ui_kit

Sistema de diseño reutilizable para Flutter, organizado con **Atomic Design**.
El sistema aporta la identidad por defecto —paleta y tipografía— y toda la
consistencia (tokens, theming y componentes); el consumidor solo sobreescribe
lo que su marca pida.

**Showcase en vivo:** https://uikit.vmgarcia.online

## Video

Recorrido por los componentes y el showcase:
[Ver en YouTube](https://youtu.be/RwVyz5fTxxY)

## Arquitectura

```
lib/src/
├── foundations/   # Escala cruda (UiSizes, UiColors) + vocabulario del sistema (UiSize, UiStatus)
├── tokens/        # Decisiones con nombre y misión: UiSpacing, UiRadius, UiIconSize, UiBreakpoints, UiPalette, UiStatusColors, UiFonts
├── theme/         # UiKitTheme y la extensión de BuildContext
├── atoms/         # UiButton, UiText, UiTextField, UiChip, UiTag, UiLoader, UiAvatar
├── molecules/     # UiCard, UiBanner, UiEmptyState, UiConfirmDialog, UiListTile, UiIconText
├── organisms/     # UiListSection, UiProfileHeader
└── templates/     # UiPageTemplate, UiDetailPageTemplate
```

Las **páginas** (último nivel de Atomic Design) son instancias de una plantilla
con datos reales, por lo que viven en la app consumidora y no en el paquete.
El showcase incluye dos de ejemplo (`Página de equipo` y `Página de perfil`).

Reglas del sistema:

La base es un pipeline de tres capas
(`foundations → tokens → theme → componentes`):

- Las **foundations** son la base sin misión concreta: las escalas crudas de
  valores (`UiSizes` para tamaños, `UiColors` para color, con nombres que
  describen el color y no su uso) y el vocabulario del sistema, que nombra sin
  decidir valores (`UiSize` para tamaños, `UiStatus` para estados). Las
  escalas solo las consumen los tokens y las traducciones internas de los
  componentes.
- Los **tokens** dan vida y misión a los valores crudos (`UiSpacing.medium`,
  `UiRadius.small`, `UiPalette.surface`), sin semántica de componente (no
  existe, por ejemplo `buttonColor`). Ningún token repite lo que ya nombra
  otro: la marca y las superficies están en `UiPalette` y los estados en
  `UiStatusColors`, sin solaparse.
- Los **componentes** traducen internamente el vocabulario a su propia
  proporción: el `UiSize.small` de un avatar no mide lo mismo que el de un
  loader, y esa decisión vive en el componente, no en la base.
- El **theme** mapea los tokens a un `ThemeData`, la única fuente de colores
  y tipografía en tiempo de ejecución: `UiPalette` se traduce a los roles de
  `ColorScheme` + `UiStatusColors`, y los componentes leen de ahí.
- Los **componentes** nunca usan colores hardcodeados: todo llega del theme
  vía `context.colorScheme`, `context.textTheme` y `context.statusColors`.
- Las **apps consumidoras** tampoco escriben valores sueltos: los tamaños
  salen de `UiSizes`, los espacios de `UiSpacing`, los radios de `UiRadius` y
  el texto de `UiText`, no de un `TextStyle` armado en la pantalla.

## Instalación

```yaml
dependencies:
  app_ui_kit:
    git: https://github.com/vmgarciahurtado/app_ui_kit
```

## Theming

Configura el tema una sola vez en tu `MaterialApp`. Sin argumentos ya trae la
identidad del sistema:

```dart
import 'package:app_ui_kit/app_ui_kit.dart';

MaterialApp(
  theme: UiKitTheme.light(),
  darkTheme: UiKitTheme.dark(),
);
```

### Tipografía

La fuente del sistema (**Poppins**) viene empaquetada: tu app no declara
ningún asset ni depende de `google_fonts`. `UiFonts.body` la usan cuerpos,
etiquetas y controles; `UiFonts.heading`, los titulares. Para usar otra:

```dart
UiKitTheme.light(
  fontFamily: 'Inter',                       // registrada en tu pubspec.yaml
  headingFontFamily: 'Sora',                 // display, headline y titleLarge
);
```

### Paleta

`UiPalette` es el token de color: nombra roles de interfaz, no colores. El
sistema trae `UiPalette.dark` y `UiPalette.light`; tu marca parte de una de
ellas y sobreescribe solo lo que cambie:

```dart
UiKitTheme.dark(
  palette: UiPalette.dark.copyWith(
    primary: const Color(0xFF4F46E5),
    secondary: const Color(0xFF0D9488),
  ),
);
```

| Rol | Uso |
|---|---|
| `primary` / `onPrimary` | Acento principal y su contenido |
| `secondary` / `onSecondary` | Acento de apoyo y su contenido |
| `background` | Fondo de la app (scaffold y canvas) |
| `surface` | Tarjetas, campos, hojas y diálogos |
| `surfaceRaised` | Menús, snackbars y chips sin seleccionar |
| `onSurface` / `onSurfaceMuted` | Contenido principal y secundario |
| `outline` | Bordes y separadores |
| `danger` / `onDanger` | Error y acciones destructivas (`ColorScheme.error`) |

Las superficies son explícitas (no derivadas por `ColorScheme.fromSeed`)
porque Material 3 no las deriva bien a partir de un acento muy saturado.

### Colores de estado

`ColorScheme` de Material solo trae `error`. El sistema agrega `success`,
`warning` e `info` en `UiStatusColors`, un token aparte de la paleta que se
registra como `ThemeExtension` y se lee con `context.statusColors`:

```dart
UiKitTheme.light(
  statusColors: const UiStatusColors(
    success: Color(0xFF15803D),
    warning: Color(0xFFB45309),
    info: Color(0xFF1D4ED8),
  ),
);
```

### Acceso desde el contexto

```dart
context.colorScheme.primary
context.textTheme.titleMedium
context.statusColors.success
```

## Componentes

| Componente | Nivel | Variantes / capacidades |
|---|---|---|
| `UiButton` | Átomo | `primary`, `secondary`, `outline`, `ghost`, `danger` · ícono, loading, expanded |
| `UiText` | Átomo | roles `display`…`label` · color, peso, tracking, recorte |
| `UiTextField` | Átomo | label, hint, helper, error, prefijo, contraseña con toggle, multilínea |
| `UiChip` | Átomo | estático, seleccionable, eliminable, con ícono |
| `UiTag` | Átomo | etiqueta de solo lectura · teñida por color de estado o sobre imagen |
| `UiLoader` | Átomo | tamaños con `UiSize` (`small`/`medium`/`large`), etiqueta opcional |
| `UiAvatar` | Átomo | imagen o iniciales, tamaños con `UiSize` (`small`/`medium`/`large`) |
| `UiCard` | Molécula | padding consistente, `onTap` con ripple |
| `UiBanner` | Molécula | `UiStatus` (`info`, `success`, `warning`, `error`) · título y cierre opcionales |
| `UiEmptyState` | Molécula | ícono, título, mensaje y acción opcionales |
| `UiIconText` | Molécula | ícono + texto, proporción con `UiSize`, recorte opcional |
| `UiConfirmDialog` | Molécula | widget puro con `onConfirm`/`onCancel`; `show()` resuelve `true`/`false`/`null` |
| `UiListTile` | Molécula | avatar, título, subtítulo, tag como chip, `onTap` |
| `UiListSection` | Organismo | encabezado con acción, ítems con avatar/tag, `emptyState` |
| `UiProfileHeader` | Organismo | avatar, nombre, subtítulo, tags como chips, acciones |
| `UiPageTemplate` | Plantilla | AppBar, secciones con ancho máximo responsive, footer de acción |
| `UiDetailPageTemplate` | Plantilla | encabezado fijo bajo el AppBar, secciones desplazables, footer |

Ejemplo:

```dart
UiButton(
  label: 'Guardar',
  icon: Icons.check,
  loading: saving,
  onPressed: _save,
);

final confirmed = await UiConfirmDialog.show(
  context: context,
  title: '¿Eliminar elemento?',
  message: 'Esta acción no se puede deshacer.',
  confirmLabel: 'Eliminar',
  danger: true,
);
```

## Showcase

La app de ejemplo en [example/](example/) documenta visualmente cada componente
con sus variantes, navegando por categorías (tokens, átomos, moléculas,
organismos, plantillas y páginas) con `MenuAnchor`, y con toggle de tema
claro/oscuro.

```bash
cd example
flutter run -d chrome
```

## Despliegue del showcase

El [Dockerfile](Dockerfile) compila el showcase en una etapa con el SDK de
Flutter y lo sirve con nginx. En Coolify: crear una app desde este repo con
build pack *Dockerfile*, asignar el dominio `uikit.vmgarcia.online` y Coolify
se encarga del HTTPS y del redeploy en cada push.

```bash
# Probar localmente
docker build -t app_ui_kit_showcase .
docker run -p 8080:80 app_ui_kit_showcase
```

## Tests

```bash
flutter test            # paquete
cd example && flutter test   # showcase
```

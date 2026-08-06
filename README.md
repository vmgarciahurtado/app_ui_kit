# app_ui_kit

Sistema de diseño reutilizable para Flutter, organizado con **Atomic Design**.
El consumidor controla la identidad visual (colores de marca, fuentes y colores
de estado); el sistema aporta la consistencia (tokens, theming y componentes).

**Showcase en vivo:** https://uikit.vmgarcia.online

## Video

Recorrido por los componentes y el showcase:
[Ver en YouTube](https://youtu.be/RwVyz5fTxxY)

## Arquitectura

```
lib/src/
├── foundations/   # Escala cruda (UiSizes) + vocabulario del sistema (UiSize, UiStatus)
├── tokens/        # Decisiones con nombre y misión: UiSpacing, UiRadius, UiIconSize, UiBreakpoints
├── theme/         # UiKitTheme, UiStatusColors, extensión de BuildContext
├── atoms/         # UiButton, UiTextField, UiChip, UiLoader, UiAvatar
├── molecules/     # UiCard, UiBanner, UiEmptyState, UiConfirmDialog, UiListTile
├── organisms/     # UiListSection, UiProfileHeader
└── templates/     # UiPageTemplate, UiDetailPageTemplate
```

Las **páginas** (último nivel de Atomic Design) son instancias de una plantilla
con datos reales, por lo que viven en la app consumidora y no en el paquete.
El showcase incluye dos de ejemplo (`Página de equipo` y `Página de perfil`).

Reglas del sistema:

La base es un pipeline de tres capas
(`foundations → tokens → theme → componentes`):

- Las **foundations** son la base sin misión concreta: la escala cruda de
  valores (`UiSizes`) y el vocabulario del sistema, que nombra sin decidir
  valores (`UiSize` para tamaños, `UiStatus` para estados). La escala solo
  la consumen los tokens y las traducciones internas de los componentes.
- Los **tokens** dan vida y misión a los valores crudos (`UiSpacing.medium`,
  `UiRadius.small`), sin semántica de componente (no existe, por ejemplo `buttonColor`).
- Los **componentes** traducen internamente el vocabulario a su propia
  proporción: el `UiSize.small` de un avatar no mide lo mismo que el de un
  loader, y esa decisión vive en el componente, no en la base.
- El **theme** mapea tokens + marca del consumidor a un `ThemeData`, la
  única fuente de colores y tipografía. Como la marca se inyecta en
  runtime, la correlación semántica de color no son alias estáticos sino
  los roles de `ColorScheme` + `UiStatusColors`.
- Los **componentes** nunca usan colores hardcodeados: todo llega del theme
  vía `context.colorScheme`, `context.textTheme` y `context.statusColors`.

## Instalación

```yaml
dependencies:
  app_ui_kit:
    git: https://github.com/vmgarciahurtado/app_ui_kit
```

## Theming

Configura el tema una sola vez en tu `MaterialApp`:

```dart
import 'package:app_ui_kit/app_ui_kit.dart';

MaterialApp(
  theme: UiKitTheme.light(
    primary: const Color(0xFF4F46E5),
    secondary: const Color(0xFF0D9488),      // opcional
    fontFamily: 'Inter',                     // opcional, fuente base
    headingFontFamily: 'Sora',               // opcional, display/headline/titleLarge
  ),
  darkTheme: UiKitTheme.dark(primary: const Color(0xFF4F46E5)),
);
```

> Las fuentes se registran en el `pubspec.yaml` de tu app. El paquete es
> agnóstico a la fuente: usa assets locales o `google_fonts`.

### Colores de estado

`ColorScheme` de Material solo trae `error`. El sistema agrega `success`,
`warning` e `info` como `ThemeExtension`, con defaults sobreescribibles:

```dart
UiKitTheme.light(
  primary: myBrand,
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
| `UiTextField` | Átomo | label, hint, helper, error, prefijo, contraseña con toggle, multilínea |
| `UiChip` | Átomo | estático, seleccionable, eliminable, con ícono |
| `UiLoader` | Átomo | tamaños con `UiSize` (`small`/`medium`/`large`), etiqueta opcional |
| `UiAvatar` | Átomo | imagen o iniciales, tamaños con `UiSize` (`small`/`medium`/`large`) |
| `UiCard` | Molécula | padding consistente, `onTap` con ripple |
| `UiBanner` | Molécula | `UiStatus` (`info`, `success`, `warning`, `error`) · título y cierre opcionales |
| `UiEmptyState` | Molécula | ícono, título, mensaje y acción opcionales |
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

**22 archivos, 148 pruebas, 100 % de cobertura de líneas.**

```bash
flutter test
```

```bash
./test/scripts/coverage.sh          # falla si baja de 95 %
./test/scripts/coverage.sh --html   # abre el reporte navegable
```

```bash
cd example && flutter test          # showcase
```

La cobertura requiere `lcov`: `brew install lcov` (macOS) o `apt install lcov`.

`test/` refleja `lib/src/` archivo por archivo. Lo compartido está en
`test/helpers/pump_kit.dart` (`pumpKit` para componentes sueltos, `pumpKitHome`
para plantillas), que monta todo dentro de `UiKitTheme`.

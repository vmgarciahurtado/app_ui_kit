# Ui Kit System Design

A Flutter design system package with configurable theming, and UI components. Built to give consuming apps full control over colors and typography while keeping UI consistency.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  app_ui_kit: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Setup

Configure the theme in your app's `main.dart` using `UiKitThemeConfig` and `UiKitTheme`:

```dart
import 'package:app_ui_kit/app_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const config = UiKitThemeConfig(
      primaryColor: Colors.blue,
      secondaryColor: Colors.indigo,
      primaryFont: 'YourPrimaryFont',
      secondaryFont: 'YourSecondaryFont',
    );

    return MaterialApp(
      theme: UiKitTheme.light(config),
      darkTheme: UiKitTheme.dark(config),
      home: const MyHomePage(),
    );
  }
}
```

> Fonts must be registered in your app's `pubspec.yaml`. The package is font-source agnostic — use local assets or any font package like `google_fonts`.

### Font roles

| Text roles | Font used |
|---|---|
| `display*`, `headline*` | `primaryFont` |
| `title*`, `body*` | `secondaryFont` |
| `label*` |`secondaryFont` |

## Components

### UiKitTextText
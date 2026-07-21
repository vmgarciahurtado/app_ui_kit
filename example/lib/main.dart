import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import 'showcase_shell.dart';

void main() => runApp(const ShowcaseApp());

/// Showcase del sistema de diseño app_ui_kit.
///
/// La identidad visual (primary, secondary y fuentes) se define una sola vez
/// aquí; todo lo demás sale del sistema.
class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.light;

  bool get _isDark => _themeMode == ThemeMode.dark;

  void _toggleTheme() {
    setState(() => _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF4F46E5);
    const Color secondary = Color(0xFF0D9488);

    return MaterialApp(
      title: 'app_ui_kit',
      debugShowCheckedModeBanner: false,
      theme: UiKitTheme.light(primary: primary, secondary: secondary),
      darkTheme: UiKitTheme.dark(primary: primary, secondary: secondary),
      themeMode: _themeMode,
      home: ShowcaseShell(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}

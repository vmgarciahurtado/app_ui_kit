import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import 'showcase_shell.dart';

void main() => runApp(const ShowcaseApp());

/// Showcase del sistema de diseño app_ui_kit.
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
    return MaterialApp(
      title: 'app_ui_kit',
      debugShowCheckedModeBanner: false,
      theme: UiKitTheme.light(),
      darkTheme: UiKitTheme.dark(),
      themeMode: _themeMode,
      home: ShowcaseShell(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}

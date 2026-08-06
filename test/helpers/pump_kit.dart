import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Monta los componentes dentro del tema real del kit.

/// Tema de referencia: un primario fijo mantiene estables los derivados.
ThemeData kitLight() => UiKitTheme.light(primary: Colors.indigo);

ThemeData kitDark() => UiKitTheme.dark(primary: Colors.indigo);

/// Para componentes sueltos: los envuelve en un `Scaffold` centrado.
Future<void> pumpKit(
  WidgetTester tester,
  Widget child, {
  ThemeData? theme,
}) => tester.pumpWidget(
  MaterialApp(
    theme: theme ?? kitLight(),
    home: Scaffold(body: Center(child: child)),
  ),
);

/// Para plantillas y cualquier cosa que traiga su propio `Scaffold`.
Future<void> pumpKitHome(
  WidgetTester tester,
  Widget home, {
  ThemeData? theme,
}) => tester.pumpWidget(
  MaterialApp(theme: theme ?? kitLight(), home: home),
);

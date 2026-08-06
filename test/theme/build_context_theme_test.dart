import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Los atajos de contexto son la API que más se usa desde la app consumidora.
void main() {
  /// Monta [child] y devuelve el contexto desde el que leer los atajos.
  Future<BuildContext> contextIn(
    WidgetTester tester, {
    ThemeData? theme,
  }) async {
    late BuildContext captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Builder(
          builder: (BuildContext context) {
            captured = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return captured;
  }

  testWidgets('leen el tema activo, no uno por defecto', (
    WidgetTester tester,
  ) async {
    final BuildContext context = await contextIn(
      tester,
      theme: UiKitTheme.light(primary: Colors.indigo),
    );

    expect(context.theme.brightness, Brightness.light);
    expect(context.colorScheme, context.theme.colorScheme);
    expect(context.textTheme, context.theme.textTheme);
    expect(context.statusColors, UiStatusColors.light);
  });

  testWidgets('en tema oscuro devuelven los colores oscuros', (
    WidgetTester tester,
  ) async {
    final BuildContext context = await contextIn(
      tester,
      theme: UiKitTheme.dark(primary: Colors.indigo),
    );

    expect(context.statusColors, UiStatusColors.dark);
  });

  testWidgets('sin la extensión registrada caen a los colores claros', (
    WidgetTester tester,
  ) async {
    // Con un `ThemeData` propio, `statusColors` no puede reventar.
    final BuildContext context = await contextIn(tester, theme: ThemeData());

    expect(context.statusColors, UiStatusColors.light);
  });
}

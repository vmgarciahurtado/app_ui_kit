import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('muestra título, mensaje y acción', (
    WidgetTester tester,
  ) async {
    bool acted = false;
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        message: 'Todo salió bien.',
        actionLabel: 'Continuar',
        onAction: () => acted = true,
      ),
    );

    expect(find.text('¡Listo!'), findsOneWidget);
    expect(find.text('Todo salió bien.'), findsOneWidget);

    await tester.tap(find.widgetWithText(UiButton, 'Continuar'));

    expect(acted, isTrue);
  });

  testWidgets('el mensaje es opcional', (WidgetTester tester) async {
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        actionLabel: 'Continuar',
        onAction: () {},
      ),
    );

    expect(find.text('¡Listo!'), findsOneWidget);
    expect(find.widgetWithText(UiButton, 'Continuar'), findsOneWidget);
  });

  testWidgets('sin ícono propio usa el check con el color de éxito', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        actionLabel: 'Continuar',
        onAction: () {},
      ),
    );

    // Que el default no requiera assets del consumidor es parte del contrato.
    final Icon icon = tester.widget<Icon>(
      find.byIcon(Icons.check_circle_rounded),
    );
    expect(icon.color, UiStatusColors.light.success);
  });

  testWidgets('el color de éxito sale del tema, no está quemado', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        actionLabel: 'Continuar',
        onAction: () {},
      ),
      theme: kitDark(),
    );

    expect(
      tester.widget<Icon>(find.byIcon(Icons.check_circle_rounded)).color,
      UiStatusColors.dark.success,
    );
  });

  testWidgets('acepta un ícono propio', (WidgetTester tester) async {
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        actionLabel: 'Continuar',
        onAction: () {},
        icon: const Icon(Icons.celebration),
      ),
    );

    expect(find.byIcon(Icons.celebration), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsNothing);
  });

  testWidgets('la acción ocupa todo el ancho', (WidgetTester tester) async {
    // Es el cierre de un flujo: el botón es el único camino a seguir.
    await pumpKit(
      tester,
      UiSuccessView(
        title: '¡Listo!',
        actionLabel: 'Continuar',
        onAction: () {},
      ),
    );

    expect(
      tester.widget<UiButton>(find.byType(UiButton)).expanded,
      isTrue,
    );
  });
}

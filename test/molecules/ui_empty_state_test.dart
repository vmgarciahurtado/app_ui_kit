import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('el título es lo único obligatorio', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiEmptyState(title: 'Sin resultados'));

    expect(find.text('Sin resultados'), findsOneWidget);
    expect(find.byType(UiButton), findsNothing);
  });

  testWidgets('muestra mensaje y acción cuando se los dan', (
    WidgetTester tester,
  ) async {
    bool retried = false;
    await pumpKit(
      tester,
      UiEmptyState(
        title: 'Sin resultados',
        message: 'Intenta con otra búsqueda.',
        action: UiButton(label: 'Reintentar', onPressed: () => retried = true),
      ),
    );

    expect(find.text('Intenta con otra búsqueda.'), findsOneWidget);
    await tester.tap(find.widgetWithText(UiButton, 'Reintentar'));

    expect(retried, isTrue);
  });

  testWidgets('trae un ícono por defecto y acepta otro', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiEmptyState(title: 'Sin mensajes'));
    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);

    await pumpKit(
      tester,
      const UiEmptyState(title: 'Sin eventos', icon: Icons.event_busy),
    );

    expect(find.byIcon(Icons.event_busy), findsOneWidget);
    expect(find.byIcon(Icons.inbox_outlined), findsNothing);
  });

  testWidgets('el texto va centrado', (WidgetTester tester) async {
    // Alineado a la izquierda se leería como contenido a medio cargar.
    await pumpKit(
      tester,
      const UiEmptyState(title: 'Sin resultados', message: 'Prueba con otro.'),
    );

    expect(
      tester.widget<Text>(find.text('Sin resultados')).textAlign,
      TextAlign.center,
    );
    expect(
      tester.widget<Text>(find.text('Prueba con otro.')).textAlign,
      TextAlign.center,
    );
  });

  testWidgets('ocupa solo lo que necesita', (WidgetTester tester) async {
    // Va dentro de listas y tarjetas: expandirse rompería su layout.
    await pumpKit(tester, const UiEmptyState(title: 'Sin resultados'));

    expect(
      tester.widget<Column>(find.byType(Column)).mainAxisSize,
      MainAxisSize.min,
    );
  });
}

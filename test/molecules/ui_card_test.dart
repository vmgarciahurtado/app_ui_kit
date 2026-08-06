import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('sin onTap no es interactiva', (WidgetTester tester) async {
    await pumpKit(tester, const UiCard(child: Text('Contenido')));

    expect(find.text('Contenido'), findsOneWidget);
    // Sin InkWell no hay ripple: una tarjeta estática no debe parecer tocable.
    expect(find.byType(InkWell), findsNothing);
  });

  testWidgets('con onTap responde al toque con ripple', (
    WidgetTester tester,
  ) async {
    bool tapped = false;
    await pumpKit(
      tester,
      UiCard(onTap: () => tapped = true, child: const Text('Contenido')),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await tester.tap(find.text('Contenido'));

    expect(tapped, isTrue);
  });

  /// El `Card` de Material trae su propio `Padding` en cero: se busca el más
  /// cercano al contenido, que es el que pone `UiCard`.
  EdgeInsetsGeometry contentPadding(WidgetTester tester) => tester
      .widget<Padding>(
        find
            .ancestor(
              of: find.text('Contenido'),
              matching: find.byType(Padding),
            )
            .first,
      )
      .padding;

  testWidgets('aplica un padding por defecto', (WidgetTester tester) async {
    await pumpKit(tester, const UiCard(child: Text('Contenido')));

    expect(contentPadding(tester), const EdgeInsets.all(UiSpacing.medium));
  });

  testWidgets('el consumidor puede sustituir el padding', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiCard(padding: EdgeInsets.zero, child: Text('Contenido')),
    );

    expect(contentPadding(tester), EdgeInsets.zero);
  });

  testWidgets('la forma y el color salen del tema, no de la tarjeta', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiCard(child: Text('Contenido')));

    // Fijar forma propia las dejaría fuera del sistema al cambiar el tema.
    final Card card = tester.widget<Card>(find.byType(Card));
    expect(card.shape, isNull);
    expect(card.color, isNull);
  });
}

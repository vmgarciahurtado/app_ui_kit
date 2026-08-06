import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  group('contenido', () {
    testWidgets('muestra la etiqueta y su enlace', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiCheckOption(
          value: false,
          onChanged: (bool _) {},
          label: 'Acepto los',
          linkText: 'términos y condiciones',
        ),
      );

      expect(
        find.textContaining('Acepto los', findRichText: true),
        findsOneWidget,
      );
      expect(
        find.textContaining('términos y condiciones', findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('sin enlace funciona igual', (WidgetTester tester) async {
      await pumpKit(
        tester,
        UiCheckOption(value: false, onChanged: (bool _) {}, label: 'Acepto'),
      );

      expect(find.textContaining('Acepto', findRichText: true), findsOneWidget);
    });
  });

  group('estado', () {
    testWidgets('sin marcar no dibuja el check', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiCheckOption(value: false, onChanged: (bool _) {}, label: 'Acepto'),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('marcada dibuja el check', (WidgetTester tester) async {
      await pumpKit(
        tester,
        UiCheckOption(value: true, onChanged: (bool _) {}, label: 'Acepto'),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('interacción', () {
    testWidgets('toda la fila alterna el valor, no solo el círculo', (
      WidgetTester tester,
    ) async {
      // El indicador es un blanco pequeño: pedir puntería sería una barrera.
      final List<bool> changes = <bool>[];
      await pumpKit(
        tester,
        UiCheckOption(value: false, onChanged: changes.add, label: 'Acepto'),
      );

      await tester.tap(find.byType(UiCheckOption));

      expect(changes, <bool>[true]);
    });

    testWidgets('marcada, tocarla avisa que se quiere desmarcar', (
      WidgetTester tester,
    ) async {
      final List<bool> changes = <bool>[];
      await pumpKit(
        tester,
        UiCheckOption(value: true, onChanged: changes.add, label: 'Acepto'),
      );

      await tester.tap(find.byType(UiCheckOption));

      expect(changes, <bool>[false]);
    });

    testWidgets('el enlace avisa por su propio callback', (
      WidgetTester tester,
    ) async {
      bool linkTapped = false;
      final List<bool> changes = <bool>[];
      await pumpKit(
        tester,
        UiCheckOption(
          value: false,
          onChanged: changes.add,
          label: 'Acepto los',
          linkText: 'términos',
          onLinkTap: () => linkTapped = true,
        ),
      );

      // El reconocedor vive en el TextSpan del enlace, no en el párrafo.
      await tester.tapOnText(find.textRange.ofSubstring('términos'));
      await tester.pump();

      // Abrir los términos no debe contar como aceptarlos.
      expect(linkTapped, isTrue);
      expect(changes, isEmpty);
    });

    testWidgets('un enlace sin callback no rompe ni acepta por error', (
      WidgetTester tester,
    ) async {
      final List<bool> changes = <bool>[];
      await pumpKit(
        tester,
        UiCheckOption(
          value: false,
          onChanged: changes.add,
          label: 'Acepto los',
          linkText: 'términos',
        ),
      );

      await tester.tapOnText(find.textRange.ofSubstring('términos'));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(changes, isEmpty);
    });
  });
}

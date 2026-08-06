import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  group('estructura', () {
    testWidgets('pinta una casilla por dígito y respeta length', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, UiOtpField(length: 8, onCompleted: (String _) {}));

      expect(find.byType(TextField), findsNWidgets(8));
    });

    testWidgets('el default son 6 casillas, como el OTP de Supabase', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, UiOtpField(onCompleted: (String _) {}));

      expect(find.byType(TextField), findsNWidgets(6));
    });
  });

  group('escritura', () {
    testWidgets('notifica el código parcial en cada dígito', (
      WidgetTester tester,
    ) async {
      final List<String> changes = <String>[];
      await pumpKit(
        tester,
        UiOtpField(
          length: 3,
          onChanged: changes.add,
          onCompleted: (String _) {},
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), '1');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.pump();

      expect(changes, <String>['1', '12']);
    });

    testWidgets('avanza el foco al escribir', (WidgetTester tester) async {
      await pumpKit(tester, UiOtpField(length: 3, onCompleted: (String _) {}));

      await tester.enterText(find.byType(TextField).at(0), '1');
      await tester.pump();

      final TextField second = tester.widget<TextField>(
        find.byType(TextField).at(1),
      );
      expect(second.focusNode?.hasFocus, isTrue);
    });

    testWidgets('solo acepta dígitos', (WidgetTester tester) async {
      final List<String> changes = <String>[];
      await pumpKit(
        tester,
        UiOtpField(
          length: 3,
          onChanged: changes.add,
          onCompleted: (String _) {},
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'a');
      await tester.pump();

      expect(changes, isEmpty);
    });
  });

  group('completar', () {
    testWidgets('dispara onCompleted una sola vez', (
      WidgetTester tester,
    ) async {
      final List<String> completed = <String>[];
      await pumpKit(tester, UiOtpField(length: 3, onCompleted: completed.add));

      for (int i = 0; i < 3; i++) {
        await tester.enterText(find.byType(TextField).at(i), '${i + 1}');
        await tester.pump();
      }
      // Cada reenvío consume un intento de verificación en el backend.
      await tester.enterText(find.byType(TextField).at(2), '9');
      await tester.pump();

      expect(completed, <String>['123']);
    });

    testWidgets('no lo dispara con el código a medias', (
      WidgetTester tester,
    ) async {
      final List<String> completed = <String>[];
      await pumpKit(tester, UiOtpField(length: 4, onCompleted: completed.add));

      for (int i = 0; i < 3; i++) {
        await tester.enterText(find.byType(TextField).at(i), '1');
        await tester.pump();
      }

      expect(completed, isEmpty);
    });
  });

  group('borrar', () {
    testWidgets('en una casilla vacía retrocede y limpia la anterior', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, UiOtpField(length: 3, onCompleted: (String _) {}));

      await tester.enterText(find.byType(TextField).at(0), '1');
      await tester.pump();
      // El foco quedó en la casilla 1, vacía.
      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      final TextField first = tester.widget<TextField>(
        find.byType(TextField).first,
      );
      expect(first.controller?.text, isEmpty);
      expect(first.focusNode?.hasFocus, isTrue);
    });

    testWidgets('en la primera casilla no intenta retroceder más', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, UiOtpField(length: 3, onCompleted: (String _) {}));

      await tester.tap(find.byType(TextField).first);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });
}

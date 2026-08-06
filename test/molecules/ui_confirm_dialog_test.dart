import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  group('el widget es puro', () {
    testWidgets('notifica por callbacks, sin tocar el Navigator', (
      WidgetTester tester,
    ) async {
      // Separarlo del helper `show` permite montarlo sin arrastrar navegación.
      bool confirmed = false;
      bool cancelled = false;
      await pumpKit(
        tester,
        UiConfirmDialog(
          title: '¿Continuar?',
          message: 'Sin navegación involucrada.',
          onConfirm: () => confirmed = true,
          onCancel: () => cancelled = true,
        ),
      );

      await tester.tap(find.text('Confirmar'));
      expect(confirmed, isTrue);

      await tester.tap(find.text('Cancelar'));
      expect(cancelled, isTrue);
    });

    testWidgets('las etiquetas de los botones son configurables', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiConfirmDialog(
          title: '¿Eliminar?',
          message: 'No se puede deshacer.',
          confirmLabel: 'Eliminar',
          cancelLabel: 'Volver',
          onConfirm: () {},
          onCancel: () {},
        ),
      );

      expect(find.text('Eliminar'), findsOneWidget);
      expect(find.text('Volver'), findsOneWidget);
    });

    testWidgets('en modo destructivo avisa con ícono y botón de error', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiConfirmDialog(
          title: '¿Eliminar?',
          message: 'No se puede deshacer.',
          danger: true,
          onConfirm: () {},
          onCancel: () {},
        ),
      );

      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
      expect(
        tester
            .widget<UiButton>(find.widgetWithText(UiButton, 'Confirmar'))
            .variant,
        UiButtonVariant.danger,
      );
    });

    testWidgets('en modo normal no alarma con el ícono', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiConfirmDialog(
          title: '¿Continuar?',
          message: 'Todo bien.',
          onConfirm: () {},
          onCancel: () {},
        ),
      );

      expect(find.byIcon(Icons.warning_amber_outlined), findsNothing);
      expect(
        tester
            .widget<UiButton>(find.widgetWithText(UiButton, 'Confirmar'))
            .variant,
        UiButtonVariant.primary,
      );
    });
  });

  group('show()', () {
    /// Abre el diálogo desde un botón y guarda con qué resolvió.
    Future<List<bool?>> openFrom(WidgetTester tester) async {
      final List<bool?> results = <bool?>[];
      await pumpKit(
        tester,
        Builder(
          builder: (BuildContext context) => UiButton(
            label: 'Abrir',
            onPressed: () async {
              results.add(
                await UiConfirmDialog.show(
                  context: context,
                  title: '¿Eliminar?',
                  message: 'No se puede deshacer.',
                  confirmLabel: 'Eliminar',
                  danger: true,
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsOneWidget);
      return results;
    }

    testWidgets('confirmar resuelve true y cierra', (
      WidgetTester tester,
    ) async {
      final List<bool?> results = await openFrom(tester);

      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();

      expect(results, <bool?>[true]);
      expect(find.text('¿Eliminar?'), findsNothing);
    });

    testWidgets('cancelar resuelve false, no null', (
      WidgetTester tester,
    ) async {
      final List<bool?> results = await openFrom(tester);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      // `false` es "dijo que no"; `null` es "ni siquiera respondió".
      expect(results, <bool?>[false]);
      expect(find.text('¿Eliminar?'), findsNothing);
    });

    testWidgets('descartarlo tocando fuera resuelve null', (
      WidgetTester tester,
    ) async {
      final List<bool?> results = await openFrom(tester);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(results, <bool?>[null]);
    });
  });
}

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  group('variantes', () {
    testWidgets('cada una se apoya en su botón de Material', (
      WidgetTester tester,
    ) async {
      // El kit es una fachada: no reimplementa botones, los configura.
      await pumpKit(
        tester,
        const Column(
          children: <Widget>[
            UiButton(label: 'a'),
            UiButton(label: 'b', variant: UiButtonVariant.secondary),
            UiButton(label: 'c', variant: UiButtonVariant.outline),
            UiButton(label: 'd', variant: UiButtonVariant.ghost),
            UiButton(label: 'e', variant: UiButtonVariant.danger),
          ],
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      // Primary, secondary y danger son rellenos.
      expect(find.byType(FilledButton), findsNWidgets(3));
    });

    testWidgets('la variante destructiva usa el color de error del tema', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiButton(
          label: 'Eliminar',
          variant: UiButtonVariant.danger,
          onPressed: () {},
        ),
      );

      final BuildContext context = tester.element(find.byType(UiButton));
      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(
        button.style?.backgroundColor?.resolve(<WidgetState>{}),
        context.colorScheme.error,
      );
    });
  });

  group('contenido', () {
    testWidgets('sin ícono solo muestra la etiqueta', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, UiButton(label: 'Guardar', onPressed: () {}));

      expect(find.text('Guardar'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('con ícono lo pinta junto a la etiqueta', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiButton(label: 'Guardar', icon: Icons.check, onPressed: () {}),
      );

      expect(find.text('Guardar'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      // Un botón no expandido no debe estirarse por llevar ícono.
      final Row row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('cargando muestra el loader y esconde la etiqueta', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiButton(label: 'Guardar', loading: true, onPressed: () {}),
      );

      expect(find.byType(UiLoader), findsOneWidget);
      expect(find.text('Guardar'), findsNothing);
    });

    testWidgets('cargando con ícono tampoco lo muestra', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiButton(
          label: 'Guardar',
          icon: Icons.check,
          loading: true,
          onPressed: () {},
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.byType(UiLoader), findsOneWidget);
    });
  });

  group('habilitación', () {
    testWidgets('cargando no dispara la acción aunque se toque', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await pumpKit(
        tester,
        UiButton(
          label: 'Guardar',
          loading: true,
          onPressed: () => pressed = true,
        ),
      );

      await tester.tap(find.byType(UiButton));

      // Es la protección contra el doble envío.
      expect(pressed, isFalse);
    });

    testWidgets('sin onPressed queda deshabilitado', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiButton(label: 'Guardar'));

      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });

    testWidgets('con onPressed responde al toque', (
      WidgetTester tester,
    ) async {
      int taps = 0;
      await pumpKit(
        tester,
        UiButton(label: 'Guardar', onPressed: () => taps++),
      );

      await tester.tap(find.byType(UiButton));

      expect(taps, 1);
    });
  });

  group('expanded', () {
    testWidgets('expandido ocupa todo el ancho disponible', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        SizedBox(
          width: 400,
          child: UiButton(label: 'Guardar', expanded: true, onPressed: () {}),
        ),
      );

      expect(tester.getSize(find.byType(FilledButton)).width, 400);
    });

    testWidgets('sin expandir se ajusta a su contenido', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        SizedBox(
          width: 400,
          child: Center(
            child: UiButton(label: 'Guardar', onPressed: () {}),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FilledButton)).width, lessThan(400));
    });
  });
}

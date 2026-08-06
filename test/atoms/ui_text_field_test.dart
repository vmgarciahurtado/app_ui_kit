import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  EditableText editable(WidgetTester tester) =>
      tester.widget(find.byType(EditableText));

  InputDecoration decoration(WidgetTester tester) =>
      tester.widget<TextField>(find.byType(TextField)).decoration!;

  group('contraseñas', () {
    testWidgets('oculta el texto y ofrece revelarlo', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiTextField(label: 'Contraseña', obscureText: true),
      );
      expect(editable(tester).obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(editable(tester).obscureText, isFalse);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('se puede volver a ocultar', (WidgetTester tester) async {
      await pumpKit(
        tester,
        const UiTextField(label: 'Contraseña', obscureText: true),
      );

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(editable(tester).obscureText, isTrue);
    });

    testWidgets('un campo normal no muestra el botón del ojo', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiTextField(label: 'Correo'));

      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(decoration(tester).suffixIcon, isNull);
    });

    testWidgets('una contraseña se queda en una línea', (
      WidgetTester tester,
    ) async {
      // `maxLines` > 1 con texto oculto revienta: el kit lo fuerza a 1.
      await pumpKit(
        tester,
        const UiTextField(obscureText: true, maxLines: 4),
      );

      expect(tester.takeException(), isNull);
      expect(tester.widget<TextField>(find.byType(TextField)).maxLines, 1);
    });
  });

  group('decoración', () {
    testWidgets('traslada etiqueta, pista y ayuda al InputDecoration', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiTextField(
          label: 'Correo',
          hint: 'tu@correo.com',
          helperText: 'Usaremos este correo para escribirte',
        ),
      );

      final InputDecoration input = decoration(tester);
      expect(input.labelText, 'Correo');
      expect(input.hintText, 'tu@correo.com');
      expect(input.helperText, 'Usaremos este correo para escribirte');
    });

    testWidgets('el error manual llega a la decoración', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiTextField(label: 'Correo', errorText: 'Correo inválido'),
      );

      expect(find.text('Correo inválido'), findsOneWidget);
    });

    testWidgets('con prefixIcon lo pinta, sin él no reserva espacio', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiTextField(prefixIcon: Icons.mail_outline));
      expect(find.byIcon(Icons.mail_outline), findsOneWidget);

      await pumpKit(tester, const UiTextField(label: 'Correo'));
      expect(decoration(tester).prefixIcon, isNull);
    });
  });

  group('entrada', () {
    testWidgets('notifica lo que se escribe', (WidgetTester tester) async {
      final List<String> changes = <String>[];
      await pumpKit(tester, UiTextField(onChanged: changes.add));

      await tester.enterText(find.byType(TextField), 'hola');

      expect(changes, <String>['hola']);
    });

    testWidgets('el controlador del consumidor manda sobre el contenido', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller = TextEditingController(
        text: 'inicial',
      );
      addTearDown(controller.dispose);

      await pumpKit(tester, UiTextField(controller: controller));

      expect(find.text('inicial'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'editado');
      expect(controller.text, 'editado');
    });

    testWidgets('deshabilitado no acepta texto', (WidgetTester tester) async {
      await pumpKit(
        tester,
        const UiTextField(label: 'Correo', enabled: false),
      );

      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    });

    testWidgets('el validador corre dentro de un Form', (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await pumpKit(
        tester,
        Form(
          key: formKey,
          child: UiTextField(
            label: 'Correo',
            validator: (String? value) =>
                (value ?? '').contains('@') ? null : 'Correo inválido',
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Correo inválido'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'victor@correo.com');
      expect(formKey.currentState!.validate(), isTrue);
    });
  });
}

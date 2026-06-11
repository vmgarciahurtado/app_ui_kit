import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: UiKitTheme.light(primary: Colors.indigo),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('UiKitTheme', () {
    test('registra UiStatusColors como extension del tema', () {
      final theme = UiKitTheme.light(primary: Colors.indigo);
      expect(theme.extension<UiStatusColors>(), UiStatusColors.light);
    });

    test('respeta el color secundario del consumidor', () {
      final theme = UiKitTheme.dark(
        primary: Colors.indigo,
        secondary: Colors.teal,
      );
      expect(theme.colorScheme.secondary, Colors.teal);
    });

    test('aplica la fuente de titulares solo a los estilos de titular', () {
      final theme = UiKitTheme.light(
        primary: Colors.indigo,
        fontFamily: 'Inter',
        headingFontFamily: 'Sora',
      );
      expect(theme.textTheme.headlineLarge?.fontFamily, 'Sora');
      expect(theme.textTheme.titleLarge?.fontFamily, 'Sora');
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
    });
  });

  group('UiButton', () {
    testWidgets('muestra loader y se deshabilita cuando loading es true',
        (tester) async {
      var pressed = false;
      await tester.pumpWidget(_wrap(
        UiButton(label: 'Guardar', loading: true, onPressed: () {
          pressed = true;
        }),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Guardar'), findsNothing);

      await tester.tap(find.byType(UiButton));
      expect(pressed, isFalse);
    });

    testWidgets('renderiza el widget Material según la variante',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const Column(
          children: [
            UiButton(label: 'a'),
            UiButton(label: 'b', variant: .outline),
            UiButton(label: 'c', variant: .ghost),
          ],
        ),
      ));

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('UiTextField', () {
    testWidgets('alterna la visibilidad del texto oculto', (tester) async {
      await tester.pumpWidget(_wrap(
        const UiTextField(label: 'Contraseña', obscureText: true),
      ));

      EditableText editable() => tester.widget(find.byType(EditableText));
      expect(editable().obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(editable().obscureText, isFalse);
    });
  });

  group('UiBanner', () {
    testWidgets('muestra título, mensaje y botón de cerrar', (tester) async {
      var closed = false;
      await tester.pumpWidget(_wrap(
        UiBanner(
          variant: .success,
          title: 'Listo',
          message: 'Cambios guardados.',
          onClose: () => closed = true,
        ),
      ));

      expect(find.text('Listo'), findsOneWidget);
      expect(find.text('Cambios guardados.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      expect(closed, isTrue);
    });
  });

  group('UiAvatar', () {
    testWidgets('muestra las iniciales de las dos primeras palabras',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const UiAvatar(name: 'Victor García Hurtado'),
      ));
      expect(find.text('VG'), findsOneWidget);
    });
  });

  group('UiConfirmDialog', () {
    testWidgets('resuelve true al confirmar', (tester) async {
      bool? result;
      await tester.pumpWidget(_wrap(
        Builder(
          builder: (context) => UiButton(
            label: 'Abrir',
            onPressed: () async {
              result = await UiConfirmDialog.show(
                context,
                title: '¿Eliminar?',
                message: 'No se puede deshacer.',
                confirmLabel: 'Eliminar',
                danger: true,
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsOneWidget);

      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });
  });

  group('UiEmptyState', () {
    testWidgets('muestra título, mensaje y acción', (tester) async {
      await tester.pumpWidget(_wrap(
        const UiEmptyState(
          title: 'Sin resultados',
          message: 'Intenta con otra búsqueda.',
          action: UiButton(label: 'Reintentar'),
        ),
      ));

      expect(find.text('Sin resultados'), findsOneWidget);
      expect(find.text('Intenta con otra búsqueda.'), findsOneWidget);
      expect(find.byType(UiButton), findsOneWidget);
    });
  });
}

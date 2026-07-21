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
      final ThemeData theme = UiKitTheme.light(primary: Colors.indigo);
      expect(theme.extension<UiStatusColors>(), UiStatusColors.light);
    });

    test('respeta el color secundario del consumidor', () {
      final ThemeData theme = UiKitTheme.dark(
        primary: Colors.indigo,
        secondary: Colors.teal,
      );
      expect(theme.colorScheme.secondary, Colors.teal);
    });

    test('aplica la fuente de titulares solo a los estilos de titular', () {
      final ThemeData theme = UiKitTheme.light(
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
    testWidgets('muestra loader y se deshabilita cuando loading es true', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        _wrap(
          UiButton(
            label: 'Guardar',
            loading: true,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      );

      expect(find.byType(UiLoader), findsOneWidget);
      expect(find.text('Guardar'), findsNothing);

      await tester.tap(find.byType(UiButton));
      expect(pressed, isFalse);
    });

    testWidgets('renderiza el widget Material según la variante', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const Column(
            children: <Widget>[
              UiButton(label: 'a'),
              UiButton(label: 'b', variant: UiButtonVariant.outline),
              UiButton(label: 'c', variant: UiButtonVariant.ghost),
            ],
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('UiTextField', () {
    testWidgets('alterna la visibilidad del texto oculto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiTextField(label: 'Contraseña', obscureText: true),
        ),
      );

      EditableText editable() => tester.widget(find.byType(EditableText));
      expect(editable().obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(editable().obscureText, isFalse);
    });
  });

  group('UiBanner', () {
    testWidgets('muestra título, mensaje y botón de cerrar', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        _wrap(
          UiBanner(
            status: UiStatus.success,
            title: 'Listo',
            message: 'Cambios guardados.',
            onClose: () => closed = true,
          ),
        ),
      );

      expect(find.text('Listo'), findsOneWidget);
      expect(find.text('Cambios guardados.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      expect(closed, isTrue);
    });
  });

  group('UiAvatar', () {
    testWidgets('muestra las iniciales de las dos primeras palabras', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiAvatar(name: 'Victor García Hurtado'),
        ),
      );
      expect(find.text('VG'), findsOneWidget);
    });
  });

  group('UiListTile', () {
    testWidgets('muestra avatar, textos y etiqueta', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiListTile(
            title: 'Victor García',
            subtitle: 'Desarrollador móvil',
            avatarName: 'Victor García',
            tag: 'Admin',
          ),
        ),
      );

      expect(find.byType(UiAvatar), findsOneWidget);
      expect(find.text('Victor García'), findsOneWidget);
      expect(find.text('Desarrollador móvil'), findsOneWidget);
      expect(find.widgetWithText(UiChip, 'Admin'), findsOneWidget);
    });
  });

  group('UiConfirmDialog', () {
    testWidgets('es un widget puro: notifica por callbacks sin Navigator', (
      WidgetTester tester,
    ) async {
      bool confirmed = false;
      bool cancelled = false;
      await tester.pumpWidget(
        _wrap(
          UiConfirmDialog(
            title: '¿Continuar?',
            message: 'Sin navegación involucrada.',
            onConfirm: () => confirmed = true,
            onCancel: () => cancelled = true,
          ),
        ),
      );

      await tester.tap(find.text('Confirmar'));
      expect(confirmed, isTrue);

      await tester.tap(find.text('Cancelar'));
      expect(cancelled, isTrue);
    });

    testWidgets('resuelve true al confirmar', (WidgetTester tester) async {
      bool? result;
      await tester.pumpWidget(
        _wrap(
          Builder(
            builder: (BuildContext context) => UiButton(
              label: 'Abrir',
              onPressed: () async {
                result = await UiConfirmDialog.show(
                  context: context,
                  title: '¿Eliminar?',
                  message: 'No se puede deshacer.',
                  confirmLabel: 'Eliminar',
                  danger: true,
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsOneWidget);

      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });
  });

  group('UiListSection', () {
    testWidgets('muestra encabezado, acción y elementos con avatar y tag', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiListSection(
            title: 'Integrantes',
            action: UiButton(label: 'Agregar', variant: UiButtonVariant.ghost),
            items: <UiListItem>[
              UiListItem(
                title: 'Victor García',
                subtitle: 'victor@correo.com',
                avatarName: 'Victor García',
                tag: 'Admin',
              ),
              UiListItem(title: 'Laura Pérez', avatarName: 'Laura Pérez'),
            ],
          ),
        ),
      );

      expect(find.text('Integrantes'), findsOneWidget);
      expect(find.text('Agregar'), findsOneWidget);
      expect(find.text('Victor García'), findsOneWidget);
      expect(find.byType(UiAvatar), findsNWidgets(2));
      expect(find.widgetWithText(UiChip, 'Admin'), findsOneWidget);
    });

    testWidgets('muestra el emptyState cuando no hay elementos', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiListSection(title: 'Invitaciones', items: <UiListItem>[]),
        ),
      );

      expect(find.byType(UiEmptyState), findsOneWidget);
      expect(find.text('Sin elementos'), findsOneWidget);
    });
  });

  group('UiProfileHeader', () {
    testWidgets('muestra avatar, nombre, subtítulo, tags y acciones', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiProfileHeader(
            name: 'Victor García',
            subtitle: 'Desarrollador móvil',
            tags: <String>['Flutter', 'Dart'],
            actions: <Widget>[UiButton(label: 'Seguir')],
          ),
        ),
      );

      expect(find.byType(UiAvatar), findsOneWidget);
      expect(find.text('Victor García'), findsOneWidget);
      expect(find.text('Desarrollador móvil'), findsOneWidget);
      expect(find.byType(UiChip), findsNWidgets(2));
      expect(find.widgetWithText(UiButton, 'Seguir'), findsOneWidget);
    });
  });

  group('UiDetailPageTemplate', () {
    testWidgets('renderiza título, encabezado fijo y secciones', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: UiKitTheme.light(primary: Colors.indigo),
          home: const UiDetailPageTemplate(
            title: 'Perfil',
            header: Text('Encabezado'),
            sections: <Widget>[Text('Sección A'), Text('Sección B')],
            footer: UiButton(label: 'Contactar', expanded: true),
          ),
        ),
      );

      expect(find.text('Perfil'), findsOneWidget);
      expect(find.text('Encabezado'), findsOneWidget);
      expect(find.text('Sección A'), findsOneWidget);
      expect(find.text('Sección B'), findsOneWidget);
      expect(find.widgetWithText(UiButton, 'Contactar'), findsOneWidget);
    });
  });

  group('UiPageTemplate', () {
    testWidgets('renderiza título, secciones y footer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: UiKitTheme.light(primary: Colors.indigo),
          home: const UiPageTemplate(
            title: 'Mi equipo',
            sections: <Widget>[Text('Sección A'), Text('Sección B')],
            footer: UiButton(label: 'Invitar', expanded: true),
          ),
        ),
      );

      expect(find.text('Mi equipo'), findsOneWidget);
      expect(find.text('Sección A'), findsOneWidget);
      expect(find.text('Sección B'), findsOneWidget);
      expect(find.widgetWithText(UiButton, 'Invitar'), findsOneWidget);
    });
  });

  group('UiEmptyState', () {
    testWidgets('muestra título, mensaje y acción', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const UiEmptyState(
            title: 'Sin resultados',
            message: 'Intenta con otra búsqueda.',
            action: UiButton(label: 'Reintentar'),
          ),
        ),
      );

      expect(find.text('Sin resultados'), findsOneWidget);
      expect(find.text('Intenta con otra búsqueda.'), findsOneWidget);
      expect(find.byType(UiButton), findsOneWidget);
    });
  });
}

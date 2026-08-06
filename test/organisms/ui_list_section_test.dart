import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('muestra encabezado, acción y elementos con avatar y tag', (
    WidgetTester tester,
  ) async {
    bool added = false;
    await pumpKit(
      tester,
      UiListSection(
        title: 'Integrantes',
        action: UiButton(
          label: 'Agregar',
          variant: UiButtonVariant.ghost,
          onPressed: () => added = true,
        ),
        items: const <UiListItem>[
          UiListItem(
            title: 'Victor García',
            subtitle: 'victor@correo.com',
            avatarName: 'Victor García',
            tag: 'Admin',
          ),
          UiListItem(title: 'Laura Pérez', avatarName: 'Laura Pérez'),
        ],
      ),
    );

    expect(find.text('Integrantes'), findsOneWidget);
    expect(find.text('Victor García'), findsOneWidget);
    expect(find.byType(UiAvatar), findsNWidgets(2));
    expect(find.widgetWithText(UiChip, 'Admin'), findsOneWidget);

    await tester.tap(find.widgetWithText(UiButton, 'Agregar'));
    expect(added, isTrue);
  });

  testWidgets('sin acción el encabezado deja el título solo', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiListSection(
        title: 'Integrantes',
        items: <UiListItem>[UiListItem(title: 'Victor García')],
      ),
    );

    expect(find.text('Integrantes'), findsOneWidget);
    expect(find.byType(UiButton), findsNothing);
  });

  testWidgets('cada elemento se renderiza como una fila del sistema', (
    WidgetTester tester,
  ) async {
    // Compone moléculas del kit en vez de dibujar filas propias.
    await pumpKit(
      tester,
      const UiListSection(
        title: 'Integrantes',
        items: <UiListItem>[
          UiListItem(title: 'Victor García'),
          UiListItem(title: 'Laura Pérez'),
        ],
      ),
    );

    expect(find.byType(UiListTile), findsNWidgets(2));
    expect(find.byType(UiCard), findsOneWidget);
  });

  testWidgets('el tap de un elemento llega a su callback', (
    WidgetTester tester,
  ) async {
    String? opened;
    await pumpKit(
      tester,
      UiListSection(
        title: 'Integrantes',
        items: <UiListItem>[
          UiListItem(
            title: 'Victor García',
            onTap: () => opened = 'Victor García',
          ),
          UiListItem(title: 'Laura Pérez', onTap: () => opened = 'Laura Pérez'),
        ],
      ),
    );

    await tester.tap(find.text('Laura Pérez'));

    // Un callback compartido abriría siempre el mismo perfil.
    expect(opened, 'Laura Pérez');
  });

  group('vacío', () {
    testWidgets('sin elementos muestra el estado vacío por defecto', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiListSection(title: 'Invitaciones', items: <UiListItem>[]),
      );

      expect(find.byType(UiEmptyState), findsOneWidget);
      expect(find.text('Sin elementos'), findsOneWidget);
      expect(find.byType(UiListTile), findsNothing);
    });

    testWidgets('el consumidor puede poner el suyo', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiListSection(
          title: 'Invitaciones',
          items: <UiListItem>[],
          emptyState: UiEmptyState(title: 'Nadie pendiente'),
        ),
      );

      expect(find.text('Nadie pendiente'), findsOneWidget);
      expect(find.text('Sin elementos'), findsNothing);
    });

    testWidgets('el encabezado sigue visible con la lista vacía', (
      WidgetTester tester,
    ) async {
      // Es lo que le dice al usuario qué está vacío.
      await pumpKit(
        tester,
        const UiListSection(title: 'Invitaciones', items: <UiListItem>[]),
      );

      expect(find.text('Invitaciones'), findsOneWidget);
    });
  });
}

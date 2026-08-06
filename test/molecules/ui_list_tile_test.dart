import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('con todo puesto muestra avatar, textos y etiqueta', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiListTile(
        title: 'Victor García',
        subtitle: 'Desarrollador móvil',
        avatarName: 'Victor García',
        tag: 'Admin',
      ),
    );

    expect(find.byType(UiAvatar), findsOneWidget);
    expect(find.text('Victor García'), findsOneWidget);
    expect(find.text('Desarrollador móvil'), findsOneWidget);
    expect(find.widgetWithText(UiChip, 'Admin'), findsOneWidget);
  });

  testWidgets('solo con título no reserva espacio de avatar ni etiqueta', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiListTile(title: 'Victor García'));

    expect(find.byType(UiAvatar), findsNothing);
    expect(find.byType(UiChip), findsNothing);

    final ListTile tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.leading, isNull);
    expect(tile.subtitle, isNull);
    expect(tile.trailing, isNull);
  });

  testWidgets('el avatar usa el nombre que le pasan, no el título', (
    WidgetTester tester,
  ) async {
    // Son campos distintos: el título puede ser un evento y el avatar su autor.
    await pumpKit(
      tester,
      const UiListTile(
        title: 'Fiesta de fin de año',
        avatarName: 'Laura Pérez',
      ),
    );

    expect(find.text('LP'), findsOneWidget);
  });

  testWidgets('sin onTap no es tocable', (WidgetTester tester) async {
    await pumpKit(tester, const UiListTile(title: 'Victor García'));

    expect(tester.widget<ListTile>(find.byType(ListTile)).onTap, isNull);
  });

  testWidgets('con onTap responde al toque en toda la fila', (
    WidgetTester tester,
  ) async {
    bool tapped = false;
    await pumpKit(
      tester,
      UiListTile(title: 'Victor García', onTap: () => tapped = true),
    );

    await tester.tap(find.byType(UiListTile));

    expect(tapped, isTrue);
  });
}

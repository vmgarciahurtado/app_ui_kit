import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('con todo puesto muestra avatar, textos, tags y acciones', (
    WidgetTester tester,
  ) async {
    bool followed = false;
    await pumpKit(
      tester,
      UiProfileHeader(
        name: 'Victor García',
        subtitle: 'Desarrollador móvil',
        tags: const <String>['Flutter', 'Dart'],
        actions: <Widget>[
          UiButton(label: 'Seguir', onPressed: () => followed = true),
        ],
      ),
    );

    expect(find.byType(UiAvatar), findsOneWidget);
    expect(find.text('Victor García'), findsOneWidget);
    expect(find.text('Desarrollador móvil'), findsOneWidget);
    expect(find.byType(UiChip), findsNWidgets(2));

    await tester.tap(find.widgetWithText(UiButton, 'Seguir'));
    expect(followed, isTrue);
  });

  testWidgets('solo con el nombre no deja huecos', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiProfileHeader(name: 'Victor García'));

    expect(find.text('Victor García'), findsOneWidget);
    expect(find.byType(UiChip), findsNothing);
    expect(find.byType(UiButton), findsNothing);
    // Sin subtítulo no se reserva la línea: el encabezado se encoge.
    expect(find.byType(UiAvatar), findsOneWidget);
  });

  testWidgets('el avatar es el grande del vocabulario', (
    WidgetTester tester,
  ) async {
    // Es la cara de la entidad y el elemento ancla del encabezado.
    await pumpKit(tester, const UiProfileHeader(name: 'Victor García'));

    expect(
      tester.widget<UiAvatar>(find.byType(UiAvatar)).size,
      UiSize.large,
    );
  });

  testWidgets('compone piezas del sistema en vez de dibujarlas', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiProfileHeader(name: 'Victor García', tags: <String>['Flutter']),
    );

    expect(find.byType(UiCard), findsOneWidget);
    expect(find.widgetWithText(UiChip, 'Flutter'), findsOneWidget);
  });
}

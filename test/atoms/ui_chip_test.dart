import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('sin onSelected es una etiqueta estática', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiChip(label: 'Admin'));

    expect(find.text('Admin'), findsOneWidget);
    expect(tester.widget<RawChip>(find.byType(RawChip)).onSelected, isNull);
  });

  testWidgets('con onSelected se comporta como filtro', (
    WidgetTester tester,
  ) async {
    final List<bool> changes = <bool>[];
    await pumpKit(
      tester,
      UiChip(label: 'Flutter', onSelected: changes.add),
    );

    await tester.tap(find.byType(UiChip));

    expect(changes, <bool>[true]);
  });

  testWidgets('seleccionado avisa que se quiere deseleccionar', (
    WidgetTester tester,
  ) async {
    final List<bool> changes = <bool>[];
    await pumpKit(
      tester,
      UiChip(label: 'Flutter', selected: true, onSelected: changes.add),
    );

    await tester.tap(find.byType(UiChip));

    expect(changes, <bool>[false]);
  });

  testWidgets('no dibuja palomita: el estado se ve por el color', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      UiChip(label: 'Flutter', selected: true, onSelected: (bool _) {}),
    );

    // Con palomita el chip cambia de ancho y la fila se reacomoda a cada toque.
    expect(tester.widget<RawChip>(find.byType(RawChip)).showCheckmark, isFalse);
  });

  testWidgets('con ícono lo pinta como avatar del chip', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiChip(label: 'Flutter', icon: Icons.flutter_dash),
    );

    expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
  });

  testWidgets('sin ícono no reserva espacio de avatar', (
    WidgetTester tester,
  ) async {
    await pumpKit(tester, const UiChip(label: 'Flutter'));

    expect(tester.widget<RawChip>(find.byType(RawChip)).avatar, isNull);
  });

  testWidgets('con onDeleted ofrece borrarlo', (WidgetTester tester) async {
    bool deleted = false;
    await pumpKit(
      tester,
      UiChip(label: 'Flutter', onDeleted: () => deleted = true),
    );

    await tester.tap(find.byIcon(Icons.cancel));

    expect(deleted, isTrue);
  });
}

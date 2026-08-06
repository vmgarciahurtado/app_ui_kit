import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  /// El color del ícono es la señal visual que distingue un estado de otro.
  Color iconColor(WidgetTester tester) =>
      tester.widget<Icon>(find.byType(Icon).first).color!;

  IconData iconData(WidgetTester tester) =>
      tester.widget<Icon>(find.byType(Icon).first).icon!;

  group('contenido', () {
    testWidgets('el mensaje es lo único obligatorio', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiBanner(message: 'Revisa tus datos.'));

      expect(find.text('Revisa tus datos.'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('con título lo muestra sobre el mensaje', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiBanner(title: 'Listo', message: 'Cambios guardados.'),
      );

      expect(find.text('Listo'), findsOneWidget);
      expect(
        tester.getCenter(find.text('Listo')).dy,
        lessThan(tester.getCenter(find.text('Cambios guardados.')).dy),
      );
    });

    testWidgets('con onClose ofrece cerrarlo', (WidgetTester tester) async {
      bool closed = false;
      await pumpKit(
        tester,
        UiBanner(message: 'Cambios guardados.', onClose: () => closed = true),
      );

      await tester.tap(find.byIcon(Icons.close));

      expect(closed, isTrue);
    });
  });

  group('estados', () {
    testWidgets('info es el estado por defecto', (WidgetTester tester) async {
      await pumpKit(tester, const UiBanner(message: 'Aviso'));

      final BuildContext context = tester.element(find.byType(UiBanner));
      expect(iconColor(tester), context.statusColors.info);
      expect(iconData(tester), Icons.info_outline);
    });

    testWidgets('éxito usa el verde del sistema', (WidgetTester tester) async {
      await pumpKit(
        tester,
        const UiBanner(status: UiStatus.success, message: 'Listo'),
      );

      final BuildContext context = tester.element(find.byType(UiBanner));
      expect(iconColor(tester), context.statusColors.success);
      expect(iconData(tester), Icons.check_circle_outline);
    });

    testWidgets('advertencia usa el ámbar del sistema', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiBanner(status: UiStatus.warning, message: 'Ojo con esto'),
      );

      final BuildContext context = tester.element(find.byType(UiBanner));
      expect(iconColor(tester), context.statusColors.warning);
      expect(iconData(tester), Icons.warning_amber_outlined);
    });

    testWidgets('error usa el color de error del ColorScheme, no el propio', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiBanner(status: UiStatus.error, message: 'Algo falló'),
      );

      // El error ya existe en Material: duplicarlo daría dos rojos distintos.
      final BuildContext context = tester.element(find.byType(UiBanner));
      expect(iconColor(tester), context.colorScheme.error);
      expect(iconData(tester), Icons.error_outline);
    });

    testWidgets('cada estado se distingue por color e ícono', (
      WidgetTester tester,
    ) async {
      final Set<Color> colors = <Color>{};
      final Set<IconData> icons = <IconData>{};
      for (final UiStatus status in UiStatus.values) {
        await pumpKit(
          tester,
          UiBanner(
            key: ValueKey<UiStatus>(status),
            status: status,
            message: 'x',
          ),
        );
        colors.add(iconColor(tester));
        icons.add(iconData(tester));
      }

      expect(colors, hasLength(UiStatus.values.length));
      expect(icons, hasLength(UiStatus.values.length));
    });
  });

  testWidgets('el fondo es el color de estado atenuado, no opaco', (
    WidgetTester tester,
  ) async {
    await pumpKit(
      tester,
      const UiBanner(status: UiStatus.success, message: 'Listo'),
    );

    // Con el color a plena opacidad el texto encima sería ilegible.
    final BuildContext context = tester.element(find.byType(UiBanner));
    final BoxDecoration decoration =
        tester
                .widget<Container>(
                  find.descendant(
                    of: find.byType(UiBanner),
                    matching: find.byType(Container),
                  ),
                )
                .decoration!
            as BoxDecoration;
    expect(decoration.color!.a, lessThan(1));
    expect(decoration.color!.r, context.statusColors.success.r);
  });
}

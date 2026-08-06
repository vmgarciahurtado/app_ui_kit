import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

import '../helpers/pump_kit.dart';

void main() {
  group('tamaño', () {
    testWidgets('cada escalón del vocabulario da un ancho distinto', (
      WidgetTester tester,
    ) async {
      final List<double> widths = <double>[];
      for (final UiSize size in UiSize.values) {
        await pumpKit(tester, UiLoader(size: size));
        widths.add(tester.getSize(find.byType(UiLoader)).width);
      }

      expect(widths.toSet(), hasLength(UiSize.values.length));
      expect(widths, orderedEquals(<double>[...widths]..sort()));
    });

    testWidgets('el alto lo decide la animación, no una caja cuadrada', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiLoader());

      // Los puntos van en fila: un cuadrado los dejaría diminutos.
      final Size size = tester.getSize(find.byType(UiLoader));
      expect(size.height, lessThan(size.width));
    });
  });

  group('etiqueta', () {
    testWidgets('sin etiqueta solo pinta la animación', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiLoader());

      expect(find.byType(Text), findsNothing);
      expect(find.byType(LottieBuilder), findsOneWidget);
    });

    testWidgets('con etiqueta la pone debajo', (WidgetTester tester) async {
      await pumpKit(tester, const UiLoader(label: 'Cargando…'));

      expect(find.text('Cargando…'), findsOneWidget);
      expect(
        tester.getCenter(find.text('Cargando…')).dy,
        greaterThan(tester.getCenter(find.byType(LottieBuilder)).dy),
      );
    });
  });

  group('color', () {
    /// El color viaja dentro de los `LottieDelegates`.
    Color deltaColor(WidgetTester tester) {
      final LottieBuilder lottie = tester.widget<LottieBuilder>(
        find.byType(LottieBuilder),
      );
      final ValueDelegate<dynamic> delegate =
          lottie.delegates!.values!.single;
      return delegate.value as Color;
    }

    testWidgets('un color explícito manda sobre todo lo demás', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiLoader(color: Color(0xFFFF00FF)));

      expect(deltaColor(tester), const Color(0xFFFF00FF));
    });

    testWidgets('sin color hereda el del IconTheme que lo rodea', (
      WidgetTester tester,
    ) async {
      // Es lo que hace que el loader de un botón tome el color de su texto.
      await pumpKit(
        tester,
        const IconTheme(
          data: IconThemeData(color: Color(0xFF00FF00)),
          child: UiLoader(),
        ),
      );

      expect(deltaColor(tester), const Color(0xFF00FF00));
    });

    testWidgets('dentro de un botón el kit no le fija color propio', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        const UiButton(label: 'Guardar', loading: true),
      );

      expect(
        tester.widget<UiLoader>(find.byType(UiLoader)).color,
        isNull,
        reason: 'con color nulo toma el del IconTheme del botón',
      );
    });
  });
}

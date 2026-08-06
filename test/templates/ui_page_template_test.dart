import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('renderiza título, secciones y footer', (
    WidgetTester tester,
  ) async {
    bool invited = false;
    await pumpKitHome(
      tester,
      UiPageTemplate(
        title: 'Mi equipo',
        sections: const <Widget>[Text('Sección A'), Text('Sección B')],
        footer: UiButton(
          label: 'Invitar',
          expanded: true,
          onPressed: () => invited = true,
        ),
      ),
    );

    expect(find.text('Mi equipo'), findsOneWidget);
    expect(find.text('Sección A'), findsOneWidget);
    expect(find.text('Sección B'), findsOneWidget);

    await tester.tap(find.widgetWithText(UiButton, 'Invitar'));
    expect(invited, isTrue);
  });

  testWidgets('sin footer no reserva barra inferior', (
    WidgetTester tester,
  ) async {
    await pumpKitHome(
      tester,
      const UiPageTemplate(
        title: 'Mi equipo',
        sections: <Widget>[Text('Sección A')],
      ),
    );

    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).bottomNavigationBar,
      isNull,
    );
  });

  testWidgets('las acciones del AppBar llegan a la barra', (
    WidgetTester tester,
  ) async {
    bool refreshed = false;
    await pumpKitHome(
      tester,
      UiPageTemplate(
        title: 'Mi equipo',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => refreshed = true,
          ),
        ],
        sections: const <Widget>[Text('Sección A')],
      ),
    );

    await tester.tap(find.byIcon(Icons.refresh));

    expect(refreshed, isTrue);
  });

  testWidgets('las secciones se desplazan', (WidgetTester tester) async {
    // El contenido no cabe siempre y no puede desbordarse.
    await pumpKitHome(
      tester,
      UiPageTemplate(
        title: 'Mi equipo',
        sections: <Widget>[
          for (int i = 0; i < 30; i++) Text('Sección $i'),
        ],
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Sección 0'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Sección 0'), findsNothing);
  });

  testWidgets('en pantalla ancha el contenido no se estira sin límite', (
    WidgetTester tester,
  ) async {
    // En tablet o escritorio, líneas de 1200 px son ilegibles.
    tester.view.physicalSize = const Size(2000, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await pumpKitHome(
      tester,
      const UiPageTemplate(
        title: 'Mi equipo',
        sections: <Widget>[Text('Sección A')],
      ),
    );

    expect(
      tester.getSize(find.byType(ListView)).width,
      lessThanOrEqualTo(UiBreakpoints.tablet),
    );
  });
}

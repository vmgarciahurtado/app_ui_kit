import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

void main() {
  testWidgets('renderiza título, encabezado fijo y secciones', (
    WidgetTester tester,
  ) async {
    bool contacted = false;
    await pumpKitHome(
      tester,
      UiDetailPageTemplate(
        title: 'Perfil',
        header: const Text('Encabezado'),
        sections: const <Widget>[Text('Sección A'), Text('Sección B')],
        footer: UiButton(
          label: 'Contactar',
          expanded: true,
          onPressed: () => contacted = true,
        ),
      ),
    );

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Encabezado'), findsOneWidget);
    expect(find.text('Sección A'), findsOneWidget);

    await tester.tap(find.widgetWithText(UiButton, 'Contactar'));
    expect(contacted, isTrue);
  });

  testWidgets('el encabezado se queda quieto mientras el resto se desplaza', (
    WidgetTester tester,
  ) async {
    // Es la diferencia con `UiPageTemplate`: el encabezado no se va al bajar.
    await pumpKitHome(
      tester,
      UiDetailPageTemplate(
        title: 'Perfil',
        header: const UiProfileHeader(name: 'Victor García'),
        sections: <Widget>[
          for (int i = 0; i < 30; i++) Text('Sección $i'),
        ],
      ),
    );

    final double before = tester.getTopLeft(find.byType(UiProfileHeader)).dy;
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    expect(find.byType(UiProfileHeader), findsOneWidget);
    expect(tester.getTopLeft(find.byType(UiProfileHeader)).dy, before);
    expect(find.text('Sección 0'), findsNothing);
  });

  testWidgets('sin footer no reserva barra inferior', (
    WidgetTester tester,
  ) async {
    await pumpKitHome(
      tester,
      const UiDetailPageTemplate(
        title: 'Perfil',
        header: Text('Encabezado'),
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
    bool shared = false;
    await pumpKitHome(
      tester,
      UiDetailPageTemplate(
        title: 'Perfil',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => shared = true,
          ),
        ],
        header: const Text('Encabezado'),
        sections: const <Widget>[Text('Sección A')],
      ),
    );

    await tester.tap(find.byIcon(Icons.share));

    expect(shared, isTrue);
  });

  testWidgets('en pantalla ancha el contenido no se estira sin límite', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(2000, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await pumpKitHome(
      tester,
      const UiDetailPageTemplate(
        title: 'Perfil',
        header: Text('Encabezado'),
        sections: <Widget>[Text('Sección A')],
      ),
    );

    expect(
      tester.getSize(find.byType(ListView)).width,
      lessThanOrEqualTo(UiBreakpoints.tablet),
    );
  });
}

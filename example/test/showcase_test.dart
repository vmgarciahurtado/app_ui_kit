import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('navega a una página de componentes desde el menú', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShowcaseApp());

    expect(find.text('Explorar componentes'), findsOneWidget);

    await tester.tap(find.text('Componentes'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Átomos'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Botones'));
    await tester.pumpAndSettle();

    expect(find.text('Átomos · Botones'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Danger'), findsOneWidget);
  });

  testWidgets('abre la página de equipo a pantalla completa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ShowcaseApp());

    await tester.tap(find.text('Componentes'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Páginas'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Página de equipo'));
    await tester.pumpAndSettle();

    expect(find.text('Páginas · Página de equipo'), findsOneWidget);

    await tester.tap(find.text('Ver página a pantalla completa'));
    await tester.pumpAndSettle();

    expect(find.text('Mi equipo'), findsOneWidget);
    expect(find.text('Victor García'), findsOneWidget);
    expect(find.text('Invitar integrante'), findsOneWidget);
  });
}

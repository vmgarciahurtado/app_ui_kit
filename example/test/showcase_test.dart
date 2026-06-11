import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('navega a una página de componentes desde el menú',
      (tester) async {
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
}

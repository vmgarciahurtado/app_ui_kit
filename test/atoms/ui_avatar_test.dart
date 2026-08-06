import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_kit.dart';

/// PNG de 1×1 transparente: una imagen local, para no depender de la red.
final Uint8List _transparentPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8'
  'z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

void main() {
  group('iniciales', () {
    testWidgets('toma la primera letra de las dos primeras palabras', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiAvatar(name: 'Victor García Hurtado'));

      expect(find.text('VG'), findsOneWidget);
    });

    testWidgets('un solo nombre da una sola inicial', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiAvatar(name: 'Victor'));

      expect(find.text('V'), findsOneWidget);
    });

    testWidgets('siempre en mayúscula, venga como venga el nombre', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiAvatar(name: 'victor garcía'));

      expect(find.text('VG'), findsOneWidget);
    });

    testWidgets('los espacios de sobra no producen iniciales vacías', (
      WidgetTester tester,
    ) async {
      // Un nombre con espacios de sobra no debe pintar un avatar en blanco.
      await pumpKit(tester, const UiAvatar(name: '  Victor   García  '));

      expect(find.text('VG'), findsOneWidget);
    });

    testWidgets('un nombre vacío no revienta, solo no muestra iniciales', (
      WidgetTester tester,
    ) async {
      await pumpKit(tester, const UiAvatar(name: ''));

      expect(tester.takeException(), isNull);
      expect(find.byType(UiAvatar), findsOneWidget);
    });
  });

  group('tamaño', () {
    testWidgets('cada escalón del vocabulario da un diámetro distinto', (
      WidgetTester tester,
    ) async {
      final List<double> diameters = <double>[];
      for (final UiSize size in UiSize.values) {
        // La clave fuerza un elemento nuevo: el diámetro del `CircleAvatar` es
        // animado y al reutilizarlo las tres medidas saldrían iguales.
        await pumpKit(
          tester,
          UiAvatar(key: ValueKey<UiSize>(size), name: 'Victor', size: size),
        );
        diameters.add(tester.getSize(find.byType(UiAvatar)).width);
      }

      expect(diameters.toSet(), hasLength(UiSize.values.length));
      expect(diameters, orderedEquals(<double>[...diameters]..sort()));
    });

    testWidgets('las iniciales escalan con el avatar', (
      WidgetTester tester,
    ) async {
      // Un tamaño fijo se saldría del círculo en small y se perdería en large.
      await pumpKit(
        tester,
        const UiAvatar(name: 'Victor', size: UiSize.small),
      );
      final double small = tester
          .widget<Text>(find.text('V'))
          .style!
          .fontSize!;

      await pumpKit(
        tester,
        const UiAvatar(name: 'Victor', size: UiSize.large),
      );
      final double large = tester
          .widget<Text>(find.text('V'))
          .style!
          .fontSize!;

      expect(small, lessThan(large));
    });
  });

  group('imagen', () {
    testWidgets('con imagen la usa como primer plano sobre las iniciales', (
      WidgetTester tester,
    ) async {
      await pumpKit(
        tester,
        UiAvatar(name: 'Victor García', image: MemoryImage(_transparentPng)),
      );

      final CircleAvatar avatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      // Quedan debajo a propósito: si la descarga falla, el avatar no se vacía.
      expect(avatar.foregroundImage, isNotNull);
      expect(find.text('VG'), findsOneWidget);
    });
  });
}

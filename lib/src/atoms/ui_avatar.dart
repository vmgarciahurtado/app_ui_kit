import 'package:flutter/material.dart';

import '../foundations/ui_size.dart';
import '../foundations/ui_sizes.dart';
import '../theme/build_context_theme.dart';

/// Avatar del sistema de diseño.
///
/// Muestra la imagen si está disponible; si no, las iniciales derivadas
/// de [name] sobre el color primario del tema.
///
/// ```dart
/// UiAvatar(name: 'Victor García', size: UiSize.large);
/// UiAvatar(name: 'Victor', image: NetworkImage(photoUrl));
/// ```
class UiAvatar extends StatelessWidget {
  const UiAvatar({
    required this.name,
    super.key,
    this.image,
    this.size = UiSize.medium,
  });

  /// Nombre usado para las iniciales (y como semántica del avatar).
  final String name;
  final ImageProvider? image;
  final UiSize size;

  /// Proporción de las iniciales respecto al diámetro del avatar.
  static const double _initialsFontScale = 0.36;

  /// Traduce el vocabulario [UiSize] a la dimensión del avatar,
  /// tomando los valores de la escala cruda [UiSizes].
  double get _dimension => switch (size) {
    UiSize.small => UiSizes.size32,
    UiSize.medium => UiSizes.size44,
    UiSize.large => UiSizes.size64,
  };

  /// Iniciales de las dos primeras palabras del nombre.
  String get _initials {
    final List<String> words = name.trim().split(RegExp(r'\s+'));
    return words
        .where((String word) => word.isNotEmpty)
        .take(2)
        .map((String word) => word[0].toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _dimension / 2,
      foregroundImage: image,
      backgroundColor: context.colorScheme.primaryContainer,
      child: Text(
        _initials,
        style: context.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: _dimension * _initialsFontScale,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/build_context_theme.dart';

/// Tamaños disponibles para [UiAvatar].
enum UiAvatarSize {
  sm(32),
  md(44),
  lg(64);

  const UiAvatarSize(this.dimension);

  final double dimension;
}

/// Avatar del sistema de diseño.
///
/// Muestra la imagen si está disponible; si no, las iniciales derivadas
/// de [name] sobre el color primario del tema.
///
/// ```dart
/// UiAvatar(name: 'Victor García', size: .lg);
/// UiAvatar(name: 'Victor', image: NetworkImage(photoUrl));
/// ```
class UiAvatar extends StatelessWidget {
  const UiAvatar({
    required this.name,
    super.key,
    this.image,
    this.size = .md,
  });

  /// Nombre usado para las iniciales (y como semántica del avatar).
  final String name;
  final ImageProvider? image;
  final UiAvatarSize size;

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
      radius: size.dimension / 2,
      foregroundImage: image,
      backgroundColor: context.colorScheme.primaryContainer,
      child: Text(
        _initials,
        style: context.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: size.dimension * 0.36,
        ),
      ),
    );
  }
}

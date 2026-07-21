import 'package:flutter/material.dart';

import '../atoms/ui_avatar.dart';
import '../atoms/ui_chip.dart';

/// Fila de lista del sistema de diseño.
///
/// Molécula que une átomos ([UiAvatar], [UiChip]) y texto en una fila
/// consistente: avatar opcional a la izquierda, título con subtítulo y
/// etiqueta opcional a la derecha. Es la pieza que consumen organismos
/// como `UiListSection`, pero puede usarse suelta.
///
/// ```dart
/// UiListTile(
///   title: 'Victor García',
///   subtitle: 'Desarrollador móvil',
///   avatarName: 'Victor García',
///   tag: 'Admin',
///   onTap: _openProfile,
/// );
/// ```
class UiListTile extends StatelessWidget {
  const UiListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.avatarName,
    this.avatarImage,
    this.tag,
    this.onTap,
  });

  final String title;
  final String? subtitle;

  /// Si no es null, la fila muestra un [UiAvatar] a la izquierda.
  final String? avatarName;
  final ImageProvider? avatarImage;

  /// Etiqueta opcional a la derecha, renderizada como [UiChip].
  final String? tag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String? avatarName = this.avatarName;
    final String? subtitle = this.subtitle;
    final String? tag = this.tag;
    return ListTile(
      onTap: onTap,
      leading: avatarName != null
          ? UiAvatar(name: avatarName, image: avatarImage)
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: tag != null ? UiChip(label: tag) : null,
    );
  }
}

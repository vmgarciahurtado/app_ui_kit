import 'package:flutter/material.dart';

import '../atoms/ui_avatar.dart';
import '../atoms/ui_chip.dart';
import '../molecules/ui_card.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Encabezado de perfil del sistema de diseño.
///
/// Organismo que une átomos ([UiAvatar], [UiChip]) y moléculas ([UiCard])
/// en la cabecera de una entidad: avatar, nombre, subtítulo, etiquetas y
/// acciones opcionales.
///
/// ```dart
/// UiProfileHeader(
///   name: 'Victor García',
///   subtitle: 'Desarrollador móvil',
///   tags: ['Flutter', 'Dart'],
///   actions: [UiButton(label: 'Seguir', onPressed: _follow)],
/// );
/// ```
class UiProfileHeader extends StatelessWidget {
  const UiProfileHeader({
    required this.name,
    super.key,
    this.subtitle,
    this.image,
    this.tags = const <String>[],
    this.actions = const <Widget>[],
  });

  final String name;
  final String? subtitle;

  /// Imagen del avatar; si es null se usan las iniciales de [name].
  final ImageProvider? image;

  /// Etiquetas renderizadas como [UiChip].
  final List<String> tags;

  /// Acciones bajo el encabezado, típicamente `UiButton`.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return UiCard(
      child: Column(
        crossAxisAlignment: .start,
        children: <Widget>[
          Row(
            children: <Widget>[
              UiAvatar(name: name, image: image, size: .lg),
              const SizedBox(width: UiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: <Widget>[
                    Text(name, style: context.textTheme.titleLarge),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: UiSpacing.xs),
                      Text(
                        subtitle!,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (tags.isNotEmpty) ...<Widget>[
            const SizedBox(height: UiSpacing.md),
            Wrap(
              spacing: UiSpacing.sm,
              runSpacing: UiSpacing.sm,
              children: <Widget>[
                for (final String tag in tags) UiChip(label: tag),
              ],
            ),
          ],
          if (actions.isNotEmpty) ...<Widget>[
            const SizedBox(height: UiSpacing.md),
            Wrap(
              spacing: UiSpacing.sm,
              runSpacing: UiSpacing.sm,
              children: actions,
            ),
          ],
        ],
      ),
    );
  }
}

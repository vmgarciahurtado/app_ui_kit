import 'package:flutter/material.dart';

import '../molecules/ui_card.dart';
import '../molecules/ui_empty_state.dart';
import '../molecules/ui_list_tile.dart';
import '../theme/build_context_theme.dart';
import '../tokens/ui_spacing.dart';

/// Datos de un elemento de [UiListSection], renderizado como [UiListTile].
class UiListItem {
  const UiListItem({
    required this.title,
    this.subtitle,
    this.avatarName,
    this.avatarImage,
    this.tag,
    this.onTap,
  });

  final String title;
  final String? subtitle;

  /// Si no es null, el elemento muestra su avatar a la izquierda.
  final String? avatarName;
  final ImageProvider? avatarImage;

  /// Etiqueta opcional a la derecha.
  final String? tag;
  final VoidCallback? onTap;
}

/// Sección de lista del sistema de diseño.
///
/// Organismo que une moléculas del sistema ([UiCard], [UiListTile],
/// [UiEmptyState]) en una sección completa de interfaz: encabezado con
/// título y acción opcional, más el listado de elementos. Cuando [items]
/// está vacío muestra [emptyState].
///
/// ```dart
/// UiListSection(
///   title: 'Integrantes',
///   action: UiButton(label: 'Agregar', variant: .ghost, onPressed: _add),
///   items: [
///     UiListItem(
///       title: 'Victor García',
///       subtitle: 'victor@correo.com',
///       avatarName: 'Victor García',
///       tag: 'Admin',
///     ),
///   ],
/// );
/// ```
class UiListSection extends StatelessWidget {
  const UiListSection({
    required this.title,
    required this.items,
    super.key,
    this.action,
    this.emptyState = const UiEmptyState(title: 'Sin elementos'),
  });

  final String title;
  final List<UiListItem> items;

  /// Acción opcional del encabezado, típicamente un `UiButton` ghost.
  final Widget? action;

  /// Contenido mostrado cuando [items] está vacío.
  final Widget emptyState;

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.symmetric(vertical: UiSpacing.sm),
      child: Column(
        crossAxisAlignment: .start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              UiSpacing.md,
              UiSpacing.xs,
              UiSpacing.md,
              UiSpacing.xs,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(title, style: context.textTheme.titleMedium),
                ),
                if (action != null) action!,
              ],
            ),
          ),
          if (items.isEmpty)
            emptyState
          else
            for (final UiListItem item in items)
              UiListTile(
                title: item.title,
                subtitle: item.subtitle,
                avatarName: item.avatarName,
                avatarImage: item.avatarImage,
                tag: item.tag,
                onTap: item.onTap,
              ),
        ],
      ),
    );
  }
}

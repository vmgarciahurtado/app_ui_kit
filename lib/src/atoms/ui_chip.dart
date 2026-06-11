import 'package:flutter/material.dart';

/// Chip del sistema de diseño.
///
/// Sirve tanto para etiquetas estáticas como para filtros seleccionables:
/// si recibe [onSelected] se comporta como un filtro con estado.
///
/// ```dart
/// UiChip(
///   label: 'Flutter',
///   icon: Icons.flutter_dash,
///   selected: isSelected,
///   onSelected: (value) => setState(() => isSelected = value),
/// );
/// ```
class UiChip extends StatelessWidget {
  const UiChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
  });

  final String label;
  final IconData? icon;
  final bool selected;

  /// Callback al tocar el chip. Si es null, el chip es estático.
  final ValueChanged<bool>? onSelected;

  /// Muestra el ícono de borrar y lo invoca al tocarlo.
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 18) : null,
      selected: selected,
      onSelected: onSelected,
      onDeleted: onDeleted,
      showCheckmark: false,
    );
  }
}

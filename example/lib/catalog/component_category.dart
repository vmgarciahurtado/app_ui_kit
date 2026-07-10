import 'package:flutter/widgets.dart';

import 'component_entry.dart';

/// Una categoría del sistema (tokens, átomos, moléculas, organismos,
/// plantillas y páginas).
class ComponentCategory {
  const ComponentCategory({
    required this.title,
    required this.icon,
    required this.entries,
  });

  final String title;
  final IconData icon;
  final List<ComponentEntry> entries;
}

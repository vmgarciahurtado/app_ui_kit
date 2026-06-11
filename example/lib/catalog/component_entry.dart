import 'package:flutter/widgets.dart';

/// Un componente navegable del showcase.
class ComponentEntry {
  const ComponentEntry({required this.title, required this.builder});

  final String title;
  final WidgetBuilder builder;
}

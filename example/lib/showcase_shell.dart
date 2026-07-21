import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:example/catalog/component_category.dart';
import 'package:flutter/material.dart';

import 'catalog/catalog.dart';
import 'catalog/component_entry.dart';
import 'pages/welcome_page.dart';

/// Estructura principal del showcase: AppBar con menú en cascada
/// ([MenuAnchor] → [SubmenuButton] por categoría → componente) y el
/// componente seleccionado como cuerpo.
class ShowcaseShell extends StatefulWidget {
  const ShowcaseShell({
    required this.isDark,
    required this.onToggleTheme,
    super.key,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<ShowcaseShell> {
  final MenuController _menuController = MenuController();
  final FocusNode _menuButtonFocusNode = FocusNode(debugLabel: 'Menú');

  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  String? _categoryTitle;
  ComponentEntry? _selected;

  @override
  void dispose() {
    _menuButtonFocusNode.dispose();
    super.dispose();
  }

  void _select({
    required String categoryTitle,
    required ComponentEntry entry,
  }) {
    setState(() {
      _categoryTitle = categoryTitle;
      _selected = entry;
    });
  }

  String get _title {
    final ComponentEntry? selected = _selected;
    return selected == null
        ? 'app_ui_kit'
        : '$_categoryTitle · ${selected.title}';
  }

  @override
  Widget build(BuildContext context) {
    final ComponentEntry? selected = _selected;
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          MenuAnchor(
            animated: true,
            onAnimationStatusChanged: (AnimationStatus status) =>
                _animationStatus = status,
            controller: _menuController,
            childFocusNode: _menuButtonFocusNode,
            menuChildren: <Widget>[
              for (final ComponentCategory category in catalog)
                SubmenuButton(
                  animated: true,
                  leadingIcon: Icon(category.icon),
                  menuChildren: <Widget>[
                    for (final ComponentEntry entry in category.entries)
                      MenuItemButton(
                        onPressed: () => _select(
                          categoryTitle: category.title,
                          entry: entry,
                        ),
                        child: Text(entry.title),
                      ),
                  ],
                  child: Text(category.title),
                ),
            ],
            builder:
                (
                  BuildContext context,
                  MenuController controller,
                  Widget? child,
                ) {
                  return TextButton.icon(
                    focusNode: _menuButtonFocusNode,
                    onPressed: () => _animationStatus.isForwardOrCompleted
                        ? controller.close()
                        : controller.open(),
                    icon: const Icon(Icons.category_outlined),
                    label: const Text('Componentes'),
                  );
                },
          ),
          IconButton(
            tooltip: widget.isDark ? 'Tema claro' : 'Tema oscuro',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          const SizedBox(width: UiSpacing.small),
        ],
      ),
      body: selected == null
          ? WelcomePage(onExplore: _menuController.open)
          : Builder(builder: selected.builder),
    );
  }
}

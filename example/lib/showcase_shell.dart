import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import 'catalog/catalog.dart';
import 'catalog/component_entry.dart';
import 'pages/welcome_page.dart';

/// Estructura principal del showcase: AppBar con menú en cascada
/// ([MenuAnchor] → [SubmenuButton] por categoría → componente) y el
/// componente seleccionado como cuerpo.
class ShowcaseShell extends StatefulWidget {
  const ShowcaseShell({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<ShowcaseShell> {
  final MenuController _menuController = MenuController();
  final FocusNode _menuButtonFocusNode = FocusNode(debugLabel: 'Menú');

  AnimationStatus _animationStatus = .dismissed;
  String? _categoryTitle;
  ComponentEntry? _selected;

  @override
  void dispose() {
    _menuButtonFocusNode.dispose();
    super.dispose();
  }

  void _select(String categoryTitle, ComponentEntry entry) {
    setState(() {
      _categoryTitle = categoryTitle;
      _selected = entry;
    });
  }

  String get _title => _selected == null
      ? 'app_ui_kit'
      : '$_categoryTitle · ${_selected!.title}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          MenuAnchor(
            animated: true,
            onAnimationStatusChanged: (status) => _animationStatus = status,
            controller: _menuController,
            childFocusNode: _menuButtonFocusNode,
            menuChildren: [
              for (final category in catalog)
                SubmenuButton(
                  animated: true,
                  leadingIcon: Icon(category.icon),
                  menuChildren: [
                    for (final entry in category.entries)
                      MenuItemButton(
                        onPressed: () => _select(category.title, entry),
                        child: Text(entry.title),
                      ),
                  ],
                  child: Text(category.title),
                ),
            ],
            builder: (context, controller, child) {
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
          const SizedBox(width: UiSpacing.sm),
        ],
      ),
      body: _selected == null
          ? WelcomePage(onExplore: _menuController.open)
          : Builder(builder: _selected!.builder),
    );
  }
}

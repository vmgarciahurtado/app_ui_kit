import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Lista scrolleable con el ancho máximo y padding estándar del showcase.
class ShowcaseList extends StatelessWidget {
  const ShowcaseList({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: UiBreakpoints.tablet),
        child: ListView.separated(
          padding: const EdgeInsets.all(UiSpacing.large),
          itemCount: children.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: UiSpacing.extraLarge),
          itemBuilder: (_, int index) => children[index],
        ),
      ),
    );
  }
}

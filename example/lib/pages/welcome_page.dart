import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Página de bienvenida del showcase.
class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.onExplore, super.key});

  /// Abre el menú de componentes.
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: UiBreakpoints.mobile),
        child: Padding(
          padding: const EdgeInsets.all(UiSpacing.lg),
          child: Column(
            mainAxisAlignment: .center,
            children: <Widget>[
              Icon(
                Icons.auto_awesome_mosaic_outlined,
                size: 64,
                color: context.colorScheme.primary,
              ),
              const SizedBox(height: UiSpacing.lg),
              Text(
                'app_ui_kit',
                style: context.textTheme.headlineLarge,
                textAlign: .center,
              ),
              const SizedBox(height: UiSpacing.sm),
              Text(
                'Sistema de diseño reutilizable para Flutter, organizado con '
                'Atomic Design: tokens, átomos, moléculas y organismos.',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: .center,
              ),
              const SizedBox(height: UiSpacing.xl),
              UiButton(
                label: 'Explorar componentes',
                icon: Icons.menu_open,
                onPressed: onExplore,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

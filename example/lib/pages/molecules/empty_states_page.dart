import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../widgets/showcase_list.dart';
import '../../widgets/showcase_section.dart';

/// Variantes de [UiEmptyState].
class EmptyStatesPage extends StatelessWidget {
  const EmptyStatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: [
        const ShowcaseSection(
          title: 'Básico',
          children: [
            UiEmptyState(
              title: 'Sin mensajes',
              message: 'Cuando recibas mensajes aparecerán aquí.',
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con acción',
          children: [
            UiEmptyState(
              icon: Icons.search_off_outlined,
              title: 'Sin resultados',
              message: 'No encontramos nada con ese criterio. '
                  'Intenta con otra búsqueda.',
              action: UiButton(
                label: 'Limpiar filtros',
                variant: .outline,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Ícono personalizado',
          children: [
            UiEmptyState(
              icon: Icons.wifi_off_outlined,
              title: 'Sin conexión',
              message: 'Revisa tu conexión a internet e intenta de nuevo.',
            ),
          ],
        ),
      ],
    );
  }
}

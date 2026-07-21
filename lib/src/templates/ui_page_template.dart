import 'package:flutter/material.dart';

import '../tokens/ui_breakpoints.dart';
import '../tokens/ui_spacing.dart';

/// Plantilla de página del sistema de diseño.
///
/// Define la estructura de una pantalla sin conocer su contenido real:
/// AppBar con título y acciones, secciones apiladas con ancho máximo
/// responsive ([UiBreakpoints.tablet]) y una barra de acción inferior
/// opcional. Las páginas se construyen instanciando esta plantilla con
/// organismos y datos concretos.
///
/// ```dart
/// UiPageTemplate(
///   title: 'Mi equipo',
///   sections: [banner, listadoDeIntegrantes],
///   footer: UiButton(label: 'Agregar', expanded: true, onPressed: _add),
/// );
/// ```
class UiPageTemplate extends StatelessWidget {
  const UiPageTemplate({
    required this.title,
    required this.sections,
    super.key,
    this.actions,
    this.footer,
  });

  final String title;

  /// Acciones del AppBar.
  final List<Widget>? actions;

  /// Secciones del cuerpo, típicamente organismos, apiladas verticalmente.
  final List<Widget> sections;

  /// Barra inferior fija, típicamente con el `UiButton` de acción principal.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiBreakpoints.tablet),
          child: ListView.separated(
            padding: const EdgeInsets.all(UiSpacing.large),
            itemCount: sections.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: UiSpacing.extraLarge),
            itemBuilder: (_, int index) => sections[index],
          ),
        ),
      ),
      bottomNavigationBar: footer == null
          ? null
          : SafeArea(
              // heightFactor: 1 evita que el Center se expanda verticalmente
              // y le quite espacio al body.
              child: Center(
                heightFactor: 1,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: UiBreakpoints.tablet,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      UiSpacing.large,
                      UiSpacing.small,
                      UiSpacing.large,
                      UiSpacing.large,
                    ),
                    child: footer,
                  ),
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';

import '../tokens/ui_breakpoints.dart';
import '../tokens/ui_spacing.dart';

/// Plantilla de página de detalle del sistema de diseño.
///
/// A diferencia de `UiPageTemplate`, reserva un lugar para un encabezado
/// fijo (típicamente un organismo como `UiProfileHeader`) que permanece
/// visible mientras las secciones se desplazan debajo. Igual que el resto
/// de plantillas, no conoce el contenido real: define solo la estructura.
///
/// ```dart
/// UiDetailPageTemplate(
///   title: 'Perfil',
///   header: UiProfileHeader(name: 'Victor García'),
///   sections: [actividadReciente, proyectos],
/// );
/// ```
class UiDetailPageTemplate extends StatelessWidget {
  const UiDetailPageTemplate({
    required this.title,
    required this.header,
    required this.sections,
    super.key,
    this.actions,
    this.footer,
  });

  final String title;

  /// Acciones del AppBar.
  final List<Widget>? actions;

  /// Encabezado fijo bajo el AppBar, típicamente un organismo.
  final Widget header;

  /// Secciones desplazables bajo el encabezado.
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  UiSpacing.lg,
                  UiSpacing.lg,
                  UiSpacing.lg,
                  0,
                ),
                child: header,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(UiSpacing.lg),
                  itemCount: sections.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: UiSpacing.xl),
                  itemBuilder: (_, int index) => sections[index],
                ),
              ),
            ],
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
                      UiSpacing.lg,
                      UiSpacing.sm,
                      UiSpacing.lg,
                      UiSpacing.lg,
                    ),
                    child: footer,
                  ),
                ),
              ),
            ),
    );
  }
}

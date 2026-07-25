/// Sistema de diseño reutilizable para Flutter, organizado con Atomic Design.
///

library;

// Átomos
export 'src/atoms/ui_avatar.dart';
export 'src/atoms/ui_button.dart';
export 'src/atoms/ui_chip.dart';
export 'src/atoms/ui_loader.dart';
export 'src/atoms/ui_text_field.dart';
// Foundations (escala cruda de valores y vocabulario del sistema)
export 'src/foundations/ui_size.dart';
export 'src/foundations/ui_sizes.dart';
export 'src/foundations/ui_status.dart';
// Moléculas
export 'src/molecules/ui_banner.dart';
export 'src/molecules/ui_card.dart';
export 'src/molecules/ui_check_option.dart';
export 'src/molecules/ui_confirm_dialog.dart';
export 'src/molecules/ui_empty_state.dart';
export 'src/molecules/ui_list_tile.dart';
export 'src/molecules/ui_otp_field.dart';
export 'src/molecules/ui_success_view.dart';
// Organismos
export 'src/organisms/ui_list_section.dart';
export 'src/organisms/ui_profile_header.dart';
// Plantillas
export 'src/templates/ui_detail_page_template.dart';
export 'src/templates/ui_page_template.dart';
// Theme (mapea tokens + marca del consumidor a ThemeData)
export 'src/theme/build_context_theme.dart';
export 'src/theme/ui_kit_theme.dart';
export 'src/theme/ui_status_colors.dart';
// Tokens (dan misión a los valores de foundations)
export 'src/tokens/ui_breakpoints.dart';
export 'src/tokens/ui_icon_size.dart';
export 'src/tokens/ui_radius.dart';
export 'src/tokens/ui_spacing.dart';

import 'package:flutter/material.dart';

import '../pages/atoms/avatars_page.dart';
import '../pages/atoms/buttons_page.dart';
import '../pages/atoms/chips_page.dart';
import '../pages/atoms/loaders_page.dart';
import '../pages/atoms/tags_page.dart';
import '../pages/atoms/text_fields_page.dart';
import '../pages/atoms/texts_page.dart';
import '../pages/molecules/banners_page.dart';
import '../pages/molecules/cards_page.dart';
import '../pages/molecules/check_options_page.dart';
import '../pages/molecules/dialogs_page.dart';
import '../pages/molecules/empty_states_page.dart';
import '../pages/molecules/icon_texts_page.dart';
import '../pages/molecules/list_tiles_page.dart';
import '../pages/molecules/otp_fields_page.dart';
import '../pages/molecules/success_views_page.dart';
import '../pages/organisms/list_sections_page.dart';
import '../pages/organisms/profile_headers_page.dart';
import '../pages/pages/profile_page.dart';
import '../pages/pages/team_page.dart';
import '../pages/templates/detail_templates_page.dart';
import '../pages/templates/page_templates_page.dart';
import '../pages/tokens/colors_page.dart';
import '../pages/tokens/spacing_page.dart';
import '../pages/tokens/typography_page.dart';
import 'component_category.dart';
import 'component_entry.dart';

/// Catálogo completo del showcase, organizado por Atomic Design.
final List<ComponentCategory> catalog = <ComponentCategory>[
  ComponentCategory(
    title: 'Tokens',
    icon: Icons.palette_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(title: 'Colores', builder: (_) => const ColorsPage()),
      ComponentEntry(
        title: 'Tipografía',
        builder: (_) => const TypographyPage(),
      ),
      ComponentEntry(
        title: 'Espaciado y radios',
        builder: (_) => const SpacingPage(),
      ),
    ],
  ),
  ComponentCategory(
    title: 'Átomos',
    icon: Icons.circle_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(title: 'Textos', builder: (_) => const TextsPage()),
      ComponentEntry(title: 'Botones', builder: (_) => const ButtonsPage()),
      ComponentEntry(
        title: 'Campos de texto',
        builder: (_) => const TextFieldsPage(),
      ),
      ComponentEntry(title: 'Chips', builder: (_) => const ChipsPage()),
      ComponentEntry(title: 'Etiquetas', builder: (_) => const TagsPage()),
      ComponentEntry(title: 'Loaders', builder: (_) => const LoadersPage()),
      ComponentEntry(title: 'Avatares', builder: (_) => const AvatarsPage()),
    ],
  ),
  ComponentCategory(
    title: 'Moléculas',
    icon: Icons.hub_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(title: 'Cards', builder: (_) => const CardsPage()),
      ComponentEntry(title: 'Banners', builder: (_) => const BannersPage()),
      ComponentEntry(
        title: 'Estados vacíos',
        builder: (_) => const EmptyStatesPage(),
      ),
      ComponentEntry(title: 'Diálogos', builder: (_) => const DialogsPage()),
      ComponentEntry(
        title: 'Filas de lista',
        builder: (_) => const ListTilesPage(),
      ),
      ComponentEntry(
        title: 'Ícono con texto',
        builder: (_) => const IconTextsPage(),
      ),
      ComponentEntry(
        title: 'Opción de aceptación',
        builder: (_) => const CheckOptionsPage(),
      ),
      ComponentEntry(
        title: 'Código OTP',
        builder: (_) => const OtpFieldsPage(),
      ),
      ComponentEntry(
        title: 'Vista de éxito',
        builder: (_) => const SuccessViewsPage(),
      ),
    ],
  ),
  ComponentCategory(
    title: 'Organismos',
    icon: Icons.widgets_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Listas',
        builder: (_) => const ListSectionsPage(),
      ),
      ComponentEntry(
        title: 'Encabezados de perfil',
        builder: (_) => const ProfileHeadersPage(),
      ),
    ],
  ),
  ComponentCategory(
    title: 'Plantillas',
    icon: Icons.view_quilt_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Plantilla de página',
        builder: (_) => const PageTemplatesPage(),
      ),
      ComponentEntry(
        title: 'Plantilla de detalle',
        builder: (_) => const DetailTemplatesPage(),
      ),
    ],
  ),
  ComponentCategory(
    title: 'Páginas',
    icon: Icons.web_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Página de equipo',
        builder: (_) => const TeamPage(),
      ),
      ComponentEntry(
        title: 'Página de perfil',
        builder: (_) => const ProfilePage(),
      ),
    ],
  ),
];

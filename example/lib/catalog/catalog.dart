import 'package:flutter/material.dart';

import '../pages/atoms/avatars_page.dart';
import '../pages/atoms/buttons_page.dart';
import '../pages/atoms/chips_page.dart';
import '../pages/atoms/loaders_page.dart';
import '../pages/atoms/text_fields_page.dart';
import '../pages/molecules/banners_page.dart';
import '../pages/molecules/cards_page.dart';
import '../pages/molecules/empty_states_page.dart';
import '../pages/organisms/dialogs_page.dart';
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
      ComponentEntry(title: 'Botones', builder: (_) => const ButtonsPage()),
      ComponentEntry(
        title: 'Campos de texto',
        builder: (_) => const TextFieldsPage(),
      ),
      ComponentEntry(title: 'Chips', builder: (_) => const ChipsPage()),
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
    ],
  ),
  ComponentCategory(
    title: 'Organismos',
    icon: Icons.widgets_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(title: 'Diálogos', builder: (_) => const DialogsPage()),
    ],
  ),
];

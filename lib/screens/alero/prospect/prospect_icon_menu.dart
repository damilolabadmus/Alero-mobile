import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

class IconsMenu {
  static const items = <IconMenu>[
    view,
    delete,
  ];

  static const view = IconMenu(
    text: 'View',
    icon: Icons.search,
    iconColor: Colors.lightBlueAccent,
  );

  static const delete = IconMenu(
    text: 'Delete',
    icon: Icons.delete,
    iconColor: Style.Colors.searchInActiveBgLeading,
  );
  static const convert = IconMenu(
    text: '',
    icon: Icons.check,
    iconColor: Style.Colors.searchInActiveBgLeading,
  );
}

class IconMenu {
  final String text;
  final IconData icon;
  final Color iconColor;

  const IconMenu({
    @required this.text,
    @required this.icon,
    @required this.iconColor,
  });
}

class ConvertedIconsMenu {
  static const items = <ConvertedIconMenu>[
    view,
    convert,
  ];

  static const view = ConvertedIconMenu(
    text: 'View',
    icon: Icons.search,
    iconColor: Colors.lightBlueAccent,
  );

  static const convert = ConvertedIconMenu(
    text: 'Converted',
    icon: Icons.check,
    iconColor: Colors.red,
  );
}

class ConvertedIconMenu {
  final String text;
  final IconData icon;
  final Color iconColor;

  const ConvertedIconMenu({
    @required this.text,
    @required this.icon,
    @required this.iconColor,
  });
}

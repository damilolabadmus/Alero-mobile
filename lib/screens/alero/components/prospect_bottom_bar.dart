import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

class ProspectBottomBar extends StatefulWidget {

  @override
  _ProspectBottomBarState createState() => _ProspectBottomBarState();
}

class _ProspectBottomBarState extends State<ProspectBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.favorite_outlined,
              size: 30.0,
            ),
            onPressed: () {},
            splashColor: Style.Colors.buttonColor,
            splashRadius: 25.0,
          ),
          label: 'Prospects',
          backgroundColor: Style.Colors.buttonColor,
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.format_underlined,
              size: 40.0,
            ),
            splashColor: Style.Colors.grey,
            onPressed: () {},
            splashRadius: 25.0,
          ),
          label: 'Pipeline Deals',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.layers,
              size: 40.0,
            ),
            onPressed: () {},
            splashColor: Style.Colors.grey,
            splashRadius: 25.0,
          ),
          label: 'Reports',
        ),
      ],
    );
  }
}

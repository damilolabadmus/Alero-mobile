import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class CallAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CallAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Style.Colors.searchActiveBg,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Icon(
            EvaIcons.arrowBack,
            color: Colors.black,
            size: 20
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(Icons.home),
            color: Colors.black54,
            iconSize: 20.0,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  '/landing', (Route<dynamic> route) => false);
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}


class SimpleCallAppBar {
  static AppBar build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 40,
      backgroundColor: Style.Colors.searchActiveBg,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Icon(
            EvaIcons.arrowBack,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: GestureDetector(
            onTap: () {
              Pandora.logoutUser(context);
            },
            child: SvgPicture.asset('assets/customer/profile_logout.svg', width: 17),
          ),
        ),
      ],
    );
  }
}

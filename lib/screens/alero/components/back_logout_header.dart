
import 'package:alero/network/AleroAPIService.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';
import '../../../style/theme.dart' as Style;
import '../../../utils/Pandora.dart';

class BackLogoutHeader extends StatelessWidget implements PreferredSizeWidget{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Style.Colors.searchActiveBg,
      leading: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Icon(
            EvaIcons.arrowBack,
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/landing', (Route<dynamic> route) => false);
        },
      ),
      actions: [
        InkWell(
          onTap: () {
            Pandora.logoutUser(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              'assets/landing/landing_lock.svg',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

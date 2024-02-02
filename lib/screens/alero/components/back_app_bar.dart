

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;
import 'package:flutter_svg/svg.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? header;
  final Function? press;

  const BackAppBar({
    Key? key,
    this.header,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        header!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Style.Colors.blackTextColor,
          fontSize: 17.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      leading: GestureDetector(
        onTap: press as void Function()?,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(
            'assets/search/search_back_new.svg',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

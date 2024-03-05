

import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';

import '../../../utils/Pandora.dart';

class SimpleBottomNavItem extends StatefulWidget {

  @override
  State<SimpleBottomNavItem> createState() => _SimpleBottomNavItemState();
}

class _SimpleBottomNavItemState extends State<SimpleBottomNavItem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: SvgPicture.asset(
                  'assets/customer/profile_dashboard.svg',
                  color: Colors.black26,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkWell(
                child: SvgPicture.asset(
                  'assets/customer/profile_logout.svg',
                ),
                onTap: () {
                  Pandora.logoutUser(context);
                },
              )
            ],
          ),
        ));
  }
}



import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';

class CustomerBottomNavigationBar extends StatefulWidget {

  @override
  _CustomerBottomNavigationBarState createState() => _CustomerBottomNavigationBarState();
}

class _CustomerBottomNavigationBarState extends State<CustomerBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switchPage(index, context);
      },
      backgroundColor: Colors.blueGrey.shade50,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/customer_pnd.svg',
              height: 15,
            ),
          ),
          label: "Prospects",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/profile_logout.svg',
              height: 15,
            ),
          ),
          label: "Logout",
        ),
      ],
    );
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnCallManagement(context);
        break;
      case 1:
        returnLogin(context);
        break;
    }
  }

  void returnCallManagement(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/call-management', (Route<dynamic> route) => false);
  }

  void returnLogin(BuildContext context) {
    Pandora.logoutUser(context);
  }
}

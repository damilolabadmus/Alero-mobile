

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/Pandora.dart';

class PerformanceBottomNavigationBar extends StatefulWidget {
  bool? isPl;

  PerformanceBottomNavigationBar({this.isPl});

  @override
  State<PerformanceBottomNavigationBar> createState() => _PerformanceBottomNavigationBarState();
}

class _PerformanceBottomNavigationBarState extends State<PerformanceBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: BottomNavigationBar(
        elevation: 5,
        onTap: (int index) {
          switchPage(index, context, widget.isPl);
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                'assets/customer/profile_dashboard.svg',
              ),
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                'assets/customer/profile_search.svg',
              ),
            ),
            label: "Account Reports",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                'assets/customer/profile_logout.svg',
              ),
            ),
            label: "Logout",
          ),
        ],
      ),
    );
  }

  void switchPage(int index, BuildContext context, bool? isPl) {
    print(index);
    switch (index) {
      case 0:
        returnPerformanceManagement(context, isPl);
        break;
      case 1:
        returnMyBalanceSheetPage(context);
        break;
      case 2:
        returnLogin(context);
        break;
    }
  }

  void returnPerformanceManagement(BuildContext context, bool? isPl) {
    isPl == false ?
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/performance-management', (Route<dynamic> route) => false) :
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/profitability-reports', (Route<dynamic> route) => false);
  }

  void returnMyBalanceSheetPage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/my-balance-sheet-page', (Route<dynamic> route) => false);
  }

  void returnLogin(BuildContext context) {
    Pandora.logoutUser(context);
  }
}

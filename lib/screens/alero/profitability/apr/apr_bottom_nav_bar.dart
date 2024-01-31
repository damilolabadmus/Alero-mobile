import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AprBottomNavigationBar extends StatefulWidget {
  final bool aprDataNotNull;
  final bool isFirstPage;

  AprBottomNavigationBar({this.aprDataNotNull, this.isFirstPage});

  @override
  State<AprBottomNavigationBar> createState() => _AprBottomNavigationBarState();
}

class _AprBottomNavigationBarState extends State<AprBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 11,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.blueGrey.shade50,
      elevation: 1,
      selectedItemColor: Colors.black54,
      unselectedFontSize: 11,
      onTap: (int index) {
        widget.isFirstPage == true ? dashboardSwitchPage(index, context) : switchPage(index, context);
        setState(() {
          _selectedIndex = index;
        });
      },
      items: widget.isFirstPage == true ? dashboardBarItems() : barItems(),
    );
  }

  void dashboardSwitchPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        returnAprPage(context);
        break;
      case 1:
        returnAprDetailsPage(context);
        break;
    }
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnAprPage(context);
        break;
      case 1:
        returnAprDetailsPage(context);
        break;
      case 2:
        returnAprBalanceSheetPage(context);
        break;
    }
  }

  void returnAprPage(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil('/account-pr', (Route<dynamic> route) => false);
  }

  void returnAprDetailsPage(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/apr-details', (Route<dynamic> route) => false);
  }

  void returnAprBalanceSheetPage(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/apr-balance-sheet', (Route<dynamic> route) => false);
  }

  List<BottomNavigationBarItem> barItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/profile_dashboard.svg',
          color: Colors.black45,
          height: 12,
        ),
        label: "Dashboard",
        // title: Text("Dashboard"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        label: "Account Details",
        // title: Text("Account Details"),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/biodata/biodata_id.svg',
          color: Colors.black45,
          height: 12,
        ),
        label: "Balance Sheet",
        // title: Text("Balance Sheet"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.searchOutline,
          color: Colors.black45,
          size: 18,
        ),
        label: "Searched Account.",
        // title: Text("Searched Account."),
      ),
    ];}


  List<BottomNavigationBarItem> dashboardBarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/profile_dashboard.svg',
          color: Colors.black45,
          height: 12,
        ),
        label: "Dashboard",
        // title: Text("Dashboard"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        label: "Account Details",
        // title: Text("Account Details"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.searchOutline,
          color: Colors.black45,
          size: 18,
        ),
        label: "Searched Account.",
        // title: Text("Searched Account"),
      ),
    ];
  }
}

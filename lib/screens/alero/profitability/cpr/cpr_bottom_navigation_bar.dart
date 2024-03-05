

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CprBottomNavigationBar extends StatefulWidget {
  final bool? isFirstPage;

  CprBottomNavigationBar({this.isFirstPage});

  @override
  _CprBottomNavigationBarState createState() => _CprBottomNavigationBarState();
}

class _CprBottomNavigationBarState extends State<CprBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 11,
      // selectedFontSize: 13,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.blueGrey.shade50,
      elevation: 1,
      selectedItemColor: Colors.black54,
      unselectedFontSize: 11,
      // unselectedFontSize: 10,
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
        returnCprPage(context);
        break;
      case 1:
        returnCprProfitAndLossPage(context);
        break;
    }
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnCprPage(context);
        break;
      case 1:
        returnCprProfitAndLossPage(context);
        break;
      case 2:
        returnCprBalanceSheet(context);
        break;
    }
  }

  void returnCprPage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/customer-pr', (Route<dynamic> route) => false);
  }

  void returnCprProfitAndLossPage(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/cpr-profit-and-loss', (Route<dynamic> route) => false);
  }

  void returnCprBalanceSheet(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil('/cpr-balance-sheet', (Route<dynamic> route) => false);
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
        tooltip: 'Please click \'view more\' to select a customer.',
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        label: "Customer P & L",
        // title: Text("Customer P & L"),
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
        tooltip: 'Please use the search box above',
        icon: Icon(
          EvaIcons.searchOutline,
          color: Colors.black45,
          size: 18,
        ),
        label: "Searched Cust.",
        // title: Text("Searched Cust."),
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
        label: "Customer P & L",
        // title: Text("Customer P & L"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.searchOutline,
          color: Colors.black45,
          size: 18,
        ),
        label: "Searched Cust.",
        // title: Text("Searched Cust."),
      ),
    ];}
}


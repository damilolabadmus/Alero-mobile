import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/Strings.dart' as Strings;

class CprBottomNavigationBar extends StatefulWidget {
  final bool barItemSelected;
  final bool searchedCustomer;
  final bool cprDataNotNull;
  final bool isFirstPage;

  CprBottomNavigationBar({@required this.barItemSelected, this.searchedCustomer, this.cprDataNotNull, this.isFirstPage});

  @override
  _CprBottomNavigationBarState createState() => _CprBottomNavigationBarState();
}

class _CprBottomNavigationBarState extends State<CprBottomNavigationBar> {
  int _selectedIndex = 0;
  final Pandora pandora = new Pandora();
  List<BottomNavigationBarItem> selectedItems;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.blueGrey.shade50,
      elevation: 1,
      selectedItemColor: widget.barItemSelected == false ? Colors.black54 : Colors.lightBlueAccent.shade700,
      unselectedItemColor: Colors.black54,
      unselectedFontSize: 10,
      onTap: (int index) {
        /*widget.isFirstPage == true ? menuSwitchPage(index, context)
        : */switchPage(index, context);

         setState(() {
           _selectedIndex = index;
         });
       },
      items: widget.isFirstPage == true ? menuBarItems() : barItems(),
    );
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
      case 3:
          returnSearchedCprPage(context);
        break;
    }
  }

  void menuSwitchPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        returnCprPage(context);
        break;
      case 1:
          returnCprProfitAndLossPage(context);
        break;
      case 2:
          returnSearchedCprPage(context);
        break;
    }
  }

  void returnCprPage(BuildContext context) {
    if (_selectedIndex == 0) {
      if (widget.barItemSelected == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/customer-pr', (Route<dynamic> route) => false);
      }
    }
  }

  void returnCprProfitAndLossPage(BuildContext context) {
    if (widget.barItemSelected == true && widget.cprDataNotNull == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/cpr-profit-and-loss', (Route<dynamic> route) => false);
    } else {
      pandora.displayToast(Strings.Errors.nullInputError, context, Colors.black45);
    }
  }

  void returnCprBalanceSheet(BuildContext context) {
    if (widget.barItemSelected == true && widget.cprDataNotNull == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/cpr-balance-sheet', (Route<dynamic> route) => false);
    } else {
      pandora.displayToast(Strings.Errors.nullInputError, context, Colors.black45);
    }
  }

  void returnSearchedCprPage(BuildContext context) {
    if (widget.barItemSelected == true && widget.searchedCustomer == true && widget.cprDataNotNull == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/searched-cpr', (Route<dynamic> route) => false);
    } else {
      pandora.displayToast(Strings.Errors.nullSearchError, context, Colors.black45);
    }
  }


  List<BottomNavigationBarItem> barItems() {
   return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/profile_dashboard.svg',
          color: Colors.black45,
          height: 12,
        ),
        title: Text("Dashboard"),
      ),
      BottomNavigationBarItem(
        // tooltip: widget.barItemSelected == false ? 'Please click \'view more\' to select a customer.' : '',
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        title: Text("Customer P & L"),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/biodata/biodata_id.svg',
          color: Colors.black45,
          height: 12,
        ),
        title: Text("Balance Sheet"),
      ),
     BottomNavigationBarItem(
       icon: Icon(
         EvaIcons.searchOutline,
         color: Colors.black45,
         size: 18,
       ),
       title: Text("Searched Cust."),
       // title: Text("Searched Customer"),
     ),
    ];}

    List<BottomNavigationBarItem> menuBarItems() {
   return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/customer/profile_dashboard.svg',
          color: Colors.black45,
          height: 12,
        ),
        title: Text("Dashboard"),
      ),
      BottomNavigationBarItem(
        // tooltip: widget.barItemSelected == false ? 'Please click \'view more\' to select a customer.' : '',
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        title: Text("Customer P & L"),
      ),
     BottomNavigationBarItem(
       icon: Icon(
         EvaIcons.searchOutline,
         color: Colors.black45,
         size: 18,
       ),
       title: Text("Searched Cust."),
     ),
  ];}
}

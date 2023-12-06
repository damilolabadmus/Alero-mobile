import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/Strings.dart' as Strings;

class AprBottomNavigationBar extends StatefulWidget {
  final barItemSelected;

  AprBottomNavigationBar({this.barItemSelected});

  @override
  State<AprBottomNavigationBar> createState() => _AprBottomNavigationBarState();
}

class _AprBottomNavigationBarState extends State<AprBottomNavigationBar> {
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
        switchPage(index, context);

        setState(() {
          _selectedIndex = index;
        });
      },
      items: barItems(),
    );
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
        returnSearchedAprPage(context);
        break;
    }
  }

  void returnAprPage(BuildContext context) {
    if (_selectedIndex == 0) {
      if (widget.barItemSelected == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/account-pr', (Route<dynamic> route) => false);
      }
    }
  }

  void returnAprDetailsPage(BuildContext context) {
    if (widget.barItemSelected == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/apr-details', (Route<dynamic> route) => false);
    } else {
      pandora.displayToast(Strings.Errors.nullInputError, context, Colors.black45);
    }
  }

  void returnSearchedAprPage(BuildContext context) {
    if (widget.barItemSelected == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('/searched-apr', (Route<dynamic> route) => false);
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
        title: Text("Account Dashboard"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.options2,
          color: Colors.grey.shade500,
          size: 18,
        ),
        title: Text("Account Details"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          EvaIcons.searchOutline,
          color: Colors.black45,
          size: 18,
        ),
        title: Text("Searched Account."),
        // title: Text("Searched Customer"),
      ),
    ];}
}

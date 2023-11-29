import 'package:alero/network/AleroAPIService.dart';
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
      backgroundColor: Colors.lightBlue.shade50,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/customer_pnd.svg',
            ),
          ),
          title: Text("Prospects",
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.normal)),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/profile_logout.svg',
            ),
          ),
          // ignore: deprecated_member_use
          title: Text("Logout",
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.normal)),
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
    logoutUser(context);
  }

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }
}

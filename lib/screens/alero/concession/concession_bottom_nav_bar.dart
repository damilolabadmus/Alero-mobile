import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';

class ConcessionBottomNavigationBar extends StatefulWidget {

  @override
  State<ConcessionBottomNavigationBar> createState() => _ConcessionBottomNavigationBarState();
}

class _ConcessionBottomNavigationBarState extends State<ConcessionBottomNavigationBar> {
  var apiService = new AleroAPIService();
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: BottomNavigationBar(
        elevation: 5,
        onTap: (int index) {
          switchPage(index, context);
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                'assets/customer/profile_dashboard.svg',
              ),
            ),
            title: Text("Dashboard",
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
            title: Text("Logout",
                style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnPerformanceManagement(context);
        break;
      case 1:
        returnLogin(context);
        break;
    }
  }

  void returnPerformanceManagement(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/concession-dashboard', (Route<dynamic> route) => false);
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

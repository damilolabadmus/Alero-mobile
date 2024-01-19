import 'dart:convert';
import 'package:alero/dummy/dummy.dart';
import 'package:alero/models/landing/GetStaffInformation.dart';
import 'package:alero/models/landing/view_modules_response.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/utils/Global.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:alero/screens/alero/home/home_header.dart';
import '/utils/Strings.dart' as Strings;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.data}) : super(key: key);
  final String data;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  String firstName = "";
  List<Widget> dashboardItem = [];
  List<Color> randomColors = [];

  getUserDetails() async {
    OneContext().showProgressIndicator();
    bool hasInternet = await pandora.hasInternet();
    if (hasInternet) {
      /// Get User Status
      final userStatusResponse = await apiService.getUserStatus();
      try {
        Global.isRM = userStatusResponse.canView;
      } catch (ex) {
        pandora.showToast(
            ex, context, MessageTypes.WARNING.toString().split('.').last);
      }

      /// Get Staff Information
      final staffInformationResponse = await apiService.getStaffInformation();
      try {
        Global.STAFF_INFORMATION = jsonEncode(staffInformationResponse);
        if (mounted) {
          setState(() {
            firstName = GetStaffInformation.fromJson(
                jsonDecode(Global.STAFF_INFORMATION))
                .firstName;
          });
        }
      } catch (ex) {
        pandora.showToast(
            ex, context, MessageTypes.WARNING.toString().split('.').last);
      }
    } else {
      pandora.showToast(Strings.Errors.connectionError, context,
          MessageTypes.WARNING.toString().split('.').last);
    }
    OneContext().hideProgressIndicator();
  }

  bool isCallManagement;
  getModulesAuthorization() async {
    final userAuthorisation = await apiService.getUserAuthorization();
    HasAccessToCallManagement userAccess = userAuthorisation.result.hasAccessToCallManagement;
    HasAccessTo callManagementAccess = userAccess.hasAccessToProspect;
    isCallManagement = callManagementAccess.canCreate;
  }


  @override
  void initState() {
    super.initState();
    getDashboardItems(isCallManagement);
    getUserDetails();
    getModulesAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 50, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey $firstName!,", style: kHeadingextStyle),
                  Text("What would you like to do today?",
                      style: kSubheadingextStyle),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Menu", style: kTitleTextStyle),
                    ],
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: dashboardItem,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getDashboardItems(isAccess) {
    dashboardItem = [];
    List<Widget> _dashboardItem = [];
    var dashboardItems;

    if (isCallManagement = true) {
      dashboardItems = dashboardMenu;
    } else {
      dashboardItems = dashboardMenuAccess;
    }
    generateColors(dashboardItems.length);

    int i = 0;
    dashboardItems.forEach((element) {
      _dashboardItem.add(DashboardItem(
        message: element['name'],
        image: element['image'],
        color: randomColors[i].withOpacity(0.5),
        press: () {
          onMenuClick(element['position'], isCallManagement);
        },
      ));
      i++;
    });
    setState(() {
      dashboardItem = _dashboardItem;
    });
  }


  onMenuClick(int element, bool isAccess) {
    switch (element) {
      case 0:
        Navigator.of(context)
            .pushNamed('/single-customer-view', arguments: firstName);
        break;
      case 1:
        Navigator.of(context)
            .pushNamed('/performance-management', arguments: firstName);
        break;
      case 2:
        isCallManagement == true ?
        Navigator.of(context)
            .pushNamed('/call-management', arguments: firstName) :
        pandora.showToast('Coming Soon', context,
            MessageTypes.INFO.toString().split('.').last);
        break;
        /*case 3:
        Navigator.of(context)
            .pushNamed('/concession-dashboard', arguments: firstName);
        break;*/
      default:
        pandora.showToast('Coming Soon', context,
            MessageTypes.INFO.toString().split('.').last);
        break;
    }
  }


  void generateColors(int length) {
    var list = [
      0xFF99C9D9,
      0xFF008EC4,
      0xFFBBBBBB,
      0xFFFFDAA6,
      0xFFB3A369,
      0xFFF4B459,
      0xFF7AC369
    ];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}




/* // Initial code; without having call management authorization.
import 'dart:convert';
import 'package:alero/dummy/dummy.dart';
import 'package:alero/models/landing/GetStaffInformation.dart';
import 'package:alero/models/landing/view_modules_response.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/utils/Global.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:alero/screens/alero/home/home_header.dart';
import '/utils/Strings.dart' as Strings;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.data}) : super(key: key);
  final String data;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  String firstName = "";
  List<Widget> dashboardItem = [];
  List<Color> randomColors = [];

  getUserDetails() async {
    OneContext().showProgressIndicator();
    bool hasInternet = await pandora.hasInternet();
    if (hasInternet) {
      /// Get User Status
      final userStatusResponse = await apiService.getUserStatus();
      try {
        Global.isRM = userStatusResponse.canView;
      } catch (ex) {
        pandora.showToast(
            ex, context, MessageTypes.WARNING.toString().split('.').last);
      }

      /// Get Staff Information
      final staffInformationResponse = await apiService.getStaffInformation();
      try {
        Global.STAFF_INFORMATION = jsonEncode(staffInformationResponse);
        if (mounted) {
          setState(() {
            firstName = GetStaffInformation.fromJson(
                    jsonDecode(Global.STAFF_INFORMATION))
                .firstName;
          });
        }
      } catch (ex) {
        pandora.showToast(
            ex, context, MessageTypes.WARNING.toString().split('.').last);
      }
    } else {
      pandora.showToast(Strings.Errors.connectionError, context,
          MessageTypes.WARNING.toString().split('.').last);
    }
    OneContext().hideProgressIndicator();
  }

  @override
  void initState() {
    super.initState();
    getDashboardItems();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            SizedBox(height: 30),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey $firstName!,", style: kHeadingextStyle),
                    Text("What would you like to do today?",
                        style: kSubheadingextStyle),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Menu", style: kTitleTextStyle),
                      ],
                    ),
                    GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: dashboardItem,
                        ),
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }

  void getDashboardItems() {
    dashboardItem = [];
    List<Widget> _dashboardItem = [];

    var dashboardItems = dashboardMenu;
    generateColors(dashboardItems.length);

    int i = 0;
    dashboardItems.forEach((element) {
      _dashboardItem.add(DashboardItem(
        message: element['name'],
        image: element['image'],
        color: randomColors[i].withOpacity(0.5),
        press: () {
          onMenuClick(element['position']);
        },
      ));
      i++;
    });
    setState(() {
      dashboardItem = _dashboardItem;
    });
  }

  onMenuClick(int element) {
    switch (element) {
      case 0:
        Navigator.of(context)
            .pushNamed('/single-customer-view', arguments: firstName);
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/call-management', arguments: firstName);
        break;
      default:
        pandora.showToast('Coming Soon', context,
            MessageTypes.INFO.toString().split('.').last);
        break;
    }
  }

  void generateColors(int length) {
    var list = [
      0xFF99C9D9,
      0xFF008EC4,
      0xFFBBBBBB,
      0xFFFFDAA6,
      0xFFB3A369,
      0xFFF4B459,
      0xFF7AC369
    ];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}
*/

import 'package:alero/dummy/dummy.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/screens/alero/my_balance_sheet/bloc/balance_sheet_bloc/balance_sheet_bloc.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_balance_sheet/bloc/balance_sheet_nav_bloc/balance_sheet_nav_bloc.dart';
import '../my_balance_sheet/bloc/log_out_bloc/log_out_bloc.dart';

class PerformanceManagementDashboard extends StatefulWidget {
  const PerformanceManagementDashboard({Key? key}) : super(key: key);

  @override
  State<PerformanceManagementDashboard> createState() => _PerformanceManagementDashboardState();
}

class _PerformanceManagementDashboardState extends State<PerformanceManagementDashboard> {
  final Pandora pandora = new Pandora();
  List<Widget> dashboardItem = [];
  List<Color> randomColors = [];

  String firstName = "";

  @override
  void initState() {
    super.initState();
    getDashboardItems();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Welcome, below are different reports to select from.', style: kBankItemTitle.copyWith(fontSize: 15)),
                  ),
                  SizedBox(height: 20.0),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
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

    var dashboardItems = performanceDashboardMenu;
    generateColors(dashboardItems.length);

    int i = 0;
    dashboardItems.forEach((element) {
      _dashboardItem.add(DashboardItemAlign(
        message: element['name'] as String?,
        image: element['image'] as String?,
        color: randomColors[i].withOpacity(0.5),
        press: () {
          onMenuClick(element['position'] as int?);
        },
      ));
      i++;
    });
    setState(() {
      dashboardItem = _dashboardItem;
    });
  }

  onMenuClick(int? element) {
    switch (element) {
      case 0:
        Navigator.of(context).pushNamed('/my-balance-sheet-page', arguments: firstName);
        break;
      case 1:
        Navigator.of(context).pushNamed('/profitability-reports', arguments: firstName);
        break;
      case 2:
        Navigator.of(context).pushNamed('/cost-allocation', arguments: firstName);
        break;
      default:
        pandora.showToast('Coming soon...', context, MessageTypes.INFO.toString().split('.').last);
        break;
    }
  }

  void generateColors(int length) {
    var list = [
      0xFFADD8E6,
      0xFFD2B48C,
      0xFFB0C4DE,
      0xFFD2B48C,
      0xFFB0E0E6,
      0xFF87CEFA,
      0xFFD2B48C,
      0xFFAFEEEE,
    ];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}

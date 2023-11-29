import 'package:alero/dummy/dummy.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerformanceManagementDashboard extends StatefulWidget {
  const PerformanceManagementDashboard({Key key}) : super(key: key);

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
                  Text('Dashboard',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Welcome, below are different reports to select from.',
                        style: kBankItemTitle.copyWith(fontSize: 15)),),
                  SizedBox(height: 20.0),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
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

    var dashboardItems = performanceDashboardMenu;
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
        Navigator.of(context).pushNamed('/my-balance-sheet-page', arguments: firstName);
        break;
      case 1:
        Navigator.of(context).pushNamed('/profitability-reports', arguments: firstName);
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/cost-allocation', arguments: firstName);
        break;
      case 3:
        Navigator.of(context)
            .pushNamed('/concession', arguments: firstName);
        break;
      default:
        pandora.showToast('Coming soon...', context,
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

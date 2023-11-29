import 'package:alero/dummy/dummy.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

import 'concession_bottom_nav_bar.dart';

class ConcessionDashboard extends StatefulWidget {
  const ConcessionDashboard({Key key}) : super(key: key);

  @override
  State<ConcessionDashboard> createState() => _ConcessionDashboardState();
}

class _ConcessionDashboardState extends State<ConcessionDashboard> {

  final Pandora pandora = new Pandora();
  List<Widget> dashboardItem = [];
  List<Color> randomColors = [];

  @override
  void initState() {
    super.initState();
    getDashboardItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: CallAppBar(),
      backgroundColor: Style.Colors.elementBack,
      body: Padding(
        padding: EdgeInsets.only(left: 12, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Dashboard',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Please select from the modules below.',
                          style: kBankItemTitle.copyWith(fontSize: 15)),),
                    SizedBox(height: 10.0),
                    GridView.count(
                      physics: const AlwaysScrollableScrollPhysics(),
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
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }

  void getDashboardItems() {
    dashboardItem = [];
    List<Widget> _dashboardItem = [];

    var dashboardItems = concessionDashboardMenu;
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
        Navigator.of(context).pushNamed('/create-concession');
        break;
      case 1:
        Navigator.of(context).pushNamed('/approve-concession');
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/treat-concession');
        break;
      case 3:
        Navigator.of(context)
            .pushNamed('/retrieve-concession');
        break;
      case 4:
        Navigator.of(context)
            .pushNamed('/terminate-concession');
        break;
      case 5:
        Navigator.of(context)
            .pushNamed('/track-concession');
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

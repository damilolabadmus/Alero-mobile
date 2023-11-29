import 'package:alero/dummy/dummy.dart';
import 'package:alero/screens/alero/components/dashboard_item.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class ProfitabilityReportsDashboard extends StatefulWidget {
  const ProfitabilityReportsDashboard({Key key}) : super(key: key);

  @override
  State<ProfitabilityReportsDashboard> createState() => _ProfitabilityReportsDashboardState();
}

class _ProfitabilityReportsDashboardState extends State<ProfitabilityReportsDashboard> {
  final Pandora pandora = new Pandora();
  String firstName = "";

  List<Widget> dashboardItem = [];
  List<Color> randomColors = [];

  @override
  void initState() {
    super.initState();
    getDashboardItems();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('P/L Reports',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Below are different reports to select from.',
                        style: kBankItemTitle.copyWith(fontSize: 15)),),],),
                SizedBox(height: 20.0),
                Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: dashboardItem,
                  ),
                )
              ],),
          ),
        ),
      ),
    );
  }

  void getDashboardItems() {
    dashboardItem = [];
    List<Widget> _dashboardItem = [];

    var dashboardItems = profitabilityDashboardMenu;
    generateColors(dashboardItems.length);

    int i = 0;
    dashboardItems.forEach((element) {
      _dashboardItem.add(
          DashboardItem(
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
           .pushNamed('/customer-pr', arguments: firstName);
        break;
      case 1:
        Navigator.of(context)
         .pushNamed('/account-pr', arguments: firstName);
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/monthly-pr', arguments: firstName);
        break;
      case 3:
        Navigator.of(context)
            .pushNamed('/nrff', arguments: firstName);
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

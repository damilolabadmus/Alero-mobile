import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class CallBottomNavigationBar extends StatefulWidget {

  @override
  _CallBottomNavigationBarState createState() => _CallBottomNavigationBarState();
}

class _CallBottomNavigationBarState extends State<CallBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightBlueAccent.shade700,
      onTap: (int index) {
        switchPage(index, context);
      },
      backgroundColor: Style.Colors.searchActiveBg,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/biodata/biodata_mail.svg',
              color: Colors.black45,
              height: 12,
            ),
          ),
          label: "Dashboard",
          // title: Text("Dashboard",
          //     style: TextStyle(
          //         fontSize: 12.0,
          //         fontFamily: 'Poppins-Regular',
          //         fontWeight: FontWeight.normal)),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/biodata/biodata_id.svg',
              height: 12,
            ),
          ),
          label: "Prospects",
          // title: Text("Prospects",
          //     style: TextStyle(
          //         fontSize: 12.0,
          //         fontFamily: 'Poppins-Regular',
          //         fontWeight: FontWeight.normal)),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/overview/channels_leading.svg',
              color: Colors.black38,
              height: 13,
            ),
          ),
          label: "Pipeline Deals",
          // title: Text("Pipeline Deals",
          //   style: TextStyle(
          //     fontSize: 12.0,
          //     fontFamily: 'Poppins-Regular',
          //     fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnCallManagementPage(context);
        break;
      case 1:
        returnProspect(context);
        break;
      case 2:
        returnPipeline(context);
        break;
    }
  }

  void returnCallManagementPage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/callManagementPage', (Route<dynamic> route) => false);
  }

  void returnProspect(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/prospect', (Route<dynamic> route) => false);
  }

  void returnPipeline(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/pipeline', (Route<dynamic> route) => false);
  }

}

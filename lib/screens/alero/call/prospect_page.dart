

import 'package:alero/screens/alero/prospect/prospect_add.dart';
import 'package:flutter/material.dart';
import '../prospect/prospect_search_controller.dart';
import 'call_bottom_navigation_bar.dart';
import 'call_management_page.dart';
import 'package:alero/style/theme.dart' as Style;

class ProspectPage extends StatefulWidget {
  final String? data;

  ProspectPage({Key? key, this.data}) : super(key: key);

  @override
  _ProspectPageState createState() => _ProspectPageState();
}

class _ProspectPageState extends State<ProspectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar() as PreferredSizeWidget?,
        body : Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProspectAdd(),
                ProspectSearchController(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CallBottomNavigationBar()
    );
  }

  Widget appBar() => AppBar(
    toolbarHeight: 50,
    leading: IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CallManagementPage(),),
        );},
      icon: Icon(
        Icons.arrow_back_ios,
        color: Style.Colors.blackTextColor,
        size: 20,
      ),
    ),
    backgroundColor: Style.Colors.searchActiveBg,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TextButton(
          child: IconButton(
            icon: Icon(Icons.home, color: Colors.blueGrey.shade300),
            iconSize: 30.0, onPressed: () {  },
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
          },
        ),
      ),
    ],
  );
}
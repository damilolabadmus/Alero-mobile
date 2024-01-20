import 'package:alero/screens/alero/profitability/profitability_reports_dashboard.dart';
import 'package:alero/screens/alero/components/simple_bottom_nav.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../../../../style/theme.dart' as Style;
import 'package:flutter/material.dart';

class ProfitabilityReportsPage extends StatelessWidget {

  final String userId;

  ProfitabilityReportsPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/landing', (Route<dynamic> route) => false);
            },
          icon: Icon(
            EvaIcons.arrowBack,
            color: Style.Colors.blackTextColor,
            size: 24,
          ),
        ),
        backgroundColor: Style.Colors.searchActiveBg,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.black45,
              iconSize: 30.0,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/landing', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body: ProfitabilityReportsDashboard(),
      bottomNavigationBar: SimpleBottomNavItem());
  }
}

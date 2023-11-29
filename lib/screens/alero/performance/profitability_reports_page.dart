import 'package:alero/screens/alero/components/back_logout_header.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/performance/profitability_reports_dashboard.dart';
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
                '/performance-management', (Route<dynamic> route) => false);
            },
          icon: Icon(
            Icons.arrow_back_ios,
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
      backgroundColor: Style.Colors.elementBack,
      body: ProfitabilityReportsDashboard(),
      bottomNavigationBar: PerformanceBottomNavigationBar(isPl: false),
    );
  }
}

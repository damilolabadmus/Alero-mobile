import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class AccountProfitabilityReport extends StatefulWidget {
  final String userId;

  AccountProfitabilityReport({@required this.userId});

  @override
  State<AccountProfitabilityReport> createState() => _AccountProfitabilityReportState();
}

class _AccountProfitabilityReportState extends State<AccountProfitabilityReport> {

  Function search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: Column(
        children: [
          Text('Account Profitability Report',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins-Regular',
            ),),
          /*PmTitleContainer(
            measure: 'Account PR',
          ),*/
          /*ReportSearchController(
            search: search,
          ),*/
          /*Container(
              child: ReportTableContainer()
              child: ProfitabilityTableContainer()
          ),*/
        ],
      ),
      bottomNavigationBar: PerformanceBottomNavigationBar(isPl: true),
    );
  }
}

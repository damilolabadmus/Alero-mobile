

import 'package:alero/screens/alero/dashboard/completed_deals_by_product.dart';
import 'package:alero/screens/alero/dashboard/deal_currency_chart.dart';
import 'package:alero/screens/alero/dashboard/deal_product_type_chart.dart';
import 'package:alero/screens/alero/dashboard/pending_deals_by_product.dart';
import 'package:alero/screens/alero/dashboard/turn_around_time_chart.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

class CallManagementDashboard extends StatefulWidget {
  final String? data;

  CallManagementDashboard({Key? key, this.data}) : super(key: key);

  @override
  _CallManagementDashboardState createState() => _CallManagementDashboardState();
}

class _CallManagementDashboardState extends State<CallManagementDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text('Dashboard',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'View all pipeline reports here.',
                        style: TextStyle(
                          color: Style.Colors.subBlackTextColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins-Regular',
                        ),),),],),),
              TurnAroundTimeChart(),
              DealProductTypeChart(),
              DealCurrencyChart(),
              CompletedDealsByProduct(),
              PendingDealsByProduct(),
            ],),),
      ),);
  }
}

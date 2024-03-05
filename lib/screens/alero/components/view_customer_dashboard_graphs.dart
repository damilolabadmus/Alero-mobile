

import 'package:alero/screens/alero/dashboard/deposits_trend_chart.dart';
import 'package:alero/screens/alero/dashboard/revenue_trend.dart';
import 'package:flutter/material.dart';
import '../dashboard/data_completeness_chart.dart';
import '../dashboard/data_validity_chart.dart';
import '../dashboard/loans_trend.dart';
import 'LoansClassification.dart';
import 'customer_channels_usage.dart';
import 'loans_overdue.dart';

class ViewCustomerDashboardGraphs extends StatefulWidget {
  @override
  _ViewCustomerDashboardGraphsState createState() => _ViewCustomerDashboardGraphsState();
}

class _ViewCustomerDashboardGraphsState extends State<ViewCustomerDashboardGraphs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RevenueTrend(),
          CustomerChannelsUsage(),
          DepositsTrendChart(),
          LoansTrend(),
          LoansClassificationChart(),
          LoansOverdue(),
          DataCompleteness(),
          DataValidity(),
        ],
      ),
    );
  }
}

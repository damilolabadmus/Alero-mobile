import 'package:alero/models/customer/BankRevenueData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/revenue_trend_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/revenue_trend_bloc/revenue_trend_bloc.dart';
import 'repository/revenue_trend_repository.dart';

class RevenueTrend extends StatefulWidget {
  @override
  _RevenueTrendState createState() => _RevenueTrendState();
}

class _RevenueTrendState extends State<RevenueTrend> {
  final formatCurrency = new NumberFormat.currency(symbol: '');
  late final RevenueTrendBloc bloc;

  @override
  void initState() {
    bloc = RevenueTrendBloc(repository: RevenueTrendRepository(apiService: AleroAPIService()))..getBankRevenueData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevenueTrendBloc, RevenueTrendState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => CircularProgressIndicator(),
          loaded: (data) => _buildRevenueTrend(data),
          error: (message) => Text('Error: $message'),
        );
      },
    );
  }

  _buildRevenueTrend(AggregateRevenueTrendData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Revenue Trend (N\'M) - YOY/12 Months',
                style: kTrendTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevenueItem(revenue: 'YTD Revenue', value: "${double.parse((data.ytdRevenue / kRevenueChartDivisor).toStringAsFixed(2))}b"),
                  RevenueItem(revenue: 'Assets', value: "${data.loansRevenue.toInt().toString()}%"),
                  RevenueItem(revenue: 'Liabilities', value: "${data.depositsRevenue.toInt().toString()}%"),
                  RevenueItem(revenue: 'Fees', value: "${data.commFeesRevenue.toInt().toString()}%"),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                child: RevenueTrendChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RevenueItem extends StatelessWidget {
  RevenueItem({this.revenue, this.value});

  final String? revenue;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        revenue!,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 12.0,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      Text(
        value.toString(),
        style: TextStyle(color: Colors.blueGrey.shade700),
      ),
    ]);
  }
}

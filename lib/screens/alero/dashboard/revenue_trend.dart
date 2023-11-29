import 'package:alero/models/customer/BankRevenueData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/revenue_trend_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class RevenueTrend extends StatefulWidget {

  @override
  _RevenueTrendState createState() => _RevenueTrendState();
}

class _RevenueTrendState extends State<RevenueTrend> {
  final formatCurrency = new NumberFormat.currency(symbol: '');
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankRevenueData> rtData = [];
  double ytdRevenue = 0.0;
  double loansRevenue = 0.0;
  double depositsRevenue = 0;
  double commFeesRevenue = 0;

  @override
  void initState() {
    getBankRevenueData();
    super.initState();
  }

  Future getBankRevenueData() async {
    return this._asyncMemoizer.runOnce(() async {
      var revenue = await apiService.getBankRevenue();

      rtData = [];
      if (revenue.length == 0) {
        rtData.add(BankRevenueData(
          ytdRevenue: 0.0,
          loansRevenue: 0.0,
          depositsRevenue: 0,
          commFeesRevenue: 0,
        ));
      } else {
        revenue.forEach((revenueTrend) {
          rtData.add(BankRevenueData(
            ytdRevenue: revenueTrend["ytdRevenue"],
            loansRevenue: revenueTrend["loansRevenue"],
            depositsRevenue: revenueTrend["depositsRevenue"],
            commFeesRevenue: revenueTrend["commFeesRevenue"],
          ));
        });
      }

      setState(() {
        for (int i = 0; i < rtData.length; i++) {
          ytdRevenue = ytdRevenue + rtData[i].ytdRevenue;
          loansRevenue = loansRevenue + rtData[i].loansRevenue;
          depositsRevenue = depositsRevenue + rtData[i].depositsRevenue;
          commFeesRevenue = commFeesRevenue + rtData[i].commFeesRevenue;
        }
      });
      return revenue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Revenue Trend (N\'M) - YOY/12 Months',
                style: kTrendTextStyle.copyWith(
                    fontSize: 16),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevenueItem(revenue: 'YTD Revenue',
                      value: "${double. parse((ytdRevenue/kRevenueChartDivisor).toStringAsFixed(2))}b"),
                  RevenueItem(revenue: 'Assets', value: "${loansRevenue.toInt().toString()}%"),
                  RevenueItem(revenue: 'Liabilities', value: "${depositsRevenue.toInt().toString()}%"),
                  RevenueItem(revenue: 'Fees', value: "${commFeesRevenue.toInt().toString()}%"),
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

  final String revenue;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(revenue,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontFamily: 'Poppins-Regular',
            ),),
          Text(value.toString(), style: TextStyle(
              color: Colors.blueGrey.shade700
          ),),
        ]
    );
  }
}


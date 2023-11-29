import 'package:alero/models/customer/BankDepositsData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/deposits_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';


class DepositsTrendChart extends StatefulWidget {

  @override
  _DepositsTrendChartState createState() => _DepositsTrendChartState();
}

class _DepositsTrendChartState extends State<DepositsTrendChart> {

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankDepositsData> dtData = [];
  double actualDeposits = 0.0;
  double actualDepositsChange = 0.0;
  double averageDeposits = 0.0;
  double averageDepositsChange = 0.0;
  List<BankDepositsData> bankDeposit;

  @override
  void initState() {
    getDepositsTrendData();
    super.initState();
  }

  final List<Color> gradientColors = [
    Style.Colors.fourthColor,
    Style.Colors.fourthColor,
  ];

  getDepositsTrendData() async {
    return this._asyncMemoizer.runOnce(() async {
      var deposits = await apiService.getBankDeposits();
      dtData = [];
      if (deposits.length == 0) {
        dtData.add(BankDepositsData(
          actualDeposits: 0.0,
          actualDepositsChange: 0.0,
          averageDeposits: 0.0,
          averageDepositsChange: 0.0,));
      } else {
        deposits.forEach((trend) {
          dtData.add(BankDepositsData(
              actualDeposits: trend["actualDeposits"],
              actualDepositsChange: trend["actualDepositsChange"],
              averageDeposits: trend["averageDeposits"],
              averageDepositsChange: trend["averageDepositsChange"]));
        });
      }
      setState(() {
        for (int i = 0; i < dtData.length; i++) {
          actualDeposits= actualDeposits + dtData[i].actualDeposits;
          averageDeposits = averageDeposits + dtData[i].averageDeposits;
          actualDepositsChange = actualDepositsChange + dtData[i].actualDepositsChange;
          averageDepositsChange = averageDepositsChange + dtData[i].averageDepositsChange;
        }
        return deposits;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/customer/trends/trends_empty_pie.svg',
            ),
          );
        }
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
                        Text('Deposits Trend (N\'M) - YOY/12 Months',
                          style: kTrendTextStyle.copyWith(
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DepositsItem(depositLine1: 'Actual', depositLine2: 'Deposit', value: "${double. parse((actualDeposits/kDepositsDivisor).toStringAsFixed(2))}tr"),
                            DepositsItem(depositLine1: ' ', depositLine2: 'DoD', value: actualDepositsChange.toString()),
                            DepositsItem(depositLine1: 'Average', depositLine2: 'Deposit', value: "${double. parse((averageDeposits/kDepositsDivisor).toStringAsFixed(2))}tr"),
                            DepositsItem(depositLine1: ' ', depositLine2: 'DoD', value: averageDepositsChange.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                          child: DepositsChart(),
                        ),]
                  ),
                )
            )
        );
      },
    );
  }
}

class DepositsItem extends StatelessWidget {
  DepositsItem({this.depositLine1, this.depositLine2, this.value});

  final String depositLine1;
  final String depositLine2;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(depositLine1,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontFamily: 'Poppins-Regular',
            ),),
          Text(depositLine2,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.blueGrey,
              fontFamily: 'Poppins-Regular',
            ),),
          SizedBox(height: 5.0),
          Text(value, style: TextStyle(
              color: Colors.blueGrey.shade700
          ),),
        ]
    );
  }
}

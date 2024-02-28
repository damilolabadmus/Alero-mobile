

import 'package:alero/models/customer/BankDepositsData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class DepositsChart extends StatefulWidget {
  @override
  _DepositsChartState createState() => _DepositsChartState();
}

class _DepositsChartState extends State<DepositsChart> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankDepositsData?> dtcData = [];
  int divisor = 1000000000000;
  String periodName = '';
  double depositsData = 0.0;
  List<BankDepositsData?>? bankDeposits;

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
      var test = await apiService.getBankDepositsChart();
      setState(() {
        bankDeposits = test as List<BankDepositsData?>?;
        dtcData = [];
        if (bankDeposits!.length == 0) {
          dtcData.add(BankDepositsData(
            periodName: '',
            depositsData: 0.0,
          ));
        } else {
          bankDeposits!.forEach((trend) {
            dtcData.add(trend);
          });
        }
        for (int i = 0; i < dtcData.length; i++) {
          periodName = periodName + dtcData[i]!.periodName!;
          depositsData = depositsData + dtcData[i]!.depositsData!;
        }
      });
      return bankDeposits;
    });
  }

  @override
  Widget build(BuildContext context) {
    int bankDepositsIndex = 0;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null || snapshot.connectionState == ConnectionState.waiting) {
          return Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/customer/trends/trends_empty_pie.svg',
            ),
          );
        }
        return Container(
          height: 230,
          width: 400,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: bankDeposits!.length.toDouble() - 1,
              minY: 1.05,
              maxY: 2.2,
              titlesData: FlTitlesData(
                show: yes,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                        child: Text(
                          bankDeposits![value.toInt()]!.periodName.toString(),
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.0,
                          ),
                        ),
                        angle: kRotateAngle,
                        axisSide: AxisSide.bottom,
                        fitInside: SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 10.0),
                        ),
                    // rotateAngle: kRotateAngle,
                    showTitles: yes,
                    // getTextStyles: (value) => TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 9.0),
                    // getTitles: (value) {
                    //   return bankDeposits[value.toInt()].periodName.toString();
                    // },
                    // margin: 10.0,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              gridData: FlGridData(
                show: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              lineTouchData: LineTouchData(
                enabled: false,
                touchTooltipData: LineTouchTooltipData(
                  tooltipRoundedRadius: 5,
                  tooltipBgColor: Colors.black,
                  tooltipPadding: EdgeInsets.all(10.0),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: bankDeposits!.map((bankDep) => FlSpot((bankDepositsIndex++).toDouble(), bankDep!.depositsData! / divisor)).toList(),
                  isCurved: yes,
                  color: gradientColors.first,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: yes,
                    color: gradientColors.first.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      future: getDepositsTrendData(),
    );
  }
}

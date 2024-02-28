

import 'package:alero/models/customer/BankLoanData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class LoansTrendChart extends StatefulWidget {
  @override
  _LoansTrendChartState createState() => _LoansTrendChartState();
}

class _LoansTrendChartState extends State<LoansTrendChart> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankLoanData?> ltcData = [];
  String periodName = '';
  double loansData = 0.0;
  List<BankLoanData?>? bankLoan;

  @override
  initState() {
    getBankLoanChart();
    super.initState();
  }

  getBankLoanChart() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getBankLoanChart();
      setState(() {
        bankLoan = test as List<BankLoanData?>?;
        ltcData = [];
        if (bankLoan!.length == 0) {
          ltcData.add(BankLoanData(
            periodName: '',
            loansData: 0.0,
          ));
        } else {
          bankLoan!.forEach((revenueTrend) {
            ltcData.add(revenueTrend);
          });
        }
        for (int i = 0; i < ltcData.length; i++) {
          periodName = periodName + ltcData[i]!.periodName!;
          loansData = loansData + ltcData[i]!.loansData!;
        }
      });
      return bankLoan;
    });
  }

  final List<Color> gradientColors = [
    Style.Colors.thirdColor,
    Style.Colors.thirdColor,
  ];

  @override
  Widget build(BuildContext context) {
    int bankLoanIndex = 0;
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
              maxX: bankLoan!.length.toDouble() - 1,
              minY: 6.8,
              maxY: 16,
              titlesData: FlTitlesData(
                show: yes,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      angle: kRotateAngle,
                      child: Text(
                        bankLoan![value.toInt()]!.periodName.toString(),
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.0,
                        ),
                      ),
                      axisSide: AxisSide.bottom,
                      fitInside: SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 10.0),
                    ),
                    showTitles: yes,
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
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: bankLoan!.map((bankLn) => FlSpot((bankLoanIndex++).toDouble(), bankLn!.loansData! / kLoansChartDivisor)).toList(),
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
      future: getBankLoanChart(),
    );
  }
}

import 'package:alero/models/customer/BankRevenueData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class RevenueTrendChart extends StatefulWidget {

  @override
  _RevenueTrendChartState createState() => _RevenueTrendChartState();
}
class _RevenueTrendChartState extends State<RevenueTrendChart> {

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankRevenueData> rtcData = [];
  String periodName = '';
  double revenueData = 0.0;
  List<BankRevenueData> bankRevenue;
  final List<Color> gradientColors = [
    Style.Colors.fourthColor,
    Style.Colors.fourthColor,
  ];


  @override
  initState() {
    getBankRevChart();
    super.initState();
  }

  getBankRevChart() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getBankRevenueChart();
      setState(() {
        bankRevenue = test;
        rtcData = [];
        if (bankRevenue.length == 0) {
          rtcData.add(BankRevenueData(
            periodName: '',
            revenueData: 0.0,
          ));
        } else {
          bankRevenue.forEach((revenueTrend) {
            rtcData.add(revenueTrend);
          });
        }
        for (int i = 0; i < rtcData.length; i++) {
          periodName = periodName + rtcData[i].periodName;
          revenueData = revenueData + rtcData[i].revenueData;
        }
      });
      return bankRevenue;
    });
  }

  @override
  Widget build(BuildContext context) {
    int bankRevenueindex = 0;
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
        return Container(
          height: 250,
          width: 400,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 12,
              minY: -1.5,
              maxY: 2.1,

              /*minX: 0,
              maxX: 12,
              minY: 0,
              maxY: 1.4,*/
              titlesData: FlTitlesData(
                show: yes,
                bottomTitles: SideTitles(
                  rotateAngle: kRotateAngle,
                  showTitles: yes,
                  getTextStyles: (value) => kRevTitlesTextStyle,
                  getTitles: (value) {
                    return bankRevenue[value.toInt()].periodName.toString();
                  },
                  margin: 10.0,
                ),
                topTitles: SideTitles(
                  showTitles: false,
                ),
                leftTitles: SideTitles(
                  showTitles: false,
                ),
                rightTitles: SideTitles(
                  showTitles: false,
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
                  spots: bankRevenue.map((bankRev) => FlSpot((bankRevenueindex++).toDouble(),
                      bankRev.revenueData >= 100000000000 ?
                      bankRev.revenueData/kDepositsDivisor : bankRev.revenueData/kRevenueChartDivisor
                  )).toList(),
                  /*spots: bankRevenue.map((bankRev) => FlSpot((bankRevenueindex++).toDouble(),
                      bankRev.revenueData/kRevenueChartDivisor)).toList(),*/
                  isCurved: yes,
                  colors: gradientColors,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: yes,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.1))
                        .toList(),
                  ),
                  // dotData: FlDotData(show: true),
                ),
              ],),
          ),
        );
      },
      future: getBankRevChart(),
    );
  }
}

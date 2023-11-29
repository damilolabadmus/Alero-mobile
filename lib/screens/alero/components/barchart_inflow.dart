import 'package:alero/models/customer/TransactionFlow.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class BarChartInflow extends StatefulWidget {
  final List<TransactionFlow> tfData;

  const BarChartInflow({Key key, @required this.tfData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartInflowState();
}

class BarChartInflowState extends State<BarChartInflow> {
  int touchedIndex;

  final Color barBackgroundColor = const Color(0xff72d8bf);
  List<BarChartGroupData> flowBars = [];

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> _flowBars = [];
    for (var i = 0; i < widget.tfData.length; i++) {
      _flowBars.add(makeGroupData(
          i, widget.tfData[i].transactionCount.toDouble(),
          isTouched: i == touchedIndex));
    }
    if (mounted) {
      setState(() {
        flowBars = _flowBars;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.white,
          child: loadBarchatData()),
    );
  }

  Widget loadBarchatData() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 26,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.red,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipBottomMargin: 8,
            getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
                ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          touchCallback: (barTouchResponse) {
            if (mounted) {
              setState(() {
                if (barTouchResponse.spot != null &&
                    barTouchResponse.touchInput is! FlPanEnd &&
                    barTouchResponse.touchInput is! FlLongPressEnd) {
                  touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
                } else {
                  touchedIndex = -1;
                }
              });
            }
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 6),
            margin: 4,
            getTitles: (double value) {
              for (var i = 0; i < widget.tfData.length; i++) {
                if (value.toInt() == i) {
                  return widget.tfData[i].transactionDate.substring(0, 3);
                }
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: flowBars,
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.blue,
        double width = 5,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.red] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Style.Colors.trendsGraphGrey],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}

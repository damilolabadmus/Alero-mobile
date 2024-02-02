

import 'package:alero/models/customer/TransactionFlow.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../style/theme.dart' as Style;

class LineChartInflowOutFlow extends StatefulWidget {
  final List<TransactionFlow> tfData;
  final Color color;

  const LineChartInflowOutFlow(
      {Key? key, required this.tfData, required this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartInflowOutFlowState();
}

class LineChartInflowOutFlowState extends State<LineChartInflowOutFlow> {
  List<TransactionFlow>? flowChart;

  @override
  void initState() {
    super.initState();
  }

  final List<Color> gradientColors = [
    Style.Colors.fourthColor,
    Style.Colors.fourthColor,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: loadLineChart(),
          )),
    );
  }

  Widget loadLineChart() {
    return Center(
        child: Container(
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelRotation: kRotateAngle.toInt(), labelStyle: TextStyle(fontSize: 8)
                ),
                primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.compactCurrency(
                        decimalDigits: 1, symbol: "₦")),
                tooltipBehavior: TooltipBehavior(enable: true, header: 'Amount'),
                series: <LineSeries<TransactionFlow, String>>[
                  LineSeries<TransactionFlow, String>(
                    dataSource: widget.tfData,
                    xValueMapper: (TransactionFlow tFlow, _) => tFlow.transactionDate/*.substring(0, 3)*/,
                    yValueMapper: (TransactionFlow tFlow, _) => tFlow.totalSpend,
                    color: widget.color,
                  )
                ])));
  }
}

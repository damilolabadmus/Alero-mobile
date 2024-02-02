

import 'package:alero/models/customer/ComplaintFLow.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartComplaints extends StatefulWidget {
  final List<ComplaintFlow> cfData;
  final Color color;

  const LineChartComplaints(
      {Key? key, required this.cfData, required this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartComplaintsState();
}

class LineChartComplaintsState extends State<LineChartComplaints> {
  int? touchedIndex;

  final Color barBackgroundColor = const Color(0xff72d8bf);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.white,
          child: loadLineChart()),
    );
  }

  Widget loadLineChart() {
    return Center(
        child: Container(
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <LineSeries<ComplaintFlow, String>>[
                  LineSeries<ComplaintFlow, String>(
                    dataSource: widget.cfData,
                    xValueMapper: (ComplaintFlow cFlow, _) => cFlow.periodName,
                    yValueMapper: (ComplaintFlow cFlow, _) => cFlow.complaintCount,
                    color: widget.color,
                  )
                ])));
  }
}

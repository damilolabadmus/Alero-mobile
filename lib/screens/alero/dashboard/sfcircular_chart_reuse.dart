

import 'package:alero/models/customer/CompletenessAndValidityData.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;

class CircularChart extends StatefulWidget {

  const CircularChart({Key? key,
    required this.titleText,
    required this.dataSource,
    required this.xValueMapper,
    required this.yValueMapper,
    required this.tooltipBehavior,

  }) : super(key: key);

  final String titleText;
  final List dataSource;
  final Function xValueMapper;
  final Function yValueMapper;
  final TooltipBehavior tooltipBehavior;

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior;

    return SfCircularChart(
      title: ChartTitle(
        text: widget.titleText,
        textStyle: kLoansTextStyle.copyWith(
          color: Style.Colors.chartTitleColor,
        ),
        alignment: ChartAlignment.near,
      ),
      legend: Legend(position: LegendPosition.right,
        textStyle: kLegendTextStyle.copyWith(fontSize: 10),
        isVisible: yes,
        itemPadding: 2.0,
        padding: kPadding1,
        iconHeight: 5,
        iconWidth: 12,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: widget.tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<CompletenessAndValidityData, String>(
          legendIconType: LegendIconType.verticalLine,
          radius: kAngle,
          dataSource: widget.dataSource as List<CompletenessAndValidityData>?,
          xValueMapper: widget.xValueMapper as String? Function(CompletenessAndValidityData, int),
          yValueMapper: widget.yValueMapper as num? Function(CompletenessAndValidityData, int),
          strokeColor: Colors.white,
          strokeWidth: kPadding1,
          enableTooltip: yes,
        ),
      ],);
  }
}

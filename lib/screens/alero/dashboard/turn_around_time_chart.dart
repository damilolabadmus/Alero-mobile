import 'package:alero/models/call/TurnaroundTimeCompletedResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;

class TurnAroundTimeChart extends StatefulWidget {
  const TurnAroundTimeChart({Key key}) : super(key: key);

  @override
  _TurnAroundTimeChartState createState() => _TurnAroundTimeChartState();
}

class _TurnAroundTimeChartState extends State<TurnAroundTimeChart> {
  TooltipBehavior _tooltipBehavior;
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  int count = 0;
  String turnAroundTime = '';
  List<TurnAroundTimeResponse> tat;

  @override
  void initState() {
    super.initState();
    getTurnAroundTime();
    _tooltipBehavior = TooltipBehavior(enable: true, header: "Turnaround Time");
  }

  getTurnAroundTime() async {
    var test = await apiService.getTurnAroundTimeChart();
    tat = test as List<TurnAroundTimeResponse>;
    return tat;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot)
      {
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Container(
            height: 400,
            width: 400,
            color: Colors.white,
            child: SfCartesianChart(
              title: ChartTitle(
                text: 'Turnaround Time (Completed Report)', textStyle: kTrendTextStyle.copyWith(
                fontSize: 16,),
                alignment: ChartAlignment.near,),
              primaryXAxis: CategoryAxis(
                  labelRotation: 300,
                  labelStyle: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600)),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                StackedColumnSeries<TurnAroundTimeResponse, String>(
                  dataSource: tat,
                  xValueMapper: (TurnAroundTimeResponse data, _) => data.turnAroundTime,
                  yValueMapper: (TurnAroundTimeResponse data, _) => data.count,
                  enableTooltip: yes,
                ),],),
          ),);
      },future: getTurnAroundTime(),
    );
  }
}


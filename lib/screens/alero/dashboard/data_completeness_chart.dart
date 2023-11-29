import 'package:alero/models/customer/CompletenessAndValidityData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class DataCompleteness extends StatefulWidget {

  @override
  _DataCompletenessState createState() => _DataCompletenessState();
}

class _DataCompletenessState extends State<DataCompleteness> {
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    getDataCompleteness();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<CompletenessAndValidityData> dcData = [];
  String workflowStatus = '';
  int incompleteDataCount = 0;
  List<CompletenessAndValidityData> dataComplete;


  getDataCompleteness() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getDataCompletenessAndValidity();
      setState(() {
        dataComplete = test;
        dcData = [];
        if (dataComplete.length == 0) {
          dcData.add(CompletenessAndValidityData(
            workflowStatus: '',
            incompleteDataCount: 0,
          ));
        } else {
          dataComplete.forEach((status) {
            dcData.add(status);
          });
        }
        for (int i = 0; i < dcData.length; i++) {
          workflowStatus = workflowStatus + dcData[i].workflowStatus;
          incompleteDataCount = incompleteDataCount + dcData[i].incompleteDataCount;
        }
      });
      return dataComplete;
    });
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
            child: SvgPicture.asset('assets/customer/trends/trends_empty_pie.svg'),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Card(
            elevation: 5.0,
            child: Container(
              height: 270,
              width: 400,
              color: Colors.white,
              child: SfCircularChart(
                title: ChartTitle(
                  text: 'Data Completeness', textStyle: kLoansTextStyle.copyWith(
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
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<CompletenessAndValidityData, String>(
                    legendIconType: LegendIconType.verticalLine,
                    radius: kAngle,
                    dataSource: dataComplete,
                    xValueMapper: (CompletenessAndValidityData data, _) =>
                    data.workflowStatus,
                    yValueMapper: (CompletenessAndValidityData data, _) =>
                    data.incompleteDataCount,
                    strokeColor: Colors.white,
                    strokeWidth: kPadding1,
                    enableTooltip: yes,
                  ),
                ],),
            ),
          ),
        );
      },
      future: getDataCompleteness(),
    );
  }
}
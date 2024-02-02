

import 'package:alero/models/customer/CompletenessAndValidityData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class DataValidity extends StatefulWidget {

  @override
  _DataValidityState createState() => _DataValidityState();
}

class _DataValidityState extends State<DataValidity> {

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    getDataValidity();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<CompletenessAndValidityData?> dvData = [];
  String workflowStatus = '';
  int invalidDataCount = 0;
  List<CompletenessAndValidityData?>? dataValid;


  getDataValidity() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getDataCompletenessAndValidity();
      setState(() {
        dataValid = test as List<CompletenessAndValidityData?>?;
        dvData = [];
        if (dataValid!.length == 0) {
          dvData.add(CompletenessAndValidityData(
            workflowStatus: '',
            incompleteDataCount: 0,
          ));
        } else {
          dataValid!.forEach((status) {
            dvData.add(status);
          });
        }

        for (int i = 0; i < dvData.length; i++) {
          workflowStatus = workflowStatus + dvData[i]!.workflowStatus!;
          invalidDataCount = invalidDataCount + dvData[i]!.invalidDataCount!;
        }
      });
      return dataValid;
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
            child: SvgPicture.asset(
              'assets/customer/trends/trends_empty_pie.svg',
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Card(
            elevation: 5.0,
            child: Container(
              color: Colors.white,
              height: 270,
              width: 400,
              child: SfCircularChart(
                title: ChartTitle(text: 'Data Validity', textStyle: kLoansTextStyle.copyWith(
                  color: Style.Colors.chartTitleColor,
                ),
                  alignment: ChartAlignment.near,
                ),
                legend: Legend(
                  position: LegendPosition.right,
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
                  DoughnutSeries<CompletenessAndValidityData?, String>(
                    legendIconType: LegendIconType.verticalLine,
                    radius: kAngle,
                    dataSource: dataValid,
                    xValueMapper: (CompletenessAndValidityData? data, _) =>
                    data!.workflowStatus,
                    yValueMapper: (CompletenessAndValidityData? data, _) =>
                    data!.invalidDataCount,
                    strokeColor: Colors.white,
                    strokeWidth: 2.0,
                    enableTooltip: yes,
                  ),
                ],),
            ),
          ),
        );
      },
      future: getDataValidity(),
    );
  }
}
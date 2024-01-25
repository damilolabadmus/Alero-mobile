import 'package:flutter/material.dart';
import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class LoansClassificationVolumeChart extends StatefulWidget {

  @override
  State<LoansClassificationVolumeChart> createState() => _LoansClassificationVolumeChartState();
}

class _LoansClassificationVolumeChartState extends State<LoansClassificationVolumeChart> {
  TooltipBehavior _tooltipBehavior;

  var apiService = AleroAPIService();
  List<LoanClassificationStatus> lcData = [];
  String loanStatus = '';
  int loanStatusCount = 0;
  List<LoanClassificationStatus> loanClassification;

  @override
  void initState() {
    getLoansClassificationStatus();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Classification');
    super.initState();
  }

  getLoansClassificationStatus() async {
    var test = await apiService.getLoanClassificationStatus();
    loanClassification = test as List<LoanClassificationStatus>;
    return loanClassification;
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
        return Container(
          height: 300,
          width: 400,
          color: Colors.white,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(labelRotation: 300, labelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
            tooltipBehavior: _tooltipBehavior,
            primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
            series: <CartesianSeries>[
              StackedColumnSeries<LoanClassificationStatus, String>(
                dataSource: loanClassification,
                xValueMapper: (LoanClassificationStatus data, _) => data.loanStatus,
                yValueMapper: (LoanClassificationStatus data, _) => data.loanStatusCount,
                enableTooltip: yes,
              ),],),
        );
      }, future: getLoansClassificationStatus(),
    );
  }
}








/*
/// Before updating
import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class LoansClassification extends StatefulWidget {

  @override
  _LoansClassificationState createState() => _LoansClassificationState();
}

class _LoansClassificationState extends State<LoansClassification> {
  TooltipBehavior _tooltipBehavior;

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<LoanClassificationStatus> lcData = [];
  String loanStatus = '';
  int loanStatusCount = 0;
  List<LoanClassificationStatus> loanClassification;

  @override
  void initState() {
    getLoansClassificationStatus();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }


  getLoansClassificationStatus() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getLoanClassificationStatus();
      setState(() {
        loanClassification = test;
       lcData = [];
      if (loanClassification.length == 0) {
        lcData.add(LoanClassificationStatus(
          loanStatus: '',
          loanStatusCount: 0,
        ));
      } else {
        loanClassification.forEach((status) {
          lcData.add(status);
        });
      }

      for (int i = 0; i < lcData.length; i++) {
        loanStatus = loanStatus + lcData[i].loanStatus;
        loanStatusCount = loanStatusCount + lcData[i].loanStatusCount;
        print(loanStatusCount);
      }
      });
      return loanClassification;
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
        height: 270,
        width: 400,
        color: Colors.white,
        child: SfCircularChart(
          title: ChartTitle(
            text: 'Loans Classification',
            textStyle: kLoansTextStyle.copyWith(
               color: Style.Colors.chartTitleColor,
          ),
            alignment: ChartAlignment.near,
          ),
          legend: Legend(position: LegendPosition.right,
            textStyle: kLegendTextStyle,
            isVisible: yes,
            itemPadding: 2.0,
            padding: kPadding1,
            iconHeight: 5,
            iconWidth: 12,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<LoanClassificationStatus, String>(
              strokeColor: Colors.white,
              strokeWidth: kPadding1,
              legendIconType: LegendIconType.verticalLine,
              radius: kAngle,
              dataSource: loanClassification,
              xValueMapper: (LoanClassificationStatus data, _) =>
              data.loanStatus,
              yValueMapper: (LoanClassificationStatus data, _) =>
              data.loanStatusCount,
              enableTooltip: yes,
            ),
          ],),
      ),
    ),
      );
    }, future: getLoansClassificationStatus(),
    );
  }
}
*/

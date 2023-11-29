import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class LoansClassificationValueChart extends StatefulWidget {

  @override
  State<LoansClassificationValueChart> createState() => _LoansClassificationValueChartState();
}

class _LoansClassificationValueChartState extends State<LoansClassificationValueChart> {
  TooltipBehavior _tooltipBehavior;
  var apiService = AleroAPIService();
  List<LoanClassificationStatus> lcData = [];
  String loanStatus = '';
  int loanStatusAmount = 0;
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
            series: <ChartSeries>[
              StackedColumnSeries<LoanClassificationStatus, String>(
                dataSource: loanClassification,
                xValueMapper: (LoanClassificationStatus data, _) => data.loanStatus,
                yValueMapper: (LoanClassificationStatus data, _) => data.loanStatusAmount,
                enableTooltip: yes,
              ),],),
        );
      }, future: getLoansClassificationStatus(),
    );
  }
}

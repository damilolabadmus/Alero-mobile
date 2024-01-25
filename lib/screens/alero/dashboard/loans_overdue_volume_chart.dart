import 'package:alero/models/customer/BankLoanData.dart';
import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class LoansOverdueVolumeChart extends StatefulWidget {

  @override
  _LoansOverdueVolumeChartState createState() => _LoansOverdueVolumeChartState();
}

class _LoansOverdueVolumeChartState extends State<LoansOverdueVolumeChart> {
  TooltipBehavior _tooltipBehavior;

  var apiService = AleroAPIService();
  List<LoanClassificationStatus> loData = [];
  String loanStatus = '';
  int loanStatusCount = 0;
  List<LoanClassificationStatus> loanOverdue;

  @override
  void initState() {
    getLoansOverdueStatus();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Value');
    super.initState();
  }

  getLoansOverdueStatus() async {
    var test = await apiService.getLoanOverdue();
    loanOverdue = test as List<LoanClassificationStatus>;
    return loanOverdue;
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
            height: 300,
            width: 400,
            color: Colors.white,
            child: SfCartesianChart(
              title: ChartTitle(
                text: 'Loans Overdue (Days)', textStyle: kTrendTextStyle.copyWith(
                fontSize: 16,),
                alignment: ChartAlignment.near,),
              primaryXAxis: CategoryAxis(labelRotation: 300, labelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
              tooltipBehavior: _tooltipBehavior,
              primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
              series: <CartesianSeries>[
                StackedColumnSeries<LoanClassificationStatus, String>(
                  dataSource: loanOverdue,
                  xValueMapper: (LoanClassificationStatus data, _) => data.loanStatus,
                  yValueMapper: (LoanClassificationStatus data, _) => data.loanStatusCount,
                  enableTooltip: yes,
                ),],),
          ),);
      },
      future: getLoansOverdueStatus(),
    );
  }
}
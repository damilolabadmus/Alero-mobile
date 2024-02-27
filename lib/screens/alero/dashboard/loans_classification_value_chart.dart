import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'bloc/loans_classification_bloc/loans_classification_bloc.dart';

class LoansClassificationValueChart extends StatefulWidget {
  @override
  State<LoansClassificationValueChart> createState() => _LoansClassificationValueChartState();
}

class _LoansClassificationValueChartState extends State<LoansClassificationValueChart> {
  late final LoanClassificationStatusBloc bloc;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    bloc = LoanClassificationStatusBloc(AleroAPIService())..getLoansClassificationStatus();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Classification');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanClassificationStatusBloc, LoanClassificationStatusState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          loading: _buildEmptyOrLoading,
          loaded: (data) {
            if (data.isEmpty) {
              return _buildEmptyOrLoading();
            }
            return _buildLoansClassificationChart(data);
          },
          error: (message) => Text(message),
        );
      },
    );
  }

  Widget _buildEmptyOrLoading() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/customer/trends/trends_empty_pie.svg',
      ),
    );
  }

  Widget _buildLoansClassificationChart(List<LoanClassificationStatus> data) {
    return Container(
      height: 300,
      width: 400,
      color: Colors.white,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(labelRotation: 300, labelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
        tooltipBehavior: TooltipBehavior(enable: true, header: 'Classification'),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
        series: <CartesianSeries>[
          StackedColumnSeries<LoanClassificationStatus, String>(
            dataSource: data,
            xValueMapper: (LoanClassificationStatus data, _) => data.loanStatus,
            yValueMapper: (LoanClassificationStatus data, _) => data.loanStatusAmount,
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}

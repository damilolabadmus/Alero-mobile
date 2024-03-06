import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'bloc/loans_overdue_bloc/loans_overdue_bloc.dart';

class LoansOverdueVolumeChart extends StatefulWidget {
  @override
  _LoansOverdueVolumeChartState createState() => _LoansOverdueVolumeChartState();
}

class _LoansOverdueVolumeChartState extends State<LoansOverdueVolumeChart> {
  late final LoanOverdueBloc bloc;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    bloc = LoanOverdueBloc(AleroAPIService())..getLoansOverdue();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Value');
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanOverdueBloc, LoanOverdueState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          loading: _buildEmptyOrLoading,
          loaded: (data) {
            if (data?.isEmpty ?? true) {
              return _buildEmptyOrLoading();
            }
            return _buildChart(data);
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

  Widget _buildChart(List<LoanClassificationStatus?>? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Container(
        height: 300,
        width: 400,
        color: Colors.white,
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Loans Overdue (Days)',
            textStyle: kTrendTextStyle.copyWith(
              fontSize: 16,
            ),
            alignment: ChartAlignment.near,
          ),
          primaryXAxis: CategoryAxis(labelRotation: 300, labelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
          tooltipBehavior: _tooltipBehavior,
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          series: <CartesianSeries>[
            StackedColumnSeries<LoanClassificationStatus?, String>(
              dataSource: data ?? [],
              xValueMapper: (LoanClassificationStatus? data, _) => data!.loanStatus,
              yValueMapper: (LoanClassificationStatus? data, _) => data!.loanStatusCount,
              enableTooltip: yes,
            ),
          ],
        ),
      ),
    );
  }
}

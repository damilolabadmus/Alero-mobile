import 'package:alero/models/customer/CompletenessAndValidityData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/bloc/data_completeness_bloc/data_completeness_bloc.dart';
import 'package:alero/screens/alero/dashboard/repository/data_completeness_and_validity_repository.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;

class DataCompleteness extends StatefulWidget {
  @override
  _DataCompletenessState createState() => _DataCompletenessState();
}

class _DataCompletenessState extends State<DataCompleteness> {
  late final DataCompletenessBloc bloc;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    bloc = DataCompletenessBloc(repository: DataCompletenessAndValidityRepository(apiService: AleroAPIService()))..getDataCompletenessData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCompletenessBloc, DataCompletenessState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: _buildEmptyOrLoading,
          loaded: (data) {
            if (data.isEmpty) {
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

  Widget _buildChart(List<CompletenessAndValidityData?> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          height: 270,
          width: 400,
          child: SfCircularChart(
            title: ChartTitle(
              text: 'Data Completeness',
              textStyle: kLoansTextStyle.copyWith(
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
                dataSource: data,
                xValueMapper: (CompletenessAndValidityData? data, _) => data!.workflowStatus,
                yValueMapper: (CompletenessAndValidityData? data, _) => data!.incompleteDataCount,
                strokeColor: Colors.white,
                strokeWidth: 2.0,
                enableTooltip: yes,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

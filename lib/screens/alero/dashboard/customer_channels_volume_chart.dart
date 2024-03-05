import 'package:alero/models/customer/TouchPointData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/bloc/customer_channels_usage_bloc/customer_channels_usage_bloc.dart';
import 'package:alero/screens/alero/dashboard/repository/customer_channels_usage_repository.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CustomerChannelsUsageVolumeChart extends StatefulWidget {
  @override
  _CustomerChannelsUsageVolumeChartState createState() => _CustomerChannelsUsageVolumeChartState();
}

class _CustomerChannelsUsageVolumeChartState extends State<CustomerChannelsUsageVolumeChart> {
  late final CustomerChannelsUsageBloc bloc;
  TooltipBehavior? _tooltipBehavior;

  @override
  initState() {
    bloc = CustomerChannelsUsageBloc(CustomerChannelsUsageRepository(apiService: AleroAPIService()))..fetch();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Channel');
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerChannelsUsageBloc, CustomerChannelsUsageState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => _buildLoadingOrEmpty(),
          loaded: (channels) => _buildChart(channels),
          error: (message) => Text(message),
        );
      },
    );
  }

  _buildLoadingOrEmpty() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/customer/trends/trends_empty_pie.svg',
      ),
    );
  }

  _buildChart(List<TouchPointData?>? channels) {
    if (channels?.isEmpty ?? true) {
      _buildLoadingOrEmpty();
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
          StackedColumnSeries<TouchPointData?, String>(
            dataSource: channels ?? [],
            xValueMapper: (TouchPointData? data, _) => data!.channel,
            yValueMapper: (TouchPointData? data, _) => data!.transactionChannelCount,
            enableTooltip: yes,
          ),
        ],
      ),
    );
  }
}
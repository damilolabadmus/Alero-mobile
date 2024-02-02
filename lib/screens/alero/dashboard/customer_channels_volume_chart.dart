

import 'package:alero/models/customer/TouchPointData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class CustomerChannelsUsageVolumeChart extends StatefulWidget {

  @override
  _CustomerChannelsUsageVolumeChartState createState() => _CustomerChannelsUsageVolumeChartState();
}

class _CustomerChannelsUsageVolumeChartState extends State<CustomerChannelsUsageVolumeChart> {
  TooltipBehavior? _tooltipBehavior;
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<TouchPointData?> ccData = [];
  String channel = '';
  double averageSpend = 0.0;
  double volumeSpend = 0.0;
  int transactionChannelCount = 0;
  List<TouchPointData?>? channels;
  int? index;

  @override
  initState()  {
    getCustomerChannelsUsage();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Channel');
    super.initState();
  }

  getCustomerChannelsUsage() async {
    return this._asyncMemoizer.runOnce(() async {
      var test= await apiService.getBankTouchPoint();
      setState(() {
        channels = test as List<TouchPointData?>?;
        ccData = [];
        if (channels!.length == 0) {
          ccData.add(TouchPointData(
            channel: '',
            averageSpend: 0.0,
            volumeSpend: 0.0,
            transactionChannelCount: 0,));
        } else {
          channels!.forEach((usage) {
            ccData.add(usage);
          });
        }
        for (int i = 0; i < ccData.length; i++) {
          channel = channel + ccData[i]!.channel!;
          averageSpend = averageSpend + ccData[i]!.averageSpend!;
          volumeSpend = volumeSpend + ccData[i]!.volumeSpend!;
          transactionChannelCount = transactionChannelCount + ccData[i]!.transactionChannelCount!;
        }
      });
      return channels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
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
            // primaryYAxis: NumericAxis(numberFormat: NumberFormat.compactCurrency(symbol: "₦")),
            primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
            series: <CartesianSeries>[
              StackedColumnSeries<TouchPointData?, String>(
                dataSource: channels ?? [],
                xValueMapper: (TouchPointData? data, _) => data!.channel,
                yValueMapper: (TouchPointData? data, _) => data!.transactionChannelCount,
                enableTooltip: yes,
              ),],),
        );
      },
      future: getCustomerChannelsUsage(),
    );
  }
}


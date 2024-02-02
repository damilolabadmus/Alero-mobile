

import 'package:alero/models/call/DealsByCurrencyResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';
class DealCurrencyChart extends StatefulWidget {

  @override
  _DealCurrencyChartState createState() => _DealCurrencyChartState();
}

class _DealCurrencyChartState extends State<DealCurrencyChart> {
  TooltipBehavior? _tooltipBehavior;

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<DealByCurrencyResponse> dcChart = [];
  String currency = '';
  int count = 0;
  List<DealByCurrencyResponse?>? currencies;

  @override
  void initState() {
    getDealCurrency();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Currency');
    super.initState();
  }

  getDealCurrency() async {
    return this._asyncMemoizer.runOnce(() async {
      var test = await apiService.getDealsByCurrencyChart();
      currencies = test as List<DealByCurrencyResponse?>;
      return currencies;
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Container(
            height: 270,
            width: 400,
            color: Colors.white,
            child: SfCircularChart(
              title: ChartTitle(
                text: 'Deals by Currency', textStyle: kTrendTextStyle.copyWith(
                fontSize: 16,
              ),
                alignment: ChartAlignment.near,
              ),
              legend: Legend(
                position: LegendPosition.right,
                textStyle: kLegendTextStyle.copyWith(fontWeight: FontWeight.w800),
                isVisible: yes,
                itemPadding: 2.0,
                padding: kPadding1,
                iconHeight: 10,
                iconWidth: 15,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                DoughnutSeries<DealByCurrencyResponse?, String>(
                  strokeColor: Colors.white,
                  strokeWidth: kPadding1,
                  legendIconType: LegendIconType.verticalLine,
                  radius: kAngle,
                  dataSource: currencies,
                  xValueMapper: (DealByCurrencyResponse? data, _) => data!.currency,
                  yValueMapper: (DealByCurrencyResponse? data, _) =>
                  data!.count,
                  enableTooltip: yes,
                ),],),
          ),
        );
      },
      future: getDealCurrency(),
    );
  }
}


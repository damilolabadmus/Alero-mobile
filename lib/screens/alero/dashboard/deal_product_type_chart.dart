

import 'package:alero/models/call/DealsByProductTypeResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../style/theme.dart' as Style;
import 'package:syncfusion_flutter_charts/charts.dart';

class DealProductTypeChart extends StatefulWidget {

  @override
  _DealProductTypeChartState createState() => _DealProductTypeChartState();
}

class _DealProductTypeChartState extends State<DealProductTypeChart> {
  TooltipBehavior? _tooltipBehavior;

  var apiService = AleroAPIService();
  List<DealByProductTypeResponse> ptData = [];
  int count = 0;
  String product = '';
  List<DealByProductTypeResponse?>? products;

  @override
  void initState() {
    super.initState();
    getDealsByProductType();
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'Product Type');
  }

  getDealsByProductType() async {
    var test = await apiService.getDealsByProductTypeChart();
    products = test as List<DealByProductTypeResponse?>;
    return products;
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
                text: 'Deals by Product Type', textStyle: kTrendTextStyle.copyWith(
                  fontSize: 16
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
                DoughnutSeries<DealByProductTypeResponse?, String>(
                  strokeColor: Colors.white,
                  strokeWidth: kPadding1,
                  legendIconType: LegendIconType.verticalLine,
                  radius: kAngle,
                  dataSource: products,
                  xValueMapper: (DealByProductTypeResponse? data, _) => data!.product,
                  yValueMapper: (DealByProductTypeResponse? data, _) => data!.count,
                  enableTooltip: yes,
                ),
              ],
            ),
          ),
        );
      },future: getDealsByProductType(),
    );
  }
}


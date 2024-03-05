

import 'dart:io';
import 'package:alero/models/customer/TrendTouchPointData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/Global.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'empty_list_item.dart';

class CustomerTouchPointBody extends StatefulWidget {
  final String? customerId, groupId, customerAccountNo;

  const CustomerTouchPointBody(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerTouchPointBodyState();
  }
}

class _CustomerTouchPointBodyState extends State<CustomerTouchPointBody> {
  TooltipBehavior? _tooltipBehavior;

  final ioc = new HttpClient();
  final Pandora pandora = new Pandora();
  String? prefToken;

  var preAuthHeaders = {
    "content-type": "application/json",
    "accept": "application/json",
    "AppId": Global.AppId,
    "DeviceIp": Global.DeviceIp,
    "DeviceManufacturer": Global.DeviceManufacturer,
    "DeviceName": Global.DeviceName,
    "DeviceModel": Global.DeviceModel,
    "DeviceType": Global.DeviceType
  };

  var postAuthHeaders = {
    "content-type": "application/json",
    "accept": "application/json",
    "Authorization": "Bearer " + Global.API_TOKEN!,
    "AppId": Global.AppId,
    "DeviceIp": Global.DeviceIp,
    "DeviceManufacturer": Global.DeviceManufacturer,
    "DeviceModel": Global.DeviceModel,
    "DeviceName": Global.DeviceName,
    "DeviceType": Global.DeviceType
  };

  bool isTouchPointValue = false;
  bool isTypeValue = false;
  var apiService = AleroAPIService();
  int? touchedIndex;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  List<TrendTouchPointData> tpData = [];
  List<Color> randomColors = [];
  List<Widget> indicators = [];

  bool loading = true;
  bool hasdata = false;

  List<TrendTouchPointData> debitType = [];
  List<TrendTouchPointData> creditType = [];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text('Touchpoint',
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/customer/dialog_close_button.svg',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Debit',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
              Switch(
                value: isTypeValue,
                onChanged: toggleTypeData,
                activeColor: Style.Colors.overviewActiveBg,
                activeTrackColor: Style.Colors.blackTextColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
              Text('Credit',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
            ],
          ),
          Divider(
            thickness: 1,
            color: Style.Colors.overviewActiveBg,
            endIndent: 255,
          ),
          Row(
            children: [
              Text('Volume',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
              Switch(
                value: isTouchPointValue,
                onChanged: toggleSpendData,
                activeColor: Style.Colors.overviewActiveBg,
                activeTrackColor: Style.Colors.blackTextColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
              Text('Value',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
            ],
          ),
          loadCountData(),
        ],
      ),
    );
  }

  void toggleSpendData(bool value) {
    if (mounted) {
      setState(() {
        isTouchPointValue = value;
        getTouchPoints(widget.groupId);
      });
    }
  }

  void toggleTypeData(bool value) {
    if (mounted) {
      setState(() {
        isTypeValue = value;
        creditType = tpData.where((item) => item.debitCreditIndicator == "CREDIT").toList();
      });
    }
  }

  Future getTouchPoints(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      var lifeStyle = widget.customerAccountNo == null ? await apiService
          .getTouchPointData(groupId!)
          : await apiService.getAccountTouchPointData(widget.customerAccountNo!);
      tpData = [];
      List<Widget> _indicators = [];
      if (lifeStyle.length == 0) {
        if (mounted) {
          setState(() {
            hasdata = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            hasdata = true;
          });
        }
        lifeStyle.forEach((counter) {
          tpData.add(TrendTouchPointData(
              transactionChannel: counter["transactionChannel"],
              debitCreditIndicator: counter["debitCreditIndicator"],
              transactionVolume: counter["transactionVolume"],
              touchPointCount: counter["touchPointCount"]));
        });
      }
      debitType = tpData.where((item) => item.debitCreditIndicator == "DEBIT").toList();
      if (mounted) {
        setState(() {
          indicators = _indicators;
        });
      }
      return lifeStyle;
    });
  }


  Widget loadCountData() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        if (hasdata) {
          return Expanded(
            child: SfCircularChart(
              legend: Legend(position: LegendPosition.bottom,
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
                DoughnutSeries<TrendTouchPointData, String>(
                  legendIconType: LegendIconType.verticalLine,
                  radius: kAngle,
                  dataSource: (!isTypeValue) ? debitType : creditType,
                  xValueMapper: (TrendTouchPointData data, _) =>
                  data.transactionChannel,
                  yValueMapper: (TrendTouchPointData data, _) => (!isTouchPointValue) ?
                  double.parse(data.transactionVolume!) : double.parse(data.touchPointCount!),
                  strokeColor: Colors.white,
                  strokeWidth: kPadding1,
                  enableTooltip: yes,
                ),
              ],),
          );
        } else {
          return EmptyListItem(
            message: 'No Customer Touch Points',
          );
        }
      },
      future: getTouchPoints(widget.groupId),
    );
  }
}

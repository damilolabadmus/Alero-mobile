

import 'package:alero/models/customer/TransactionFlow.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:intl/intl.dart';
import 'line_chart_inflow_outflow.dart';

class TransactionOutflowCard extends StatefulWidget {
  final String? customerId, groupId, customerAccountNo;

  const TransactionOutflowCard({Key? key, this.customerId, this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionOutflowCardState();
}

class TransactionOutflowCardState extends State<TransactionOutflowCard> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<TransactionFlow> tfData = [];
  double outflowAmount = 0.0;
  int transactionCount = 0;
  final formatCurrency = new NumberFormat.currency(symbol: "");
  String? startDate;
  String? endDate;

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    startDate = DateFormat('yyyyMM').format(DateTime.parse(initialDate.subtract(Duration(days: 366)).toString()));
    endDate = DateFormat('yyyyMM').format(DateTime.parse(initialDate.toString()));
    getOutflowData(widget.groupId, startDate, endDate);
  }

  Future getOutflowData(String? customerId, String? startDate, String? endDate) async {
    return this._asyncMemoizer.runOnce(() async {
      var flow = widget.customerAccountNo == null
          ? await apiService.getTransactionOutflow(widget.groupId!, startDate!, endDate!)
          : await apiService.getTransactionOutflowWithAccountNo(widget.customerAccountNo!, startDate!, endDate!);
      tfData = [];
      if (flow.length == 0) {
        tfData.add(TransactionFlow(
            transactionDate: "No Transactions",
            totalSpend: 0.0,
            averageSpend: 0.0,
            transactionCount: 0));
      } else {
        flow.forEach((transaction) {
          tfData.add(TransactionFlow(
              transactionDate: transaction["transactionDate"],
              totalSpend: transaction["totalSpend"],
              averageSpend: transaction["averageSpend"],
              transactionCount: transaction["transactionCount"]));
        });
      }

      for (int i = 0; i < tfData.length; i++) {
        outflowAmount = outflowAmount + tfData[i].totalSpend!;
        transactionCount =  transactionCount + tfData[i].transactionCount!;
      }
      return flow;
    });
  }

  @override
  Widget build(BuildContext context) {
    String initialStartDate = DateFormat('MMM, yyyy').format(DateTime.parse(initialDate.subtract(Duration(days: 366)).toString()));
    String initialEndDate = DateFormat('MMM, yyyy').format(DateTime.parse(initialDate.toString()));
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
        return Card(
            color: Colors.white,
            elevation: 1,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Outflow",
                                    style: TextStyle(
                                      color: Style.Colors.trendsGraphRed,
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins-Regular',
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "N " + formatCurrency.format(outflowAmount),
                                  style: TextStyle(
                                    color: Style.Colors.trendsTextBlack,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins-Bold',
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              transactionCount.toString(),
                              style: TextStyle(
                                color: Style.Colors.trendsTextBlack,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Bold',
                              )),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: LineChartInflowOutFlow(
                    tfData: tfData,
                    color: Colors.red,
                  ))
                ],
              ),
            ));
      },
      future: getOutflowData(widget.groupId, startDate, endDate),
    );
  }
}


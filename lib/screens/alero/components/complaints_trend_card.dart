

import 'package:alero/models/customer/ComplaintFLow.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/line_chart_complaints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class ComplaintsTrendCard extends StatefulWidget {
  final String? customerId, groupId;

  const ComplaintsTrendCard({Key? key, this.customerId, this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ComplaintsTrendCardState();
}

class ComplaintsTrendCardState extends State<ComplaintsTrendCard> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<ComplaintFlow> cfData = [];
  int totalComplaints = 0;

  @override
  void initState() {
    super.initState();
    getComplaintTrend(widget.groupId);
  }

  Future getComplaintTrend(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      var flow = await apiService.getCustomerComplaintTrend(groupId!);
      cfData = [];

      if (flow.length == 0) {
      } else {
        flow.forEach((transaction) {
          cfData.add(ComplaintFlow(
              periodName: transaction["periodName"],
              customerId: transaction["customerId"],
              periodCode: transaction["periodCode"],
              complaintCount: transaction["complaintCount"]));
        });
      }

      for (int i = 0; i < cfData.length; i++) {
        totalComplaints = totalComplaints + cfData[i].complaintCount!;
      }
      return flow;
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
                                Text("Complaints Trend",
                                    style: TextStyle(
                                      color: Style.Colors.trendsTextBlue,
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
                              child: Text(totalComplaints.toString(),
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
                        child: SvgPicture.asset(
                          'assets/customer/trends/trends_arrow_down.svg',
                        ),
                      ),
                    ],
                  ),
                  LineChartComplaints(cfData: cfData, color: Colors.blue),
                ],
              ),
            ));
      },
      future: getComplaintTrend(widget.groupId),
    );
  }
}

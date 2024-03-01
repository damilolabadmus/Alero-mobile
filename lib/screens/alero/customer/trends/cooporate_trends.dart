

import 'package:alero/models/customer/CustomerDetailsResponse.dart';
import 'package:alero/screens/alero/components/customer_touchpoint_body.dart';
import 'package:alero/screens/alero/components/customer_trends_graphs.dart';
import 'package:alero/screens/alero/components/loans_body_list.dart';
import 'package:alero/screens/alero/components/next_best_offering_body.dart';
import 'package:alero/screens/alero/components/next_best_offering_list.dart';
import 'package:alero/screens/alero/components/recent_tansactions_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';
import '../../../../style/theme.dart' as Style;
import 'package:flutter_svg/svg.dart';
import '../../components/trends_grid_item.dart';

class CooporateTrends extends StatefulWidget {
  final CustomerDetailsResponse? customerDetails;
  final String? customerAccountNo;

  const CooporateTrends({Key? key, required this.customerDetails, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>()
        .setCurrentScreen(screenName: 'Cooporate Trends Page');
    return _CooporateTrendsState();
  }
}

class _CooporateTrendsState extends State<CooporateTrends> {
  bool loading = true;
  String? customerId = "", groupId = "";
  var data;

  void getCustomerDetails() {
    if (mounted) {
      setState(() {
        customerId = data.customerId;
        groupId = data.groupId;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    if (data == null) {
      data = widget.customerDetails; /// Check here
      await Future.delayed(const Duration(seconds: 2), () {
        loadData();
      });
    } else {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getCustomerDetails();
    return Container(
      color: Style.Colors.tabBackGround,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TrendsGrid(
                                    text: 'Loans',
                                    image:
                                    'assets/customer/trends/trends_cooporate_loans.svg',
                                    leftMargin: 20.0,
                                    rightMargin: 10.0,
                                    customerAccountNo: widget.customerAccountNo,
                                    press: () {
                                      loadDialogs(
                                          NextBestOfferingBody(
                                              title: "Loans",
                                              customerId: customerId,
                                              groupId: groupId,
                                              customerAccountNo: widget.customerAccountNo,
                                              listBody: LoansBodyList(
                                                customerId: customerId,
                                                groupId: groupId,
                                                customerAccountNo: widget.customerAccountNo,
                                              )),
                                          510);
                                    }),
                                TrendsGrid(
                                    text: 'TouchPoint',
                                    image: 'assets/customer/trends/trends_touchpoint_icon.svg',
                                    leftMargin: 10.0,
                                    rightMargin: 10.0,
                                    customerAccountNo: widget.customerAccountNo,
                                    press: () {
                                      loadDialogs(
                                          CustomerTouchPointBody(
                                            customerId: customerId,
                                            groupId: groupId,
                                            customerAccountNo: widget.customerAccountNo,
                                          ),
                                          480);
                                    }),
                                TrendsGrid(
                                    text: 'Next Best Actions',
                                    image:
                                    'assets/customer/trends/trends_nba.svg',
                                    leftMargin: 10.0,
                                    rightMargin: 20.0,
                                    press: () {
                                      loadDialogs(
                                          NextBestOfferingBody(
                                              title: "Next Best Offering",
                                              customerId: customerId,
                                              groupId: groupId,
                                              listBody:
                                              NextBestOfferingBodyList(
                                                customerId: customerId,
                                                groupId: groupId,
                                              )),
                                          510);
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomerTrendsGraphs(
                          customerId: customerId,
                          groupId: groupId,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Recent transactions",
                                      style: TextStyle(
                                        color: Style.Colors.blackTextColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins-Bold',
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: SvgPicture.asset(
                                  'assets/customer/trends/trends_down_caret.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RecentTransactionsList(
                          customerId: customerId,
                          groupId: groupId,
                          customerAccountNo: widget.customerAccountNo,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void loadDialogs(Widget widget, double height) {
    OneContext().showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      builder: (context) => Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          color: Colors.white,
        ),
        height: height,
        child: widget,
      ),
    );
  }
}


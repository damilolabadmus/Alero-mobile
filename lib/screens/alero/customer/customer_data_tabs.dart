import 'package:alero/models/customer/CustomerDetailsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/customer/trends/cooporate_trends.dart';
import 'package:alero/screens/alero/customer/trends/customer_trends.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import '../../../style/theme.dart' as Style;
import 'biodata/cooporate_bio_data.dart';
import 'biodata/customer_bio_data.dart';
import 'overview/customer_overview.dart';

class CustomerDataTabs extends StatefulWidget {
  final String groupId;
  final String customerAccountNo;

  CustomerDataTabs({this.groupId, this.customerAccountNo});

  @override
  State<CustomerDataTabs> createState() => _CustomerDataTabsState();
}

class _CustomerDataTabsState extends State<CustomerDataTabs> {
  var apiService = AleroAPIService();
  String customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse customerDetailsResponse;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<String> tabTitles = ["Biodata", "Overview", "Trends"];

  Future getCustomerDetails(String groupId) async {
    print(groupId);
    return this._memoizer.runOnce(() async {
      final customerDetails = await apiService.getCustomerDetails(groupId);
      print(customerDetails);
      updateCustomerDetails(customerDetails);
      print('Account number in CustomerDataTabs class = $widget.customerAccountNo');
      return customerDetails;
    });
  }

  void updateCustomerDetails(CustomerDetailsResponse customerDetails) {
    if (mounted) {
      setState(() {
        customerName = customerDetails.customerName;
        customerGender = customerDetails.customerGender;
        customerType = customerDetails.customerType;
        customerDetailsResponse = customerDetails;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return DefaultTabController(
          length: 3,
          child: Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0)),
                        color: Style.Colors.tabBackGround,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 9),
                        child: TabBar(
                          unselectedLabelColor: Style.Colors.blackTextColor,
                          labelColor: Colors.white,
                          indicator: ContainerTabIndicator(
                            width: 96,
                            height: 32,
                            color: Style.Colors.buttonColor,
                            radius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                            borderWidth: 2.0,
                            borderColor: Colors.transparent,
                          ),
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(tabTitles[0],
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(tabTitles[1],
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(tabTitles[2],
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          (customerType == "I")
                              ? CustomerBioData(
                              customerDetails: customerDetailsResponse)
                              : CooporateBioData(
                              customerDetails: customerDetailsResponse),
                          CustomerOverview(
                              customerDetails: customerDetailsResponse,
                              customerAccountNo: widget.customerAccountNo),
                          (customerType == "I")
                              ? CustomerTrends(
                              customerDetails: customerDetailsResponse,
                              customerAccountNo: widget.customerAccountNo)
                              : CooporateTrends(
                            customerDetails: customerDetailsResponse,
                            customerAccountNo: widget.customerAccountNo,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      future: getCustomerDetails(widget.groupId),
    );
  }
}

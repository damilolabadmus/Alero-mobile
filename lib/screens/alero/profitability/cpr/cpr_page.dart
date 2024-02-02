

import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/screens/alero/profitability/cpr/cpr_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/profitability/cpr/cpr_dashboard_table_container.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:alero/network/AleroAPIService.dart';
import '../profitability_app_bar.dart';
import 'cpr_search_field.dart';

class CustomerProfitabilityReportPage extends StatefulWidget {
  final String? searchQuery;

  CustomerProfitabilityReportPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<CustomerProfitabilityReportPage> createState() =>
      _CustomerProfitabilityReportPageState();
}

class _CustomerProfitabilityReportPageState extends State<CustomerProfitabilityReportPage> {
  var apiService = AleroAPIService();
  List<String> tabTitles = ["Top Customer", "Bottom Customer"];
  bool dataLoaded = false;
  bool isInitialLoading = true;
  bool? isSearchCustomer;
  bool? cprDataNotNull;

  List<CprResponse> completeTopCprData = [];
  List<CprResponse> completeBottomCprData = [];

  @override
  void initState() {
    super.initState();

    if (!dataLoaded) {
      fetchData();
    }

    startTimeout();

  }

  void startTimeout() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isInitialLoading) {
        setState(() {
          isInitialLoading = false;
        });
      }
    });
  }

  void fetchData() async {
    try {
      List<Future<List<CprResponse>>> futures = [
        apiService.getTopCprData().timeout(Duration(minutes: 10)),
        apiService.getBottomCprData().timeout(Duration(minutes: 10)),
      ];

      List<List<CprResponse>> results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          completeTopCprData = results[0];
          completeBottomCprData = results[1];

          dataLoaded = true;
          isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProfitabilityAppBar(),
        body: PageStorage(
          bucket: PageStorageBucket(),
          child: isInitialLoading ? Center(child: CircularProgressIndicator())
              : Padding(
            padding: EdgeInsets.only(top: 10, right: 5.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Customer Profitability Report',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  CprSearchField(
                    searchCprCallback: (query) {
                      setState(() {
                        isSearchCustomer = query;
                      });
                    }
                  ),
                  SizedBox(height: 2),
                  cprDataTabs()
                ],
              ),
            ),
          ),
        ),
   bottomNavigationBar: CprBottomNavigationBar(cprDataNotNull: cprDataNotNull, isFirstPage: true));
}

Widget cprDataTabs() {
  return DefaultTabController(
    length: 2,
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
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: Style.Colors.tabBackGround,
                ),
                child: TabBar(
                  unselectedLabelColor: Style.Colors.blackTextColor,
                  labelColor: Colors.white,
                  indicator: ContainerTabIndicator(
                    width: 104,
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
                              fontSize: 9.0,
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
                              fontSize: 9.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Bold',
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CprDashboardTableContainer(
                      cprData: completeTopCprData,
                      cprDataNotNull: (cprDataNotNull) {
                        setState(() {
                          cprDataNotNull = cprDataNotNull;
                        });
                      },
                      /*pageIndex: (pageIndex) {
                        pageIndex = pageIndex;
                      },*/
                    ),
                    CprDashboardTableContainer(
                      cprData: completeBottomCprData
                    ),
                 ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );}
}

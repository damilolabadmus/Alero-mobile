import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'apr_bottom_nav_bar.dart';
import 'apr_dashboard_table_container.dart';
import '../profitability_app_bar.dart';
import 'apr_search_field.dart';

class AccountProfitabilityReportPage extends StatefulWidget {
  final String userId;

  AccountProfitabilityReportPage({@required this.userId});

  @override
  State<AccountProfitabilityReportPage> createState() => _AccountProfitabilityReportPageState();
}

class _AccountProfitabilityReportPageState extends State<AccountProfitabilityReportPage> {
  List<String> tabTitles = ["Top Account", "Bottom Account"];

  var apiService = AleroAPIService();
  bool dataLoaded = false;
  bool isInitialLoading = true;
  bool isSearchAccount;
  bool aprDataNotNull;

  List<AprResponse> topAprData = [];
  List<AprResponse> bottomAprData = [];
  // List<AprResponse> aprPeriodData = [];

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
      List<Future<List<AprResponse>>> futures = [
        apiService.getTopAprData().timeout(Duration(minutes: 15)),
        apiService.getBottomAprData().timeout(Duration(minutes: 15)),
        // apiService.getAprPeriod().timeout(Duration(minutes: 15)),
      ];

      List<List<AprResponse>> results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          topAprData = results[0];
          bottomAprData = results[1];
          // aprPeriodData = results[2];

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
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProfitabilityAppBar(),
        body: isInitialLoading ? Center(child: CircularProgressIndicator())
            : Padding(
            padding: EdgeInsets.only(left: 8.0, top: 10, right: 5.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account Profitability Report', style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular'),
                    ),
                    Text('View all account profitability reports here.', style: TextStyle(
                      color: Style.Colors.subBlackTextColor,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular'),),
                    SizedBox(height: 4),
                    AprSearchField(searchAprCallback: (query) { setState(() {isSearchAccount = query;});}
                     ),
                    SizedBox(height: 2),
                    aprDataTabs()],),
                ),
            ),
        ),
       bottomNavigationBar: AprBottomNavigationBar(aprDataNotNull: aprDataNotNull, isFirstPage: true)),
    );
  }

  Widget aprDataTabs() {
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
                      AprDashboardTableContainer(
                        aprData: topAprData,
                      ),
                      AprDashboardTableContainer(
                          aprData: bottomAprData
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

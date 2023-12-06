import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'apr_bottom_nav_bar.dart';
import 'apr_dashboard_table_container.dart';
import 'cpr_app_bar.dart';
import 'cpr_bottom_navigation_bar.dart';
import 'cpr_search_field.dart';

class AccountProfitabilityReportPage extends StatefulWidget {
  final String userId;

  AccountProfitabilityReportPage({@required this.userId});

  @override
  State<AccountProfitabilityReportPage> createState() => _AccountProfitabilityReportPageState();
}

class _AccountProfitabilityReportPageState extends State<AccountProfitabilityReportPage> {
  List<String> tabTitles = ["Top Account", "Bottom Account"];

  var apiService = AleroAPIService();
  bool isSearchCustomer;

  List<AprResponse> topAprData = [];
  List<AprResponse> bottomAprData = [];
  List<AprResponse> aprByAcctNo = [];
  List<AprResponse> searchAprData = [];
  List<AprResponse> aprPeriodData = [];

  Future<List<AprResponse>> getTopApr() async {
    List<AprResponse> _aprData = await apiService.getTopAprData();
    setState(() {
      topAprData = _aprData;
      print('The top apr = $topAprData');
    });
    return topAprData;
  }

  Future<List<AprResponse>> getBottomApr() async {
    List<AprResponse> _aprData = await apiService.getBottomAprData();
    setState(() {
      bottomAprData = _aprData;
      print('The bottom apr = $bottomAprData');
    });
    return bottomAprData;
  }

  Future<List<AprResponse>> getAprPeriod() async {
    List<AprResponse> _aprData = await apiService.getAprPeriod();
    setState(() {
      aprPeriodData = _aprData;
      print('Get Apr Period = $aprPeriodData');
    });
    return aprPeriodData;
  }

  Future<List<AprResponse>> getAprByAccNo(String accountNo) async {
    List<AprResponse> _aprData = await apiService.getAprDataByAccNo(accountNo);
    setState(() {
      aprByAcctNo = _aprData;
      print('The Apr by account number = $aprByAcctNo');
    });
    return aprByAcctNo;
  }

  /*@override
  void initState() {
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CprAppBar(),
      body: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 10, right: 5.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Profitability Report',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  Text(
                    'View all account profitability reports here.',
                    style: TextStyle(
                      color: Style.Colors.subBlackTextColor,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular',
                    ),),
                  SizedBox(height: 4),
                  CprSearchField(
                      searchCprCallback: (query) {
                        setState(() {
                          isSearchCustomer = query;
                        });
                      }
                  ),
                  SizedBox(height: 2),
                  aprDataTabs()
                ],
              ),
            ),
          ),
        ),
     bottomNavigationBar: AprBottomNavigationBar(barItemSelected: true));
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
                      AprDashboardTableContainer(aprData: bottomAprData
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

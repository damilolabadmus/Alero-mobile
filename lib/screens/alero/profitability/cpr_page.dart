import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/screens/alero/profitability/cpr_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/profitability/cpr_dashboard_table_container.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:alero/network/AleroAPIService.dart';
import 'cpr_app_bar.dart';
import 'cpr_search_field.dart';

class CustomerProfitabilityReportPage extends StatefulWidget {
  final String searchQuery;

  CustomerProfitabilityReportPage({Key key, @required this.searchQuery}) : super(key: key);

  @override
  State<CustomerProfitabilityReportPage> createState() =>
      _CustomerProfitabilityReportPageState();
}

class _CustomerProfitabilityReportPageState extends State<CustomerProfitabilityReportPage> {
  List<String> tabTitles = ["Top Customer", "Bottom Customer"];

  /// All dashboard rows clicking at a time
  /// Search customer
  /// Balance sheet page
  /// Bottom Navigation bar
  /// Cpr profit and loss header
  /// Details drop down to view more content

  var apiService = AleroAPIService();
  bool isSearchCustomer;

  List<CprResponse> completeTopCprData = [];
  List<CprResponse> completeBottomCprData = [];

  Future<List<CprResponse>> getCompleteTopCprData() async {
    List<CprResponse> _cprData = await apiService.getTopCprData();
    setState(() {
      completeTopCprData = _cprData;
      print('The top cpr = $completeTopCprData');
      String customerName = completeTopCprData[1].customerName.toString();
      print('The customer name in index 1 = $customerName');

      String incomeType = completeTopCprData[1].mainReport[1].incomeType.toString();
      String currentMonthBudgetKey = completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString();
      String currentMonthBudget = completeTopCprData[1].mainReport[1].currentMonthBudget.values.toString();
      String currentMonthVariance = completeTopCprData[1].mainReport[1].currentMonthVariance.values.toString();
      String currentMonthAchieved = completeTopCprData[1].mainReport[1].currentMonthAchieved.values.toString();
      String ytDActualValue = completeTopCprData[1].mainReport[1].ytDActualValue.toString();
      String ytDBudgetValue = completeTopCprData[1].mainReport[1].ytDBudgetValue.toString();
      String ydtVariance = completeTopCprData[1].mainReport[1].variance.toString();
      String ytdAchieved = completeTopCprData[1].mainReport[1].ytDAchieved.toString();
      String fullYearBudget = completeTopCprData[1].mainReport[1].fullYearBudget.toString();
      String runRate = completeTopCprData[1].mainReport[1].runRate.toString();

      print('The incomeType in index 2 = $incomeType');
      print('The currentMonthBudget_key in index 2 = $currentMonthBudgetKey');
      print('The currentMonthBudget in index 2 = $currentMonthBudget');
      print('The currentMonthVariance in index 2 = $currentMonthVariance');
      print('The currentMonthAchieved in index 2 = $currentMonthAchieved');
      print('The ytDActualValue in index 2 = $ytDActualValue');
      print('The ytDBudgetValue in index 2 = $ytDBudgetValue');
      print('The ydtVariance in index 2 = $ydtVariance');
      print('The ytdAchieved in index 2 = $ytdAchieved');
      print('The fullYearBudget in index 2 = $fullYearBudget');
      print('The runRate in index 2 = $runRate');


      String balanceSheetIncomeType = completeTopCprData[1].excludedTab[1].incomeType.toString();
      String bsCurrentMonthBudgetKey = completeTopCprData[1].excludedTab[1].currentMonthBudget.keys.toString();
      String bsCurrentMonthBudget = completeTopCprData[1].excludedTab[1].currentMonthBudget.values.toString();
      String bsCurrentMonthVariance = completeTopCprData[1].excludedTab[1].currentMonthVariance.values.toString();
      String bsCurrentMonthAchieved = completeTopCprData[1].excludedTab[1].currentMonthAchieved.values.toString();
      String bsYtDActualValue = completeTopCprData[1].excludedTab[1].ytDActualValue.toString();
      String bsYtDBudgetValue = completeTopCprData[1].excludedTab[1].ytDBudgetValue.toString();
      String bsYdtVariance = completeTopCprData[1].excludedTab[1].variance.toString();
      String bsYtdAchieved = completeTopCprData[1].excludedTab[1].ytDAchieved.toString();
      String bsFullYearBudget = completeTopCprData[1].excludedTab[1].fullYearBudget.toString();
      String bsRunRate = completeTopCprData[1].excludedTab[1].runRate.toString();

      print('The balance sheet incomeType = $balanceSheetIncomeType');
      print('The balance sheet currentMonthBudget_key = $bsCurrentMonthBudgetKey');
      print('The balance sheet currentMonthBudget = $bsCurrentMonthBudget');
      print('The balance sheet currentMonthVariance = $bsCurrentMonthVariance');
      print('The balance sheet currentMonthAchieved = $bsCurrentMonthAchieved');
      print('The balance sheet ytDActualValue = $bsYtDActualValue');
      print('The balance sheet ytDBudgetValue = $bsYtDBudgetValue');
      print('The balance sheet ydtVariance = $bsYdtVariance');
      print('The balance sheet ytdAchieved = $bsYtdAchieved');
      print('The balance sheet fullYearBudget = $bsFullYearBudget');
      print('The balance sheet runRate = $bsRunRate');
    });
    return completeTopCprData;
  }

  Future<List<CprResponse>> getCompleteBottomCprData() async {
      List<CprResponse> _cprData = await apiService.getBottomCprData();
      setState(() {
        completeBottomCprData = _cprData;
        print('The bottom data = $completeBottomCprData');
      });
      return completeBottomCprData;
    }

  @override
  void initState() {
    super.initState();
    getCompleteTopCprData();
    getCompleteBottomCprData();
  }

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
                  'Customer Profitability Report',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
                Text(
                  'View all customer profitability reports here.',
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
                /// This
               /* CprDashboardTableContainer(
                 cprData: completeTopCprData,
                ),*/
                /// Or this
                cprDataTabs()
              ],
            ),
          ),
        ),
      ),
   bottomNavigationBar: CprBottomNavigationBar(barItemSelected: true, searchedCustomer: isSearchCustomer, isFirstPage: true));
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

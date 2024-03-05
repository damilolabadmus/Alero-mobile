import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/screens/alero/profitability/cpr/cpr_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/profitability/cpr/cpr_dashboard_table_container.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../profitability_app_bar.dart';
import 'bloc/cpr_page_bloc/cpr_page_bloc.dart';
import 'cpr_search_field.dart';

class CustomerProfitabilityReportPage extends StatelessWidget {
  final String? searchQuery;

  CustomerProfitabilityReportPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CprPageBloc()..add(CprPageEvent.fetchData()),
      child: _CustomerProfitabilityReportPage(searchQuery: searchQuery),
    );
  }
}

class _CustomerProfitabilityReportPage extends StatelessWidget {
  final String? searchQuery;
  final List<String> tabTitles = ["Top Customer", "Bottom Customer"];

  _CustomerProfitabilityReportPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CprPageBloc, CprPageState>(
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ProfitabilityAppBar(),
            body: PageStorage(
              bucket: PageStorageBucket(),
              child: state.when(
                initial: () => Container(),
                loading: () => Center(child: CircularProgressIndicator()),
                loaded: (cprTopData, cprBottomData) {
                  return Padding(
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
                          CprSearchField(),
                          SizedBox(height: 2),
                          cprDataTabs(cprTopData, cprBottomData),
                        ],
                      ),
                    ),
                  );
                },
                error: (error) => Text('Error: $error'),
              ),
            ),
            bottomNavigationBar: CprBottomNavigationBar(isFirstPage: true));
      },
    );
  }

  Widget cprDataTabs(List<CprResponse> completeTopCprData, List<CprResponse> completeBottomCprData) {
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
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
                      CprDashboardTableContainer(cprData: completeTopCprData),
                      CprDashboardTableContainer(cprData: completeBottomCprData),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

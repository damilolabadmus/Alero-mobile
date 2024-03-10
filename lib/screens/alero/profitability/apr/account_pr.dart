import 'package:alero/screens/alero/profitability/apr/bloc/apr_page_bloc/apr_page_bloc.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'apr_bottom_nav_bar.dart';
import 'apr_dashboard_table_container.dart';
import '../profitability_app_bar.dart';
import 'apr_search_field.dart';

class AccountProfitabilityReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => APRPageBloc()
        ..add(APRPageEvent.fetchData())
        ..add(APRPageEvent.startTimeout()),
      child: _AccountProfitabilityReportPage(),
    );
  }
}

class _AccountProfitabilityReportPage extends StatelessWidget {
  final List<String> tabTitles = ["Top Account", "Bottom Account"];

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: BlocBuilder<APRPageBloc, APRPageState>(
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: ProfitabilityAppBar(),
              body: state.when(
                  initial: () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  loaded: (topData, bottomData) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 10, right: 5.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Profitability Report',
                                style: TextStyle(color: Colors.lightBlue, fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular'),
                              ),
                              Text(
                                'View all account profitability reports here.',
                                style: TextStyle(
                                    color: Style.Colors.subBlackTextColor,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                              SizedBox(height: 4),
                              AprSearchField(),
                              SizedBox(height: 2),
                              aprDataTabs(topData, bottomData)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  error: (message) => Center(child: Text(message))),
              bottomNavigationBar: AprBottomNavigationBar(isFirstPage: true));
        },
      ),
    );
  }

  Widget aprDataTabs(topAprData, bottomAprData) {
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
                      AprDashboardTableContainer(aprData: topAprData),
                      AprDashboardTableContainer(aprData: bottomAprData),
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

import 'package:flutter/material.dart';
import '../profitability_app_bar.dart';
import 'cpr_bottom_navigation_bar.dart';
import 'cpr_dashboard_table_container.dart';
import 'cpr_search_field.dart';
import 'package:alero/style/theme.dart' as Style;

class SearchCprPage extends StatelessWidget {
  final searchedCprData;
  SearchCprPage({Key? key, this.searchedCprData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProfitabilityAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Searched Customer',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Container(
                            width: searchedCprData == null || searchedCprData.isEmpty
                                ? 0
                                : searchedCprData[0].customerName.length > 12
                                    ? 100.0
                                    : null,
                            padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
                            decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(4.0)),
                            child: Text(
                                searchedCprData == null || searchedCprData.isEmpty
                                    ? ''
                                    : searchedCprData[0].customerName.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Regular',
                                ),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis),
                          ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'This section shows the customer that matches your search.',
                      style: TextStyle(
                        color: Style.Colors.subBlackTextColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  CprSearchField(),
                  SizedBox(height: 12),
                  CprDashboardTableContainer(
                    cprData: searchedCprData,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CprBottomNavigationBar());
  }
}



import 'package:flutter/material.dart';
import '../profitability_app_bar.dart';
import 'package:alero/style/theme.dart' as Style;
import 'apr_bottom_nav_bar.dart';
import 'apr_dashboard_table_container.dart';
import 'apr_search_field.dart';

class SearchAprPage extends StatefulWidget {
  final searchedAprData;
  bool? isSearched;

  SearchAprPage({Key? key, this.searchedAprData, this.isSearched}) : super(key: key);

  @override
  State<SearchAprPage> createState() => _SearchAprPageState();
}

class _SearchAprPageState extends State<SearchAprPage> {

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
                      Text('Searched Account',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Regular',
                        ),),
                      Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Container(
                            width: widget.searchedAprData == null || widget.searchedAprData.isEmpty ? 0 : widget.searchedAprData[0].customerName.length > 12 ? 100.0 : null,
                            padding: EdgeInsets.symmetric(horizontal: 7.0,
                                vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Text(widget.searchedAprData == null || widget.searchedAprData.isEmpty ? '' : widget.searchedAprData[0].customerName.toString(),
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
                      'This section shows the account that matches your search.',
                      style: TextStyle(
                        color: Style.Colors.subBlackTextColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular',
                      ),),
                  ),
                  SizedBox(height: 12),
                  AprSearchField(),
                  SizedBox(height: 12),
                  AprDashboardTableContainer(
                    aprData: widget.searchedAprData,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: AprBottomNavigationBar());
  }
}

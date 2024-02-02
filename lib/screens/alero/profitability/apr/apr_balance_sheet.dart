

import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/profitability/apr/apr_details_table_container.dart';
import 'package:alero/screens/alero/profitability/singleton.dart';
import 'package:flutter/material.dart';
import '../../../../../style/theme.dart' as Style;
import 'apr_balance_sheet_table_container.dart';
import 'apr_bottom_nav_bar.dart';
import '../profitability_app_bar.dart';

class AprBalanceSheet extends StatefulWidget {

  @override
  State<AprBalanceSheet> createState() => _AprBalanceSheetState();
}

class _AprBalanceSheetState extends State<AprBalanceSheet> {

  @override
  Widget build(BuildContext context) {
    final aprData = AprDataSingleton().aprData;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProfitabilityAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Balance Sheet',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),),
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text('Account name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      'Below shows the Balance Sheet Report for the above account.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Style.Colors.subBlackTextColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular',
                      ),),
                  ),
                ),
                SizedBox(height: 15),
                AprBalanceSheetTableContainer(aprData: aprData),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      bottomNavigationBar: AprBottomNavigationBar(aprDataNotNull: aprData == null ? false : true));
  }
}

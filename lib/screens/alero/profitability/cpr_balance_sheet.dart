import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;
import 'cpr_app_bar.dart';
import 'cpr_balance_sheet_table_container.dart';
import 'cpr_bottom_navigation_bar.dart';

class CprBalanceSheet extends StatefulWidget {
  final cprData;

  CprBalanceSheet({this.cprData});

  @override
  State<CprBalanceSheet> createState() => _CprBalanceSheetState();
}

class _CprBalanceSheetState extends State<CprBalanceSheet> {
  bool isHover = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CprAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 10, right: 5.0),
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
                          child: Text('Omorogbe Mercy Juliana',
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
                      'Below shows the Balance Sheet Report for the above customer.',
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
                CprBalanceSheetTableContainer(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
       bottomNavigationBar: CprBottomNavigationBar(barItemSelected: true, cprDataNotNull: widget.cprData == null ? false : true, isFirstPage: false));
  }
}

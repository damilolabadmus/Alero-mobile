

import 'package:alero/network/AleroAPIService.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';
import '../../../../../style/theme.dart' as Style;
import 'cpr_bottom_navigation_bar.dart';
import 'cpr_profit_loss_table_container.dart';

class CprProfitAndLossPage extends StatefulWidget {
  final cprProfitAndLoss;

  CprProfitAndLossPage({this.cprProfitAndLoss});

  @override
  State<CprProfitAndLossPage> createState() => _CprProfitAndLossPageState();
}

class _CprProfitAndLossPageState extends State<CprProfitAndLossPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 10, right: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Customer\'s Profit and Loss Report',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),),
                    Padding(
                        padding: const EdgeInsets.only(left: 3.0, bottom: 5),
                        child: Container(
                          width: widget.cprProfitAndLoss != null ? widget.cprProfitAndLoss[0].customerName.length > 12 ? 100.0 : null : 0,
                          // width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text(widget.cprProfitAndLoss == null ? '' : widget.cprProfitAndLoss[0].customerName.toString(),
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
                    'This section displays the selected customer\'s Profit and Loss report.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Style.Colors.subBlackTextColor,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular',
                    ),),
                ),
                SizedBox(height: 15),
                CprProfitAndLossTableContainer(
                  cprData: widget.cprProfitAndLoss,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      bottomNavigationBar: CprBottomNavigationBar(),
    );
  }

  AppBar appBar() => AppBar(
   elevation: 0,
   toolbarHeight: 40,
   backgroundColor: Style.Colors.searchActiveBg,
   leading: GestureDetector(
     onTap: () {
       Navigator.of(context)
           .pushNamedAndRemoveUntil(
           '/customer-pr', (Route<dynamic> route) => false);
   },
    child: Padding(
      padding: const EdgeInsets.all(13.0),
    child: Icon(
      EvaIcons.arrowBack,
      color: Colors.black,
    ),),
   ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 24.0),
        child: GestureDetector(
          onTap: () {
            logoutUser(context);
     },
     child: SvgPicture.asset('assets/customer/profile_logout.svg', width: 17),
    )),],
  );

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }
}

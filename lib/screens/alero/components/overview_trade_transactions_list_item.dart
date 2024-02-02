

import 'package:alero/utils/Pandora.dart';
import'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../style/theme.dart' as Style;

class OverviewTradeTransactionsListItem extends StatelessWidget {
  final String? tradeDesc, tradeExpiryDate, tradeDate;
  final bool? status;
  final String? tradeAmount;

  const OverviewTradeTransactionsListItem({Key? key, this.tradeDesc,
    this.tradeExpiryDate, this.tradeDate, this.status, this.tradeAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "");
    var bDate = DateTime.parse(tradeDate ?? '2020-12-29T00:00:00' + 'Z');
    var mDate = DateTime.parse(tradeExpiryDate! + 'Z');

    return Card(
      color: Style.Colors.overviewCardBg,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text('Booked on ' + Pandora.dateFormat(bDate),
                          style: TextStyle(
                            color: Style.Colors.overviewTextLightGrey,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Bold',
                          )),
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Style.Colors.mainColor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: status!
                            ? Style.Colors.overviewActiveBg
                            : Style.Colors.overviewInactiveBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: status!
                              ? Style.Colors.overviewActiveBg
                              : Style.Colors.red,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        status! ? 'Live' : 'Expired',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tradeDesc!,
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    )),
                Text('Expires on' + Pandora.dateFormat(mDate),
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₦ " + formatCurrency.format(double.parse(tradeAmount!)),
                    style: TextStyle(
                      color: Style.Colors.blackTextColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Bold',
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

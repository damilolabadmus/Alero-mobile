

import 'package:alero/utils/constants.dart';
import '../../../style/theme.dart' as Style;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/Pandora.dart';

class OverviewAccountsListItem extends StatelessWidget {
  final String? accountType,
      accountNumber,
      createdAddress,
      createdDate,
      currency;
  final bool? active;
  final double? balance;

  const OverviewAccountsListItem(
      {Key? key,
        this.accountType,
        this.accountNumber,
        this.createdAddress,
        this.createdDate,
        this.active,
        this.currency,
        this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(createdDate! + 'Z');
    final formatCurrency = new NumberFormat.currency(symbol: "");
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
                      Text("$accountType ($currency)",
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
                        color: active!
                            ? Style.Colors.overviewActiveBg
                            : Style.Colors.overviewInactiveBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: active!
                              ? Style.Colors.overviewActiveBg
                              : Style.Colors.overviewInactiveBg,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        active! ? 'active' : 'inactive',
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
              height: 5,
            ),
            Row(
              children: [
                Text(accountNumber!,
                    style: TextStyle(
                      color: Style.Colors.blackTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Bold',
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(createdAddress!,
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    )),
                Text('Opened ' + Pandora.dateFormat(date),
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
                currency!.toUpperCase() == 'NGN'
                    ? Text("₦ " + formatCurrency.format(balance),
                    style: kAccountCurrency)
                    : currency!.toUpperCase() == 'USD'
                    ? Text("\$ " + formatCurrency.format(balance),
                    style: kAccountCurrency) : currency!.toUpperCase() == 'EUR'
                    ? Text("\€ " + formatCurrency.format(balance),
                    style: kAccountCurrency) : currency!.toUpperCase() == 'CNY'
                    ? Text("\¥ " + formatCurrency.format(balance),
                    style: kAccountCurrency) : currency!.toUpperCase() == 'CHF'
                    ? Text("CHF " + formatCurrency.format(balance),
                    style: kAccountCurrency) : currency!.toUpperCase() == 'GBP'
                    ? Text("\£ " + formatCurrency.format(balance),
                    style: kAccountCurrency) : currency!.toUpperCase() == 'ZAR'
                    ? Text("R " + formatCurrency.format(balance),
                    style: kAccountCurrency) :
                Text("\$ " + formatCurrency.format(balance),
                    style: kAccountCurrency),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

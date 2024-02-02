

import 'package:alero/utils/Pandora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TrendsTransactionListItem extends StatelessWidget {
  final String? transactionDescription, transactionDate;
  final bool? inflow;
  final double? amount;

  const TrendsTransactionListItem(
      {Key? key,
        this.transactionDescription,
        this.transactionDate,
        this.inflow,
        this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "");
    var dDate = DateTime.parse(transactionDate! + 'Z');

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: inflow!
                  ? SvgPicture.asset(
                'assets/customer/trends/trends_history_down.svg',
              )
                  : SvgPicture.asset(
                'assets/customer/trends/trends_history_up.svg',
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(transactionDescription!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Style.Colors.greyTextColor,
                                fontSize: 9.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Bold',
                              ))),
                      Text("₦ " + formatCurrency.format(amount),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            color: Style.Colors.blackTextColor,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Bold',
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Pandora.dateFormat(dDate),
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import '../../../style/theme.dart' as Style;
import '../../../utils/Pandora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewLoansListItem extends StatelessWidget {
  final String loanReceiver,
      loanAccountNumber,
      disbursedDate,
      nextRepaymentDate,
      loanTenor,
      expiryDate;
  final bool performing;
  final double nextRepaymentAmount, balance;

  const OverviewLoansListItem(
      {Key key,
        this.loanReceiver,
        this.loanAccountNumber,
        this.disbursedDate,
        this.nextRepaymentDate,
        this.expiryDate,
        this.performing,
        this.nextRepaymentAmount,
        this.balance,
        this.loanTenor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "");
    var dDate = DateTime.parse(disbursedDate + 'Z');
    var nDate = DateTime.parse(nextRepaymentDate ?? expiryDate + 'Z');
    var eDate = DateTime.parse(expiryDate + 'Z');

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
                      Text(loanReceiver,
                          style: TextStyle(
                            color: Style.Colors.overviewTextBlue,
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
                        color: performing
                            ? Style.Colors.overviewActiveBg
                            : Style.Colors.overviewInactiveBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: performing
                              ? Style.Colors.overviewActiveBg
                              : Style.Colors.overviewInactiveBg,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        performing ? 'performing' : 'nonperforming',
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
              height: 15,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LOAN ACCOUNT",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                    Text(
                        'Disbursed  ' +
                            Pandora.dateFormat(dDate) +
                            ' for $loanTenor',
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(loanAccountNumber,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Repayment",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                    Text("Next Repayment Date",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("N " + formatCurrency.format(nextRepaymentAmount),
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text(Pandora.dateFormat(nDate),
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("N " + formatCurrency.format(balance),
                    style: TextStyle(
                      color: Style.Colors.blackTextColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Bold',
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expires ' + Pandora.dateFormat(eDate),
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../style/theme.dart' as Style;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/Pandora.dart';

class OverviewInvestmentsListItem extends StatelessWidget {
  final String investmentType, investmentDuration, maturityDate, bookedDate;
  final bool active;
  final double balance;

  const OverviewInvestmentsListItem(
      {Key key,
        this.bookedDate,
        this.investmentType,
        this.investmentDuration,
        this.maturityDate,
        this.active,
        this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "");
    var bDate = DateTime.parse(bookedDate + 'Z');
    var mDate = DateTime.parse(maturityDate + 'Z');

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
                        color: active
                            ? Style.Colors.overviewActiveBg
                            : Style.Colors.overviewInactiveBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: active
                              ? Style.Colors.overviewActiveBg
                              : Style.Colors.overviewInactiveBg,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        active ? 'active' : 'inactive',
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
                Text(investmentType,
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
                Text(investmentDuration,
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    )),
                Text('Matures on ' + Pandora.dateFormat(mDate),
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
                Text(formatCurrency.format(balance),
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



import '../../../style/theme.dart' as Style;
import '../../../utils/Pandora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OverviewPNDListItem extends StatelessWidget {
  final String? accountNumber, addedDate, reason;

  const OverviewPNDListItem(
      {Key? key, this.accountNumber, this.addedDate, this.reason})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var aDate = DateTime.parse(addedDate! + 'Z');

    return Card(
      color: Style.Colors.overviewCardBg,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(
                'assets/landing/landing_lock.svg',
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(accountNumber!,
                          style: TextStyle(
                            color: Style.Colors.blackTextColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Bold',
                          )),
                      Text('Added on ' + Pandora.dateFormat(aDate),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Reason",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(reason!,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
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

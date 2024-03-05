

import '../../../style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/Pandora.dart';

class OverviewEchannelsListItem extends StatelessWidget {
  final String? channelName, dateEnrolled;
  final bool? active;

  const OverviewEchannelsListItem(
      {Key? key, this.channelName, this.dateEnrolled, this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eDate = DateTime.parse(dateEnrolled! + 'Z');

    return Card(
      color: active! ? Style.Colors.biodataGreen : Style.Colors.biodataRed,
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
                'assets/customer/overview/channels_leading.svg',
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(channelName ?? '',
                          style: TextStyle(
                            color: Style.Colors.blackTextColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Bold',
                          )),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enrolled ' + Pandora.dateFormat(eDate),
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

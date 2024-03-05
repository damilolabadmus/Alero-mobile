

import 'package:alero/utils/Pandora.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import '../../../style/theme.dart' as Style;

class OverviewChannelsCardItem extends StatelessWidget {
  final String? cardPan, cardType;

  const OverviewChannelsCardItem({Key? key, this.cardPan, this.cardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dDate = DateTime.parse(cardPan! + 'Z');

    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    'assets/customer/overview/channels_card_background.png'),
              )),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(cardType!,
                        style: TextStyle(
                          color: Style.Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        ))),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(Pandora.dateFormat(dDate),
                        style: TextStyle(
                          color: Style.Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )))
              ],
            ),
          ),
        ));
  }

  String? hashPanDigits(String PAN) {
    return StringUtils.hidePartial(PAN, begin: 4, end: PAN.length - 4);
  }

  String? splitPan(String hashedPan) {
  }
}

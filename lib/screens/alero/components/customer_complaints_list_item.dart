import '../../../style/theme.dart' as Style;
import '../../../utils/Pandora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerComplaintsListItem extends StatelessWidget {
  final String loggedDate, description, category, resolvedDate;
  final bool status;

  const CustomerComplaintsListItem(
      {Key key,
        @required this.loggedDate,
        @required this.description,
        @required this.resolvedDate,
        @required this.status,
        @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lDate = Pandora.reverse(
        Pandora.getStringsAfter(Pandora.reverse(loggedDate), 12));
    var rDate = Pandora.reverse(
        Pandora.getStringsAfter(Pandora.reverse(resolvedDate), 12));

    return Card(
      color: status
          ? Style.Colors.overviewCardBg
          : Colors.amber.withOpacity(40),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text("Description",
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
                            color: status
                                ? Style.Colors.overviewActiveBg
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: status
                                  ? Style.Colors.overviewActiveBg
                                  : Colors.amber,
                            )),
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            status ? 'Closed' : 'Open',
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
                  height: 2,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(description,
                      style: TextStyle(
                        color: Style.Colors.blackTextColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Bold',
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logged Date",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                    Text("Resolved Date",
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
                    Text(lDate,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text(rDate,
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category",
                    style: TextStyle(
                      color: Style.Colors.overviewTextLightGrey,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Regular',
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category,
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
      ),
    );
  }
}

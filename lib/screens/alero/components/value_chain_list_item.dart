

import '../../../style/theme.dart' as Style;
import 'package:flutter/material.dart';

class ValueChainListItem extends StatelessWidget {
  const ValueChainListItem({
    Key? key,
    required this.valueChainCustomerId,
    required this.valueChainGroup,
    required this.valueChain,
    required this.valueChainSector,
  }) : super(key: key);

  final String? valueChainCustomerId;
  final String? valueChainGroup;
  final String? valueChain;
  final String? valueChainSector;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Style.Colors.biodataBlue,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Customer ID",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text("Value Chain Group",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(valueChainCustomerId!,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text(valueChainGroup!,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Value Chain",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text("Value Chain Group",
                        style: TextStyle(
                          color: Style.Colors.overviewTextLightGrey,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(valueChain!,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                    Text(valueChainSector!,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

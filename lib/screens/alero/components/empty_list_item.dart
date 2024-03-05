

import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class EmptyListItem extends StatelessWidget {
  final String? message;

  const EmptyListItem({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Style.Colors.overviewCardBg,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
          padding: EdgeInsets.all(12),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(message!,
                    style: TextStyle(
                      color: Style.Colors.blackTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins-Bold',
                    )),
              ),
            ],
          )),
    );
  }
}

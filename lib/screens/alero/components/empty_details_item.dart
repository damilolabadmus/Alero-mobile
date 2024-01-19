import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class EmptyDetailsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oops!',
              style: TextStyle(
                color: Style.Colors.blackTextColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                  letterSpacing: 1
              )),
          SizedBox(height: 8),
          Text('No data found.',
              style: TextStyle(
                color: Style.Colors.blackTextColor,
                fontSize: 12.0,
                fontFamily: 'Poppins-Regular',
                letterSpacing: 1
              )),
        ])
    );
  }
}

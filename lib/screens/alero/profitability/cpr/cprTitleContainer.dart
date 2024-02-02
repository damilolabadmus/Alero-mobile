

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

class CprTitleContainer extends StatelessWidget {
  final String? subTitle;
  final String? subText;

  CprTitleContainer({this.subTitle, this.subText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text('Performance Management',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Regular',
              ),),
          ),
          Positioned(
            top: 22,
            left: 5,
            child: Text(subTitle == null ? '' : subTitle!,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),),
          ),
          Positioned(
            top: 22,
            left: 72,
            child: Text(subText == null ? '' : '- ' + subText!,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Style.Colors.greyTextColor,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.w600),),
          ),
        ],
      ),
    );
  }
}

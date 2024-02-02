

import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class Indicator extends StatelessWidget {
  final Color? color;
  final String? text;
  final bool? isSquare;
  final double size;
  final Color? textColor;

  const Indicator({
    Key? key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 20,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size / 2,
          decoration: BoxDecoration(
            shape: isSquare! ? BoxShape.rectangle : BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(child: Text(
          text!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Style.Colors.blackTextColor,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins-Regular',
          ),
        ))
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class NBOItem extends StatelessWidget {
  final String value;
  final Color backgroundColor;

  const NBOItem({Key key, @required this.value, @required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
          padding: EdgeInsets.all(12),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(value,
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

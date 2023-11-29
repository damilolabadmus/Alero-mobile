import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../style/theme.dart' as Style;

class DealsItem extends StatelessWidget {
  @required String value;
  int count;
  @required String text;

  DealsItem({this.value, this.count, this.text});

  final List<Color> gradientColors1 = [
    Style.Colors.fourthColor,
    Style.Colors.fourthColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(40.0)),
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.amber.shade100],
          begin: Alignment.bottomLeft,
          end: Alignment(0.5, 3.0),
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value.toString(),
                    style: kBankItemValue,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  count != null ?
                  Text(
                    '${count.toString()} $text',
                    style: kBankItemTitle.copyWith(fontSize: 14.0),
                  ) : Text('$text',
                    style: kBankItemTitle.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

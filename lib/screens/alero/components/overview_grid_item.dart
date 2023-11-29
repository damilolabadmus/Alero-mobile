import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class OverviewGrid extends StatelessWidget {
  final String text, image, customerAccountNo;
  final Function press;

  const OverviewGrid({Key key, this.text, this.image, this.press, this.customerAccountNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            SvgPicture.asset(
              image,
            ),
            SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(text,
                  softWrap: true,
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Regular',
                  )),
            )
          ],
        ),
      ),
    );
  }
}

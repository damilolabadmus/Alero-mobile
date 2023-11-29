import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class TrendsGrid extends StatelessWidget {
  final String text, image, customerAccountNo;
  final Function press;
  final double leftMargin, rightMargin;

  const TrendsGrid(
      {Key key,
        this.text,
        this.image,
        this.press,
        this.leftMargin,
        this.rightMargin,
        this.customerAccountNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 130,
        height: 120,
        margin: EdgeInsets.only(right: rightMargin, left: leftMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey.shade50,
              blurRadius: 0.5,
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          elevation: 1,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  SvgPicture.asset(
                    image,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(text,
                        softWrap: true,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

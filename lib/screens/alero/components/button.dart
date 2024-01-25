import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton({Key key, this.text, this.press, this.color, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: size.width * 0.9,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              foregroundColor: MaterialStateProperty.all(textColor),
            ),
            onPressed: press,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
                SizedBox(width: 10.0),
              ],
            ),
          )

          // child: FlatButton(
          //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          //   color: color,
          //   onPressed: press,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         text,
          //         style: TextStyle(
          //             color: textColor,
          //             fontSize: 16.0,
          //             fontFamily: 'Poppins-Regular'),
          //       ),
          //       SizedBox(width: 10.0),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

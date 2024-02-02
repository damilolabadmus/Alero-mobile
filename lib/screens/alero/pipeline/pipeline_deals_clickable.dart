

import 'package:flutter/material.dart';

class DealsUnset extends StatelessWidget {
  final String text;
  final Color? color;
  final double? width;

  DealsUnset({required this.text, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 2.0, 15.0, 2.0),
          child: Container(
            height: 30,
            width: width,
            decoration: BoxDecoration(color: color,
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              onPressed: () {  },
              child: Text(text,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins-Regular',
                ),),
            ),
          )
      ),
    );
  }
}

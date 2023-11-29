import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class ProspectDataCard extends StatelessWidget {
  const ProspectDataCard({Key key,
    this.icon,
    @required this.value,
    @required this.iconColour,
    @required this.valueColour,
    @required this.fontSize,
    this.letterSpacing,
    this.wordSpacing,

  }) : super(key: key);

  final IconData icon;
  final String value;
  final Color iconColour;
  final Color valueColour;
  final double fontSize;
  final double letterSpacing;
  final double wordSpacing;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Icon(
                icon,
                color: iconColour,
                size: 20.0,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                letterSpacing: letterSpacing,
                wordSpacing: wordSpacing,
                color: valueColour,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

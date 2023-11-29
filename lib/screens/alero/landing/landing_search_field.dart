import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(
          horizontal: Style.Constants.Padding5,
          vertical: Style.Constants.Padding5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: Style.Colors.searchBoxColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.transparent)),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class CallTextField extends StatelessWidget {
  const CallTextField({Key key,
    @required this.prospectController,
    this.validator,
    this.hintText,
    this.labelText,
    @required this.onChanged,
    this.textInputAction,
    this.keyboardType,
    this.readOnly,
    this.hintStyle,
    this.suffixIcon,
    this.errorText,
    this.prefixIcon,
    this.fillColor,

  }) : super(key: key);

  final TextEditingController prospectController;
  final Function validator;
  final String hintText;
  final String labelText;
  final Function onChanged;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool readOnly;
  final TextStyle hintStyle;
  final IconButton suffixIcon;
  final String errorText;
  final IconButton prefixIcon;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      controller: prospectController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        errorText: errorText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w700,
        ),
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide.none),
      ),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}

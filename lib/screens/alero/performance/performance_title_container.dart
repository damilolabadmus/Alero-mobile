

import 'dart:ui';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../style/theme.dart' as Style;

class PmTitleContainer extends StatelessWidget {
  String? measure, subTitle, subText, selectedDate/*, selectedState*/;
  final Function()? selectDate;
  final Function()? updateSelectedDate;

  PmTitleContainer ({this.measure, this.subTitle, this.subText, this.selectedDate, /*this.selectedState,*/ this.selectDate, this.updateSelectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Performance Management',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),),
                  Container(
                    width: 220,
                    child: Row(
                      children: [
                        Text(measure!,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-Regular',
                          )),
                        Text(subText == null ? '' : '-' + subText!,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-Regular',
                          )),
                        Container(
                          width: 50,
                          child: subTitle == null ? Text('') : Text(' (' + subTitle! + ')',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins-Regular',
                            ),softWrap: false,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 160,
                child: CallTextField(
                  validator: (String? value) {
                    if (value == null) {
                      return 'Nothing has been picked yet.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                  hintText: selectedDate,
                  suffixIcon: IconButton(
                      icon: Icon(
                        EvaIcons.calendar,
                        color: Style.Colors.buttonColor,
                        size: 25,
                      ),
                      color: Style.Colors.buttonColor,
                      onPressed: selectDate
                  ), onChanged: (value) {},
                ),
              ),
            ],
          ),
        ));
  }
}

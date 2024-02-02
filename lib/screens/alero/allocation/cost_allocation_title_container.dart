

import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class CostAllocationTitleContainer extends StatelessWidget {
  final String? title;
  String? expensePeriod;
  Function? search;

  CostAllocationTitleContainer({this.title, this.expensePeriod, this.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(title!,
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
              ),),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 155,
                child: CallTextField(
                  fillColor: Colors.grey.shade200,
                  validator: (String? value) {
                    if (value == null) {
                      return 'Nothing has been picked yet.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                  hintText: expensePeriod == null ? 'Select Date'
                      : expensePeriod,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Regular',
                  ),
                  suffixIcon: IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(Icons.arrow_drop_down,
                          color: Style.Colors.buttonColor
                      ), onPressed: () {  },
                  ),
                ),
              ),
              Container(
                height: 38,
                width: 155,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  child: Row(
                    children: [
                      Icon(EvaIcons.searchOutline,
                        color: Style.Colors.blackTextColor,),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text('Search',
                          style: TextStyle(
                            color: Style.Colors.blackTextColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),),
                      ),
                    ],),
                  onPressed: search as void Function()?,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

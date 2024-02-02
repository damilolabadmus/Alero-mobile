

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class SignatoriesListItem extends StatelessWidget {
  final String? name, phoneNumber;

  const SignatoriesListItem(
      {Key? key, required this.name, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Style.Colors.biodataGreen,
        elevation: 0,
        margin: EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            EvaIcons.personOutline,
                            color: Style.Colors.iconColor,
                            size: 15.0,
                          ),
                        ),
                        Flexible(
                          child: Text(name!,
                              softWrap: true,
                              style: TextStyle(
                                color: Style.Colors.blackTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'assets/customer/biodata/biodata_call.svg',
                          ),
                        ),
                        Text(phoneNumber!,
                            style: TextStyle(
                              color: Style.Colors.blackTextColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins-Regular',
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

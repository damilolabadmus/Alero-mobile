

import 'package:alero/utils/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class ReportSearchController extends StatelessWidget {

    final Function? search;

    ReportSearchController({this.search});

    @override
    Widget build(BuildContext context) {
        return Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                height: 40,
                width: 200,
                child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Type to Search/Filter",
                        hintStyle: kBottomSheetSubName,
                        prefixIcon: Icon(
                            EvaIcons.searchOutline,
                            color: Style.Colors.buttonColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none),
                    ),
                    onChanged: search as void Function(String)?,
                    /*onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    reportOnSearch =
                            scorecard.product.toLowerCase() as List;
                  }
                });
              },*/
                ),
            ),
        );
    }
}

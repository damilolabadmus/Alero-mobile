import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class NextBestOfferingBody extends StatefulWidget {
  final String title;
  final Widget listBody;
  final String customerId, groupId, customerAccountNo;

  const NextBestOfferingBody(
      {Key key,
        @required this.title,
        @required this.listBody,
        @required this.customerId,
        @required this.groupId,
        this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NextBestOfferingBodyState();
  }
}

class _NextBestOfferingBodyState extends State<NextBestOfferingBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/customer/dialog_close_button.svg',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          widget.listBody,
        ],
      ),
    );
  }
}

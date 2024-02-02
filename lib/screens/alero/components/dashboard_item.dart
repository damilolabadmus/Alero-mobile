

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardItem extends StatelessWidget {
  final String? message;
  final Function? press;
  final Color? color;
  final String? image;

  const DashboardItem(
      {Key? key, this.message, this.press, this.color, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
            onTap: press as void Function()?,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: color),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15,top: 15,bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: SvgPicture.asset(
                        image!,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Flexible(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(message!,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                              ))))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}


class DashboardItemAlign extends StatelessWidget {
  final String? message;
  final Function? press;
  final Color? color;
  final String? image;

  const DashboardItemAlign(
      {Key? key, this.message, this.press, this.color, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
            onTap: press as void Function()?,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: color),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 5,top: 8,bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 5),
                    Center(
                      child: SvgPicture.asset(
                        image!,
                        width: 45,
                        height: 50,
                      ),
                    ),
                    Flexible(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(message!,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                height: 1.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins-Regular',
                              ))))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}


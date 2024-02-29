

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BalanceSheetSideMenu extends StatelessWidget {
  bool? isActive;
  bool? active;
  Function? ontap;
  Function? tap;

  BalanceSheetSideMenu({this.isActive, this.active, this.ontap, this.tap});

  @override
    Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 7),
                child: SvgPicture.asset(
                  'assets/login/ubn_logo_white.svg',
                  color: Colors.black45,
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(top: 120.0, left: 10),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    child: Column(
                      children: [
                        Divider(color: Colors.black38, thickness: 1.0, indent: 30, endIndent: 30),
                        Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              height: 64,
                              left: 0,
                              curve: Curves.fastOutSlowIn,
                              width: isActive == true ? 280 : 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                onTap: ontap as void Function()?,
                                leading: Icon(Icons.view_day_outlined),
                                title: Text('Actual Balance Sheet', style: TextStyle(
                                  color: Colors.lightBlueAccent.shade700,
                                  fontSize: 17.0,
                                  fontFamily: 'Poppins-Bold',
                                ),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Divider(color: Colors.black38, thickness: 1.0, indent: 10, endIndent: 10),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              left: 0,
                              height: 64,
                              curve: Curves.fastOutSlowIn,
                              width: active == true ? 280 : 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0)
                                  ),
                                ),
                              ),),
                            ListTile(
                              onTap: tap as void Function()?,
                              leading: Icon(Icons.view_day_rounded),
                              title: Text('Average Balance Sheet',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent.shade700,
                                  fontSize: 17.0,
                                  fontFamily: 'Poppins-Bold',
                                ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Divider(color: Colors.black38, thickness: 1.0, indent: 30, endIndent: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 288.0),
                child: Container(
                  height: size.height * 0.5,
                  alignment: Alignment.bottomRight,
                   color: Colors.lightBlue.shade50,
                  child: SvgPicture.asset('assets/login/login_effects.svg'),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset('assets/login/alero_logo_img.png',
                    height: size.height * 0.20),
              ),
          ],),
        ),
      );
  }
}

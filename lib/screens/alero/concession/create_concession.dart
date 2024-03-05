

import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/add_concession.dart';
import 'package:alero/screens/alero/concession/concession_covenant.dart';
import 'package:alero/screens/alero/concession/concession_product.dart';
import 'package:alero/screens/alero/concession/concession_upload.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'concession_bottom_nav_bar.dart';

class CreateConcession extends StatefulWidget {

  @override
  State<CreateConcession> createState() => _CreateConcessionState();
}

class _CreateConcessionState extends State<CreateConcession> {
  List<String> tabTitles = ["Add Account", "Add Product", "Add Covenant", "File Upload",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CallAppBar(),
      body: concessionDataTabs(),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }

  Widget concessionDataTabs() {
    return DefaultTabController(
      length: 4,
      child: Expanded(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0)),
                    color: Style.Colors.tabBackGround,
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 9),
                      child: TabBar(
                        unselectedLabelColor: Style.Colors.blackTextColor,
                        labelColor: Colors.white,
                        indicator: ContainerTabIndicator(
                          width: 96,
                          height: 30,
                          color: Style.Colors.buttonColor,
                          radius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                          borderWidth: 2.0,
                          borderColor: Colors.transparent,
                        ),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(tabTitles[0],
                                    style: TextStyle(
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(tabTitles[1],
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold',
                                  )),),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(tabTitles[2],
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold',
                                  )),),),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(tabTitles[3],
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Bold',
                                  )),),),
                        ],),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AddConcession(),
                      ConcessionProduct(),
                      ConcessionCovenant(),
                      ConcessionUpload()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

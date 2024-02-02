

import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/create_concession_form.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'concession_bottom_nav_bar.dart';

class CreateConcession extends StatefulWidget {

  @override
  State<CreateConcession> createState() => _CreateConcessionState();
}

class _CreateConcessionState extends State<CreateConcession> {
  List<String> tabTitles = ["Add Account", "File Upload", "Add Covenant", "Add Product"];

  @override
  Widget build(BuildContext context) {

    // List<ConcessionResponse> concessionData = [];

    return Scaffold(
      appBar: CallAppBar(),
      body: CreateConcessionForm(
        // concessionData: concessionData,
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }

  Widget concessionDataTabs() {
    return DefaultTabController(
      length: 3,
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
                      CreateConcessionForm(
                        // concessionData: concessionData,
                      ),
                      CreateConcessionForm(
                        // concessionData: concessionData,
                      ),
                      CreateConcessionForm(
                        // concessionData: concessionData,
                      ),
                      CreateConcessionForm(
                        // concessionData: concessionData,
                      )
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

  AppBar appBar() => AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Style.Colors.blackTextColor,
        size: 24,
      ),
    ),
    backgroundColor: Colors.lightBlue.shade100,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
            icon: Icon(Icons.home),
            iconSize: 30.0,
            color: Style.Colors.blackTextColor,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
            }
        ),
      ),
    ],
  );
}






class Con extends StatefulWidget {

  @override
  State<Con> createState() => _ConState();
}

class _ConState extends State<Con> {
  List<String> tabTitles = ["Add Account", "File Upload", "Add Covenant", "Add Product"];

  var concessionData = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create Concession",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              Container(
                height: 35,
                width: 90,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 15.0),
                          child: Align(
                              child: Icon(Icons.person_add, color: Colors.white, size: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('Create', style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateConcession()),
                      );
                    }
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome, please select from the reports below.',
              style: TextStyle(
                color: Style.Colors.blackTextColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),),),
          SizedBox(height: 15.0),
          // concessionDataTabs(),
          /*ConcessionFormContainer(
              concessionData: concessionData,
            ),*/

        ],
      ),
    );}

}

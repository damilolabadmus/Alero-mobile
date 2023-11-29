import 'package:alero/models/call/DealsItemsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/call/call_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/call/call_management_page.dart';
import 'package:alero/screens/alero/pipeline/deals_item_container.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_add.dart';
import 'package:alero/screens/alero/pipeline/status_update_page.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/constants.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import 'package:one_context/one_context.dart';
import '../pipeline/completed_page.dart';
import '../pipeline/disbursement_page.dart';
import 'package:async/async.dart';

class PipelinePage extends StatefulWidget {

  final String groupId;

  PipelinePage({Key key, @required this.groupId}) : super(key: key);

  @override
  _PipelinePageState createState() => _PipelinePageState();
}

class _PipelinePageState extends State<PipelinePage> {
  List<String> tabTitles = ["Pending Status Update", "Disbursement", "Completed"];

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  DealsItemsResponse items;
  var dataItem;

  int allDeals;
  int convertedDeals;
  int completedDeals;
  int declinedDeals;
  double conversionRate;
  double allDealsValue;
  double convertedDealsValue;
  double completedDealsValue;
  double declinedDealsValue;

  Future<dynamic> getPipelineItems() async {
    return this._asyncMemoizer.runOnce(() async {
      OneContext().showProgressIndicator();
      var _items = await apiService.getPipelineDealsItems();
      setState(() {
        items = _items as DealsItemsResponse;
        dataItem = items.result;
        allDeals = dataItem.allDeals;
        convertedDeals = dataItem.convertedDeals;
        completedDeals = dataItem.completedDeals;
        declinedDeals = dataItem.declinedDeals;
        conversionRate = dataItem.conversionRate;
        allDealsValue = dataItem.allDealsValue;
        convertedDealsValue = dataItem.convertedDealsValue;
        completedDealsValue = dataItem.completedDealsValue;
        declinedDealsValue = dataItem.declinedDealsValue;
      });
      OneContext().hideProgressIndicator();
    });
  }

  String allDealsText() {
    if (allDeals <= 1) {
      return 'deal in total';
    } else {
      return 'deals in total';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoadingWidget();
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar(),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Text(
                          'Pipeline Deals',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Create a new deal or view existing deals.',
                            style: TextStyle(
                              color: Style.Colors.blackTextColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins-Regular',
                            ),),),],),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DealsItem(
                              value: allDealsValue.toInt().toString().length < 7 ?
                              "₦ " + double.parse((allDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') :
                              allDealsValue.toInt().toString().length < 9 ?
                              "₦ " + "${double.parse((allDealsValue/kDealsValueForM).toStringAsFixed(2)).toString()} m" :
                              allDealsValue.toInt().toString().length <  12 ?
                              "₦ " + "${double.parse((allDealsValue/kDealsValueForB).toStringAsFixed(2)).toString()} b" :
                              allDealsValue.toInt().toString().length < 30 ?
                              "₦ " + "${double.parse((allDealsValue/kDealsValueForTr).toStringAsFixed(2)).toString()} tr" :
                              "₦ " + double.parse((allDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              count: allDeals,
                              text: allDealsText(),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DealsItem(
                              value: completedDealsValue.toInt().toString().length < 7 ?
                              "₦ " + double.parse((completedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') :
                              completedDealsValue.toInt().toString().length < 9 ?
                              "₦ " + "${double.parse((completedDealsValue/kDealsValueForM).toStringAsFixed(2)).toString()} m" :
                              completedDealsValue.toInt().toString().length < 12 ?
                              "₦ " + "${double.parse((completedDealsValue/kDealsValueForB).toStringAsFixed(2)).toString()} b" :
                              completedDealsValue.toInt().toString().length > 30 ?
                              "₦ " + "${double.parse((completedDealsValue/kDealsValueForTr).toStringAsFixed(2)).toString()}tr" :
                              "₦ " + double.parse((completedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              count: completedDeals,
                              text: 'Completed',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DealsItem(
                              value: convertedDealsValue.toInt().toString().length < 7 ?
                              "₦ " + double.parse((convertedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') :
                              convertedDealsValue.toInt().toString().length < 9 ?
                              "₦ " + "${double.parse((convertedDealsValue/kDealsValueForM).toStringAsFixed(2)).toString()} m" :
                              convertedDealsValue.toInt().toString().length < 12 ?
                              "₦ " + "${double.parse((convertedDealsValue/kDealsValueForB).toStringAsFixed(2)).toString()} b" :
                              convertedDealsValue.toInt().toString().length > 30 ?
                              "₦ " + "${double.parse((convertedDealsValue/kDealsValueForTr).toStringAsFixed(2)).toString()} tr" :
                              "₦ " + double.parse((convertedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              count: convertedDeals,
                              text: 'Converted',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DealsItem(
                              value: declinedDealsValue.toInt().toString().length < 7 ?
                              "₦ " + double.parse((declinedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') :
                              declinedDealsValue.toInt().toString().length < 9 ?
                              "₦ " + "${double.parse((declinedDealsValue/kDealsValueForM).toStringAsFixed(2)).toString()} m" :
                              declinedDealsValue.toInt().toString().length < 12 ?
                              "₦ " + "${double.parse((declinedDealsValue/kDealsValueForB).toStringAsFixed(2)).toString()} b" :
                              declinedDealsValue.toInt().toString().length > 30 ?
                              "₦ " + "${double.parse((declinedDealsValue/kDealsValueForTr).toStringAsFixed(2)).toString()} tr" :
                              "₦ " + double.parse((declinedDealsValue).toStringAsFixed(2)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              count: declinedDeals,
                              text: 'Declined',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DealsItem(
                              value: '${conversionRate.round().toString()}%',
                              text: 'Conversion Rate',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Existing Deals',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.person_add, color: Colors.white, size: 15),
                                  SizedBox(width: 5.0),
                                  Text('New Deal', style: TextStyle(color: Colors.white),
                                  ),],),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DealsAdd(),),
                                );}),
                        ),],),
                  ),
                  prospectDataTabs(),
                ],
              ),
            ),
            bottomNavigationBar: CallBottomNavigationBar(),
          );},
        future: getPipelineItems()
    );
  }

  Widget appBar() => AppBar(
    toolbarHeight: 50,
    leading: IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CallManagementPage(),),
        );},
      icon: Icon(
        Icons.arrow_back_ios,
        color: Style.Colors.blackTextColor,
        size: 24,
      ),
    ),
    backgroundColor: Style.Colors.searchActiveBg,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TextButton(
          child: IconButton(
            icon: Icon(Icons.home),
            iconSize: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
          },
        ),
      ),
    ],
  );

  Widget prospectDataTabs() {
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
                                )),),
                        )],),),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      StatusUpdatePage(),
                      DisbursementPage(),
                      CompletedPage(),
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



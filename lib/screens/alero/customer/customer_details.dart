import 'dart:async';
import 'package:alero/screens/alero/customer/trends/cooporate_trends.dart';
import 'package:alero/screens/alero/customer/trends/customer_trends.dart';
import 'package:alero/screens/alero/search/alternate_search_page.dart';
import 'package:one_context/one_context.dart';
import '../../../models/customer/CustomerDetailsResponse.dart';
import '../../../network/AleroAPIService.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../search/shimmer_loading_widget.dart';
import 'biodata/cooporate_bio_data.dart';
import 'biodata/customer_bio_data.dart';
import 'overview/customer_overview.dart';
import 'trends/cooporate_trends.dart';
import 'trends/customer_trends.dart';

class CustomerDetails extends StatefulWidget {
  final String groupId;

  CustomerDetails({Key key, @required this.groupId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerDetailsState();
  }
}

class _CustomerDetailsState extends State<CustomerDetails> {
  var apiService = AleroAPIService();
  String customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse customerDetailsResponse;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  List<String> tabTitles = ["Biodata", "Overview", "Trends"];

  Future getCustomerDetails(String groupId) async {
    print(groupId);
    return this._memoizer.runOnce(() async {
      final customerDetails = await apiService.getCustomerDetails(groupId);
      updateCustomerDetails(customerDetails);
      return customerDetails;
    });
  }


  Widget customerProfileDetails() {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return CardPlaceHolderWithAvatar();
        }
        return Container(
          height: size.height * 0.1,
          width: size.width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  (customerType == "C")
                      ? 'assets/customer/customer_non_individual.svg'
                      : (customerGender == "Female")
                      ? 'assets/customer/profile_image_female.svg'
                      : (customerGender == "Male")
                      ? 'assets/customer/profile_image_male.svg'
                      : 'assets/customer/customer_non_individual.svg',
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(customerName,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Style.Colors.blackTextColor,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        );
      },
      future: getCustomerDetails(widget.groupId),
    );
  }

  Widget customerDataTabs() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return DefaultTabController(
          length: 3,
          child: Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: 32,
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
                                child: Text(tabTitles[0],
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),
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
                                    )),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(tabTitles[2],
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Bold',
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          (customerType == "I")
                              ? CustomerBioData(
                              customerDetails: customerDetailsResponse)
                              : CooporateBioData(
                              customerDetails: customerDetailsResponse),
                          CustomerOverview(
                              customerDetails: customerDetailsResponse),
                          (customerType == "I")
                              ? CustomerTrends(
                              customerDetails: customerDetailsResponse)
                              : CooporateTrends(
                              customerDetails: customerDetailsResponse)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      future: getCustomerDetails(widget.groupId),
    );
  }

  void updateCustomerDetails(CustomerDetailsResponse customerDetails) {
    if (mounted) {
      setState(() {
        customerName = customerDetails.customerName;
        customerGender = customerDetails.customerGender;
        customerType = customerDetails.customerType;
        customerDetailsResponse = customerDetails;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCustomerDetails(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            customerProfileDetails(),
            SizedBox(
              height: 20,
            ),
            customerDataTabs()
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context, false);
          return Future.value(false);
          //returnLanding(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(
            'assets/search/search_back_new.svg',
          ),
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switchPage(index, context);
      },
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              'assets/customer/profile_dashboard.svg',
            ),
          ),
          // ignore: deprecated_member_use
          title: Text("Dashboard",
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.normal)),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset('assets/customer/profile_search.svg',
            ),
          ),
          // ignore: deprecated_member_use
          title: Text("Search",
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.normal)),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset('assets/customer/profile_logout.svg',
            ),
          ),
          // ignore: deprecated_member_use
          title: Text("Logout",
              style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  void switchPage(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        returnLanding(context);
        break;
      case 1:
        returnSearch(context);
        break;
      case 2:
        returnLogin(context);
        break;
    }
  }

  void returnLanding(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
  }

  void returnSearch(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => AlternateSearchPage()));
  }

  void returnLogin(BuildContext context) {
    logoutUser(context);
  }

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }
}

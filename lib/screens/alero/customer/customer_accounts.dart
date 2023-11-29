import 'dart:async';
import 'package:alero/screens/alero/customer/view_accounts.dart';
import 'package:alero/screens/alero/search/alternate_search_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';
import '../../../models/customer/CustomerDetailsResponse.dart';
import '../../../network/AleroAPIService.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'customer_data_tabs.dart';

class CustomerAccounts extends StatefulWidget {
  final String groupId;

  CustomerAccounts({Key key, @required this.groupId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>().setCurrentScreen(screenName: 'Customer Accounts Page');
    return _CustomerAccountsState();
  }
}

class _CustomerAccountsState extends State<CustomerAccounts> {
  var apiService = AleroAPIService();
  String customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse customerDetailsResponse;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<Widget> accountsItem = [];
  var data;
  String customerAccountNo;
  int index;


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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            customerProfileDetails(),
            ViewAllAccounts(widget.groupId, setAccount: (accountNo) {
              setState(() {
                customerAccountNo = accountNo;
              });
            }),
            SizedBox(
              height: 20,
            ),
            CustomerDataTabs(groupId: widget.groupId, customerAccountNo: customerAccountNo)
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














/*
import 'dart:async';
import 'package:alero/models/response/AccountList.dart';
import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:alero/screens/alero/customer/trends/cooporate_trends.dart';
import 'package:alero/screens/alero/customer/trends/customer_trends.dart';
import 'package:alero/screens/alero/search/alternate_search_page.dart';
import 'package:alero/utils/constants.dart';
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

class CustomerAccounts extends StatefulWidget {
  final String groupId;
  final String customerId;

  CustomerAccounts({Key key, @required this.groupId, this.customerId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerAccountsState();
  }
}

class _CustomerAccountsState extends State<CustomerAccounts> {
  var apiService = AleroAPIService();
  String customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse customerDetailsResponse;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<Widget> accountsItem = [];
  var data;
  String customerAccountNo;

  List<String> tabTitles = ["Biodata", "Overview", "Trends"];

  Future getCustomerDetails(String groupId) async {
    print(groupId);
    return this._memoizer.runOnce(() async {
      final customerDetails = await apiService.getCustomerDetails(groupId);
      print(customerDetails);
      updateCustomerDetails(customerDetails);
      return customerDetails;
    });
  }

  Future getBankingData(String customerId) async {
      final accountData = await apiService.getBankingData(customerId);
      List<Widget> _accountsItem = [];
      if (accountData.length == 0) {
        _accountsItem.add(EmptyListItem(message: 'No Customer Accounts'));
      } else {
        accountData.forEach((account) {
          _accountsItem.add(
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerAccounts(groupId: ''),));
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: IconButton(onPressed: () {Navigator.pop(context);},
                            icon: Icon(Icons.view_list), iconSize: 25.0, color: Colors.white70,),),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(account["accountClassName"],style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.normal),),
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(account["accountNumber"], style: TextStyle(
                                  fontSize: 12.0,fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.normal),)),
                          ],
                        )
                      ],
                    ),
                    Divider(thickness: 2),
                  ],
                ),
              ),
            )
          );
        });
      }
      if (mounted) {
        setState(() {
          accountsItem = _accountsItem;
        });
      }
      return accountData;
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
    getBankingData(widget.groupId);
  }

  Widget viewAllAccounts() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return Container(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Row(
              children: [
                Container(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
                  child: Text('All Accounts', style: TextStyle(color: Style.Colors.white),),),
                  decoration: BoxDecoration(
                      color: Style.Colors.buttonColor, borderRadius: BorderRadius.circular(15)),),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Container(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
                      child: Text('View Accounts',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.normal),)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Style.Colors.buttonColor),
                      color: Style.Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),),
                ),
              ],
            ),
          ),
        );
      },
      future: getCustomerDetails(widget.groupId),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 200.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
      ),
      title: Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          child: IconButton(onPressed: () {
            Navigator.pop(context);},
            icon: Icon(Icons.close_outlined), iconSize: 25.0, color: Colors.white70,),
        ),),
      content: Column(
        children: [
          GestureDetector(
            onTap: () {

            },
            child: Row(
              children: [
                CircleAvatar(
                child: IconButton(onPressed: () {Navigator.pop(context);},
                icon: Icon(Icons.view_list), iconSize: 25.0, color: Colors.white70,),),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('All Accounts'),
                    Text('Savings/Current'),
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: accountsItem.length,
                  itemBuilder: (context, index) {
                    return accountsItem[index];
                  }),
            ),
          ),
        ],
      ),
      actions: [],
    );

    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
            viewAllAccounts(),
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

//  Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(10.0),
//         child: GestureDetector(
//           onTap: () {
//             print('Inside AlertDialog inside Row');
//             /*Navigator.push(context, MaterialPageRoute(builder: (
//                 context) => CallManagementPage(userId: '')));*/
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 30.0,
//                       height: 30.0,
//                       child: CircleAvatar(
//                         backgroundImage: AssetImage('assets/images/user.png'),
//                       ),),
//                     SizedBox(width: 8.0),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('All Accounts',
//                           style: TextStyle(color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16.0),),
//                         Text('Current/Savings',
//                           style: TextStyle(color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0),),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Icon(Icons.arrow_forward_ios),
//               ],
//             ),
//           ),
//         ),
//       ),
*/

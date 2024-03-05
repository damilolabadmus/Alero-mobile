

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
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/Pandora.dart';
import 'customer_data_tabs.dart';

class CustomerAccounts extends StatefulWidget {
  final String? groupId;

  CustomerAccounts({Key? key, required this.groupId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>().setCurrentScreen(screenName: 'Customer Accounts Page');
    return _CustomerAccountsState();
  }
}

class _CustomerAccountsState extends State<CustomerAccounts> {
  var apiService = AleroAPIService();
  String? customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse? customerDetailsResponse;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<Widget> accountsItem = [];
  var data;
  String? customerAccountNo;
  int? index;


  Future getCustomerDetails(String? groupId) async {
    print(groupId);
    return this._memoizer.runOnce(() async {
      final customerDetails = await apiService.getCustomerDetails(groupId!);
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
                    child: Text(customerName!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
          // return Future.value(false);
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
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset('assets/customer/profile_search.svg',
            ),
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset('assets/customer/profile_logout.svg',
            ),
          ),
          label: "Logout",
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
    Pandora.logoutUser(context);
  }
}


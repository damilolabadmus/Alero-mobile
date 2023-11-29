import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/customer/CustomerDetailsResponse.dart';
import '../../../../network/AleroAPIService.dart';
import '../../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';

class CustomerBioData extends StatefulWidget {
  final CustomerDetailsResponse customerDetails;

  CustomerBioData({Key key, @required this.customerDetails}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>()
        .setCurrentScreen(screenName: 'Customer Bio Data Page');
    return _CustomerBioDataState();
  }
}

class _CustomerBioDataState extends State<CustomerBioData> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  var data;
  bool loading = true;

  int customerRelationshipAge;

  String customerId = "",
      groupId = "",
      businessSegment = "",
      customerGender = "",
      customerAge = "",
      mobileNumber = "",
      customerEmail = "",
      rmName = "",
      branchName = "",
      identificationType = "",
      occupation = "",
      maritalStatus = "",
      customerAddress = "",
      customerCity = "",
      customerState = "",
      nextOfKinName = "",
      nextOfKinMobileNumber = "",
      isPepCustomer = " ";

  String incompleteData = " ", invalidData = " ";

  void getCustomerDetails() {
    if (mounted) {
      setState(() {
        customerId = data.customerId;
        groupId = data.groupId;
        businessSegment = data.businessSegment.toUpperCase();
        customerRelationshipAge = data.customerRelationshipAge;
        customerGender = data.customerGender;
        customerAge = data.customerAge.toString();
        mobileNumber = data.mobileNumber;
        customerEmail = data.customerEmail;
        rmName = data.rmName;
        branchName = data.branchName;
        identificationType = data.identificationType;
        occupation = data.occupation;
        maritalStatus = data.maritalStatus;
        customerAddress = data.customerAddress;
        customerCity = data.customerCity;
        customerState = data.customerState;
        nextOfKinName = data.nextOfKinName;
        nextOfKinMobileNumber = data.nextOfKinMobileNumber;
        isPepCustomer = data.isPepCustomer;
      });
    }
    getCustomerDataExceptions(groupId);
  }

  Future getCustomerDataExceptions(String groupId) async {
    var exceptionDetails;
    return this._memoizer.runOnce(() async {
      try {
        exceptionDetails = await apiService.getCustomerDataExceptions(groupId);
        if (mounted) {
          setState(() {
            incompleteData = exceptionDetails.incompleteData;
            invalidData = exceptionDetails.invalidData;
          });
        }
      } catch (error) {
        if (error
            .toString()
            .contains(ExceptionTypes.NODATAEXCEPTION.toString())) {
          if (mounted) {
            setState(() {
              incompleteData = '';
              invalidData = '';
            });
          }
        }
      }
      return exceptionDetails;
    });
  }

  void loadData() async {
    if (data == null) {
      data = widget.customerDetails;
      await Future.delayed(const Duration(seconds: 2), () {
        loadData();
      });
    } else {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        color: Style.Colors.tabBackGround,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CardPlaceHolderWithImage(
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: FlutterShimmnerLoadingWidget(
                                count: 2,
                                animate: true,
                                color: Colors.grey[200],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CardPlaceHolderWithImage(
                              height: 200,
                            ),
                            SimpleTextPlaceholder(),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    }
    getCustomerDetails();
    return Container(
      color: Style.Colors.tabBackGround,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Style.Colors.searchActiveBg,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color:
                                            Style.Colors.searchActiveBg)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      child: Text(
                                        businessSegment,
                                        style: TextStyle(
                                          color:
                                          Style.Colors.searchActiveBgText,
                                          fontSize: 9.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins-Regular',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      (customerRelationshipAge < 1)
                                          ? "Customer for less than 1 year"
                                          : "Customer for $customerRelationshipAge years",
                                      style: TextStyle(
                                        color: Style.Colors.blackTextColor,
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                color: Style.Colors.biodataBlue,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/customer/biodata/biodata_gender.svg',
                                                  ),
                                                ),
                                                Text(customerGender,
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                    child: SvgPicture.asset(
                                                      'assets/customer/biodata/biodata_age.svg',
                                                    ),
                                                  ),
                                                  Text('$customerAge years old',
                                                      style: TextStyle(
                                                        color: Style
                                                            .Colors.blackTextColor,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily:
                                                        'Poppins-Regular',
                                                      )),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SvgPicture.asset(
                                              'assets/customer/biodata/biodata_call.svg',
                                            ),
                                          ),
                                          Text(mobileNumber,
                                              style: TextStyle(
                                                color:
                                                Style.Colors.blackTextColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SvgPicture.asset(
                                              'assets/customer/biodata/biodata_mail.svg',
                                            ),
                                          ),
                                          Text(customerEmail,
                                              style: TextStyle(
                                                color:
                                                Style.Colors.blackTextColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                color: Style.Colors.biodataRed,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SvgPicture.asset(
                                              'assets/customer/biodata/biodata_rm.svg',
                                            ),
                                          ),
                                          Text(rmName,
                                              style: TextStyle(
                                                color:
                                                Style.Colors.blackTextColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: SvgPicture.asset(
                                              'assets/customer/biodata/biodata_bank.svg',
                                            ),
                                          ),
                                          Text(branchName,
                                              style: TextStyle(
                                                color:
                                                Style.Colors.blackTextColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                color: Style.Colors.biodataGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/customer/biodata/biodata_id.svg',
                                                  ),
                                                ),
                                                Text('A0-29899888',
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                    child: SvgPicture.asset(
                                                      'assets/customer/biodata/biodata_id.svg',
                                                    ),
                                                  ),
                                                  Text(identificationType,
                                                      style: TextStyle(
                                                        color: Style
                                                            .Colors.blackTextColor,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily:
                                                        'Poppins-Regular',
                                                      )),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/customer/biodata/biodata_profession.svg',
                                                  ),
                                                ),
                                                Text(occupation,
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                    child: SvgPicture.asset(
                                                      'assets/customer/biodata/biodata_relationship.svg',
                                                    ),
                                                  ),
                                                  Text(maritalStatus,
                                                      style: TextStyle(
                                                        color: Style
                                                            .Colors.blackTextColor,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily:
                                                        'Poppins-Regular',
                                                      )),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/customer/biodata/biodata_warning.svg',
                                                  ),
                                                ),
                                                Text('PEP - $isPepCustomer',
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              additionalInformationDialog();
                                            },
                                            highlightColor:
                                            Style.Colors.mainColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                  Style.Colors.buttonColor,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Style
                                                          .Colors.buttonColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                child: Text(
                                                  'Show More',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void additionalInformationDialog() {
    OneContext().showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      builder: (context) => Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)),
            color: Colors.white,
          ),
          height: 510,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text('Additional Information',
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
                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Card(
                            color: Style.Colors.biodataGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: 10),
                                              child: Icon(
                                                EvaIcons.flagOutline,
                                                color: Style.Colors.iconColor,
                                                size: 15.0,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(customerAddress,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: Style
                                                        .Colors.blackTextColor,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                color: Style.Colors.iconColor,
                                                size: 15.0,
                                              ),
                                            ),
                                            Text(customerCity,
                                                style: TextStyle(
                                                  color: Style
                                                      .Colors.blackTextColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins-Regular',
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.location_city_outlined,
                                                  color: Style.Colors.iconColor,
                                                  size: 15.0,
                                                ),
                                              ),
                                              Text(customerState,
                                                  style: TextStyle(
                                                    color: Style.Colors.blackTextColor,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins-Regular',
                                                  )),
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Card(
                            color: Style.Colors.biodataRed,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Next of Kin',
                                                style: TextStyle(
                                                  color: Style
                                                      .Colors.blackTextColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins-Regular',
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: 10),
                                              child: Icon(
                                                EvaIcons.personOutline,
                                                color: Style.Colors.iconColor,
                                                size: 15.0,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(nextOfKinName,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: Style
                                                        .Colors.blackTextColor,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 10),
                                              child: SvgPicture.asset(
                                                'assets/customer/biodata/biodata_call.svg',
                                              ),
                                            ),
                                            Text(nextOfKinMobileNumber,
                                                style: TextStyle(
                                                  color: Style
                                                      .Colors.blackTextColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins-Regular',
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Card(
                            color: Style.Colors.biodataYellow,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Data Exceptions',
                                                style: TextStyle(
                                                  color: Style
                                                      .Colors.blackTextColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins-Regular',
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  loadDataExceptions()
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ) // or OneContext().popDialog('sucess');
      ),
    );
  }

  Widget loadDataExceptions() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Incomplete Data',
                      style: TextStyle(
                        color: Style.Colors.blackTextColor,
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      )),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(incompleteData,
                      softWrap: true,
                      style: TextStyle(
                        color: Style.Colors.blackTextColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      )),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (incompleteData.isEmpty)
                    ? EmptyListItem(message: "No Incomplete Data")
                    : Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Invalid Data',
                      style: TextStyle(
                        color: Style.Colors.blackTextColor,
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      )),
                ),
                SizedBox(
                  height: 4,
                ),
                (invalidData.isEmpty)
                    ? EmptyListItem(message: "No Invalid Data")
                    : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(invalidData,
                      softWrap: true,
                      style: TextStyle(
                        color: Style.Colors.blackTextColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      )),
                )
              ],
            ),
          ],
        );
      },
      future: getCustomerDataExceptions(groupId),
    );
  }
}

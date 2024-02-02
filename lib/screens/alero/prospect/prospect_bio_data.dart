

import 'dart:async';
import 'package:alero/screens/alero/call/call_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/prospect/prospect_bio_data_card.dart';
import 'package:alero/screens/alero/prospect/prospect_edit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import '../../../network/AleroAPIService.dart';
import '../../../style/theme.dart' as Style;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProspectBioData extends StatefulWidget {

  String? prospectId;
  String? keyPromoterName;
  String? prospectName;
  String? prospectAddress;
  String? prospectType;
  String? businessSegment;
  String? productOffered;
  double? customerWalletSize;
  String? contactPersonName;
  String? contactPersonEmail;
  String? contactPersonPhoneNo;
  String? contactPersonAddress = "";
  bool? prospectConverted;
  String? accountNo;
  String? introducerStaffCode = "";

  ProspectBioData(
      this.prospectId,
      this.keyPromoterName,
      this.prospectName,
      this.prospectAddress,
      this.prospectType,
      this.businessSegment,
      this.productOffered,
      this.customerWalletSize,
      this.contactPersonName,
      this.contactPersonEmail,
      this.contactPersonPhoneNo,
      this.contactPersonAddress,
      this.prospectConverted,
      this.accountNo,
      this.introducerStaffCode,
      );


  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>()
        .setCurrentScreen(screenName: 'Prospect Bio Data Page');
    return _ProspectBioDataState(prospectId, keyPromoterName, prospectName, prospectAddress, prospectType, businessSegment, productOffered,
        customerWalletSize, contactPersonName, contactPersonEmail, contactPersonPhoneNo, contactPersonAddress, prospectConverted,
        accountNo, introducerStaffCode);
  }
}

class _ProspectBioDataState extends State<ProspectBioData> {

  String? prospectId;
  String? keyPromoterName;
  String? prospectName;
  String? prospectAddress;
  String? prospectType;
  String? businessSegment;
  String? productOffered;
  double? customerWalletSize;
  String? contactPersonName;
  String? contactPersonEmail;
  String? contactPersonPhoneNo;
  String? contactPersonAddress = "";
  bool? prospectConverted;
  String? accountNo;
  String? introducerStaffCode = "";


  _ProspectBioDataState(
      this.prospectId,
      this.keyPromoterName,
      this.prospectName,
      this.prospectAddress,
      this.prospectType,
      this.businessSegment,
      this.productOffered,
      this.customerWalletSize,
      this.contactPersonName,
      this.contactPersonEmail,
      this.contactPersonPhoneNo,
      this.contactPersonAddress,
      this.prospectConverted,
      this.accountNo,
      this.introducerStaffCode,
      );

  var apiService = AleroAPIService();

  var data;
  bool loading = true;

  void getProspectDetails() {
    if (mounted) {
      setState(() {
        prospectId = data.
        keyPromoterName = data.keyPromoterName;
        prospectName = data.prospectName;
        prospectAddress = data.prospectAddress;
        prospectType = data.prospectType;
        businessSegment = data.businessSegment.toUpperCase();
        productOffered = data.productOffered;
        customerWalletSize = data.customerWalletSize;
        contactPersonName = data.contactPersonName;
        contactPersonEmail = data.contactPersonEmail;
        contactPersonPhoneNo = data.contactPersonPhoneNo;
        prospectConverted = data.prospectConverted;
        accountNo = data.accountNo;
      });
    }
  }

  void loadData() async {
    if (data == null) {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
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
        backgroundColor: Style.Colors.searchActiveBg,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              child: IconButton(
                icon: Icon(
                    Icons.home
                ),
                iconSize: 30.0, onPressed: () {  },
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                            child: Container(
                              width: 50.0,
                              height: 60.0,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/user.png'),
                                  ),
                                ],
                              ),),
                          ),
                          Text(
                            prospectName!,
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ProspectEdit(prospectId , keyPromoterName, prospectName, prospectAddress, prospectType,
                                businessSegment, productOffered, customerWalletSize, contactPersonName, contactPersonEmail, contactPersonPhoneNo,
                                contactPersonAddress, prospectConverted, accountNo, introducerStaffCode)),
                          );},),
                    ],
                  ),

                  ProspectBioDataCard(
                    productOfferedValue: productOffered ?? '',
                    customerWalletSizeValue: customerWalletSize?.toString() ?? '',
                    businessSegmentValue: businessSegment ?? '',
                    contactPersonNameValue: contactPersonName ?? '',
                    contactPersonEmailValue: contactPersonEmail ?? '',
                    keyPromoterNameValue: keyPromoterName ?? '',
                    prospectAddressValue: prospectAddress ?? '',
                    prospectTypeValue: prospectType ?? '',
                    contactPersonPhoneNoValue: contactPersonPhoneNo ?? '',
                    prospectConverted: prospectConverted ?? false,
                    accountNo: accountNo ?? '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CallBottomNavigationBar(),
    );
  }
}

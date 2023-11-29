import 'package:alero/screens/alero/call/call_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/call/call_management_page.dart';
import 'package:alero/screens/alero/prospect/prospect_edit_container.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import '../../../network/AleroAPIService.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ProspectEdit extends StatefulWidget {

  String prospectId;
  String keyPromoterName;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  double customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress = "";
  bool prospectConverted;
  String accountNo;
  bool edit = true;
  String introducerStaffCode = "";

  ProspectEdit(
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
      this.introducerStaffCode);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>()
        .setCurrentScreen(screenName: 'Prospect Edit Page');
    return _ProspectEditState(prospectId,  keyPromoterName, prospectName, prospectAddress, prospectType,
      businessSegment, productOffered, customerWalletSize, contactPersonName, contactPersonEmail,
      contactPersonPhoneNo, contactPersonAddress, prospectConverted, accountNo, introducerStaffCode,);
  }
}

class _ProspectEditState extends State<ProspectEdit> {

  String keyPromoterName;
  String prospectId;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  double customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress = '';
  bool prospectConverted;
  String accountNo;
  String introducerStaffCode = "";

  TextEditingController keyPromoterController;
  TextEditingController prospectNameController;
  TextEditingController prospectAddressController;
  TextEditingController prospectTypeController;
  TextEditingController businessSegmentController;
  TextEditingController productOfferedController;
  TextEditingController customerWalletSizeController;
  TextEditingController contactPersonNameController;
  TextEditingController contactPersonEmailController;
  TextEditingController contactPersonPhoneNoController;
  TextEditingController contactPersonAddressController;
  TextEditingController accountNoController;

  _ProspectEditState(
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
  void initState() {
    super.initState();
    getBusinessSegment();
    keyPromoterController  = new TextEditingController(text:keyPromoterName);
    prospectNameController  = new TextEditingController(text:prospectName);
    prospectAddressController  = new TextEditingController(text: prospectAddress);
    prospectTypeController= new TextEditingController(text: prospectType);
    businessSegmentController = new TextEditingController(text: businessSegment);
    productOfferedController = new TextEditingController(text:productOffered);
    customerWalletSizeController = new TextEditingController(text: customerWalletSize.toString());
    contactPersonNameController = new TextEditingController(text: contactPersonName);
    contactPersonEmailController = new TextEditingController(text: contactPersonEmail);
    contactPersonPhoneNoController = new TextEditingController(text: contactPersonPhoneNo);
    contactPersonAddressController = new TextEditingController(text: contactPersonAddress);
    accountNoController = TextEditingController(text: accountNo);
  }

  var apiService = AleroAPIService();

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
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.black45,
              iconSize: 30.0,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/landing', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.blueGrey,
                height: 170,
                child: Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 200,
                        color: Colors.lightBlue.shade200)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Edit Prospect',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  ),
                ),
              ),
              ProspectEditContainer(
                titleText: 'Prospect Name',
                icon: Icons.person,
                value: prospectName,
                textFormFieldController: prospectNameController,
              ),
              ProspectEditContainer(
                titleText: 'Address',
                icon: Icons.add_location,
                value: prospectAddress,
                textFormFieldController: prospectAddressController,
              ),
              ProspectEditContainer(
                titleText: 'Product Offered',
                icon: Icons.account_tree,
                value: productOffered,
                textFormFieldController: productOfferedController,
              ),
              ProspectEditContainer(
                titleText: 'Prospect Wallet Size',
                icon: Icons.ad_units_outlined,
                value: customerWalletSize.toString(),
                textFormFieldController: customerWalletSizeController,
                keyboardType: TextInputType.number,
              ),
              getDropDownComponent(context, prospectTypes, false),
              businessSegments == null ? Text(''):
              getDropDownComponent(context, businessSegments, true),
              ProspectEditContainer(
                titleText: 'Contact Name',
                icon: Icons.add_location_rounded,
                value: contactPersonName,
                textFormFieldController: contactPersonNameController,
              ),
              prospectPhoneNo(),
              ProspectEditContainer(
                titleText: 'Email Address',
                icon: Icons.email,
                value: contactPersonEmail,
                textFormFieldController: contactPersonEmailController,
              ),
              ProspectEditContainer(
                titleText: 'Introducer\'s Name',
                icon: Icons.person,
                value: keyPromoterName,
                textFormFieldController: keyPromoterController,
              ),
              ProspectEditContainer(
                titleText: 'Account Number (For converted prospect)',
                icon: Icons.border_color,
                value: accountNo,
                textFormFieldController: accountNoController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                child: Text('Update Prospect'),
                onPressed: () async {
                  // keyPromoterController.clear();
                  try {
                    var info = updateProspectDetails();
                    await apiService.updateProspect(info);
                  } catch (e) {
                    print("error $e");
                  }
                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CallBottomNavigationBar(),
    );
  }

  Map updateProspectDetails() {
    return{
      'prospectId': prospectId,
      'keyPromoterName': keyPromoterController.text.toString(),
      'prospectName': prospectNameController.text.toString(),
      'prospectAddress': prospectAddressController.text.toString(),
      'prospectType':prospectTypeController.text,
      'businessSegment': businessSegmentController.text,
      'productOffered': productOfferedController.text.toString(),
      'customerWalletSize': customerWalletSizeController.text.toString(),
      'contactPersonName': contactPersonNameController.text.toString(),
      'contactPersonEmail': contactPersonEmailController.text.toString(),
      'contactPersonPhoneNo': contactPersonPhoneNoController.text.toString(),
      'contactPersonAddress': contactPersonAddressController.text.toString(),
      'prospectConverted': accountNoController?.text == null ? false : accountNoController.text.isEmpty ? false : true,
      'accountNo': accountNoController?.text.toString(),
      'edit': "true",
      'introducerStaffCode': '',
    };}



  List<String> prospectTypes = [
    'Individual',
    'Non individual',
  ];

  List<String> businessSegments;
  getBusinessSegment() async {
    List<String> _businessSegments = await apiService.getProspectBusinessSegments();
    setState(() {
      businessSegments = _businessSegments;
    });
  }

  Text getValue(String value) {
    if (value == null || value.isEmpty) {
      return Text('Select One',
          style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(
          value, style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    }
  }

  ButtonTheme androidDropDown(List<String> dropDownList, bool isBusinessSeg) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.white,
        hint: getValue(isBusinessSeg ? businessSegment : prospectType),
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        items: dropDownList.map(buildBusinessSegmentItem).toList(),
        onChanged: (value) {
          setState(() {
            if(isBusinessSeg) {
              businessSegmentController.text = value;
              businessSegment = value;
            }else{
              prospectType = value;
              prospectTypeController.text = value;
            }
          });
        },
      ),
    );
  }

  CupertinoPicker iOSPicker(List<String> dropDownList, bool isBusinessSeg) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black45,
      itemExtent: 50,
      children: dropDownList.map(buildBusinessSegmentItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          if(isBusinessSeg) {
            businessSegment = businessSegments[value];
          }else{
            prospectType = businessSegments[value];
          }
        });
        final item = businessSegments[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }

  @override
  Widget getDropDownComponent(BuildContext context, List dropDownList, bool isBusinessSeg) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBusinessSeg ?'Business Segment' : 'Prospect Type',
            style: TextStyle(color: Colors.lightBlue, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'poppins-Regular'
            ),
          ),
          Platform.isIOS ?
          iOSPicker(dropDownList,isBusinessSeg):
          androidDropDown(dropDownList,isBusinessSeg),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildBusinessSegmentItem(String item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 5,
                  fontFamily: 'Poppins-Regular',
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid){
      return DropdownMenuItem(
        value: item,
        onTap: () {},
        child: Text(
          item,
          style: TextStyle(height: 0.2,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'Poppins-Regular',
              fontStyle: FontStyle.italic),
        ),
      );
    }
  }

  Widget prospectPhoneNo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.phone,
                    color: Colors.grey.shade600,
                    size: 20.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Flexible(
                    child: Container(
                      height: 10,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: contactPersonPhoneNoController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget closeButton = TextButton(
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CallManagementPage(),),
          );
        }
    );

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 80.0,
        vertical: 220.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(child: Icon(Icons.thumb_up_alt_sharp, size: 35, color: Colors.lightBlueAccent)),
          ),
          Text(
            'You Have Successfully Updated Your Prospect.',
            style: TextStyle(
              fontSize: 15,
              height: 2,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),],),
      actions: [
        closeButton,
      ],
    );

    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

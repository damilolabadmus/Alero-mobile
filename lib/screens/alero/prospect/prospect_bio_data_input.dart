import 'dart:io' show Platform;
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/call/call_management_page.dart';
import 'package:alero/screens/alero/call/customer_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/Pandora.dart';
import 'package:alero/style/theme.dart' as Style;

class ProspectBioDataInput extends StatefulWidget {

  final String prospectId;

  ProspectBioDataInput({Key key, @required this.prospectId}) : super(key: key);

  @override
  _ProspectBioDataInputState createState() => _ProspectBioDataInputState();
}

class _ProspectBioDataInputState extends State<ProspectBioDataInput> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();

  String keyPromoterName;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  String customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress = "";
  bool prospectConverted = false;
  String accountNo;
  String introducerStaffCode = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getBusinessSegment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiService = AleroAPIService();
    return Scaffold(
      appBar: appBar(),
      body: Container(
        color: Colors.blueGrey.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.none,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Prospect",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Enter prospect information to add a prospect.",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, enter prospect\'s name.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          prospectName = value;
                        },
                        labelText: 'Prospect\'s Name',
                        hintText: 'Enter Name',
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        onChanged: (value) {
                          prospectAddress = value;
                        },
                        labelText: 'Address',
                        hintText: 'Enter Address',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, enter prospect\'s address.';
                          }
                          return null;
                        },
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, fill out this field.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          productOffered = value;
                        },
                        labelText: 'Product Offered',
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Pls, fill out this field.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          customerWalletSize = value;
                        },
                        labelText: 'Prospect Wallet Size',
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                      ),
                    ),
                    getDropDownComponent(context, prospectTypes, false),
                    businessSegments == null ? Text('') :
                    getDropDownComponent(context,businessSegments,true),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, fill out this field.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          contactPersonName = value;
                        },
                        labelText: 'Prospect\'s Contact Name',
                        hintText: 'Enter Contact name',
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, enter phone number.';
                          }
                          if (value.length < 9) {
                            return 'Pls, enter a valid phone number.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          contactPersonPhoneNo = value;
                          print(contactPersonPhoneNo);
                        },
                        labelText: 'Phone Number',
                        hintText: 'Enter Phone Number',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, enter email address.';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            return 'Pls, enter a valid email.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          contactPersonEmail = value;
                        },
                        labelText: 'Email Address',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CallTextField(
                        fillColor: Colors.white,
                        onChanged: (value) {
                          keyPromoterName = value;
                        },
                        labelText: 'Introducer\'s Name',
                        textInputAction: TextInputAction.next,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Pls, fill out this field.';
                          }
                          return null;
                        },
                        readOnly: false,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          child: const Text(
                            'Add Prospect',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var info = toAddProspectDetails();
                              apiService.addProspect(info);
                              showAlertDialog(context);
                            } else {
                              print('Unsuccessful.');
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomerBottomNavigationBar(),
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

  toAddProspectDetails() {
    return{
      'keyPromoterName': keyPromoterName,
      'prospectName': prospectName,
      'prospectAddress': prospectAddress,
      'prospectType':prospectType,
      'businessSegment': businessSegment,
      'productOffered': productOffered,
      'customerWalletSize': customerWalletSize.toString(),
      'contactPersonName': contactPersonName,
      'contactPersonEmail': contactPersonEmail,
      'contactPersonPhoneNo': contactPersonPhoneNo,
      'contactPersonAddress': contactPersonAddress,
      'accountNo': accountNo,
      'introducerStaffCodeController': introducerStaffCode,
    };
  }

// From here: Business Segment Dropdown reuse
  List<String> businessSegments;
  getBusinessSegment() async {
    List<String> _businessSegments = await apiService.getProspectBusinessSegments();
    setState(() {
      businessSegments = _businessSegments;
    });
  }

  List<String> prospectTypes = [
    'Individual',
    'Non individual',
  ];

  Text getValue(String value) {
    if (value == null || value.isEmpty) {
      return Text('Select One',
          style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(
          value, style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    }
  }

  ButtonTheme androidDropDown(List<String> dropDownList, bool isBuissnessSeg) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.white,
        hint: getValue(isBuissnessSeg ? businessSegment : prospectType),
        items: dropDownList.map(buildBusinessSegmentItem).toList(),
        onChanged: (value) {
          setState(() {
            if(isBuissnessSeg) {
              businessSegment = value;
            }else{
              prospectType = value;
            }
          });
        },
      ),
    );
  }

  CupertinoPicker iOSPicker(List<String> dropDownList, bool isBuissnessSeg) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildBusinessSegmentItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          if(isBuissnessSeg) {
            businessSegment = businessSegments[value];
          }else{
            prospectType = prospectTypes[value];
          }
        });
        final item = businessSegments[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }

  Widget getDropDownComponent(BuildContext context, List dropDownList, bool isBuissnessSeg) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBuissnessSeg ?'Business Segment' : 'Prospect Type',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ?
          iOSPicker(dropDownList,isBuissnessSeg):
          androidDropDown(dropDownList,isBuissnessSeg),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildBusinessSegmentItem(String item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
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
        horizontal: 30.0,
        vertical: 200.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
                child: Icon(Icons.thumb_up_alt_sharp,
                    size: 35, color: Colors.lightBlueAccent)),
          ),
          SizedBox(height: 20.0),
          Text('Prospect Added Successfully.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),],),
      actions: [
        closeButton
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

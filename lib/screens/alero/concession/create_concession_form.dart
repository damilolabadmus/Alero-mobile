

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/concession/concession_product.dart';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:flutter/material.dart';

import 'create_concession.dart';

class CreateConcessionForm extends StatefulWidget {
  final concessionData;

  CreateConcessionForm({this.concessionData});

  @override
  State<CreateConcessionForm> createState() => _CreateConcessionFormState();
}

class _CreateConcessionFormState extends State<CreateConcessionForm> {
  var apiService = AleroAPIService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? keyPromoterName;
  String? prospectName;
  String? prospectAddress;
  String? prospectType;
  String? businessSegment;
  String? productOffered;
  String? customerWalletSize;
  String? contactPersonName;
  String? contactPersonEmail;
  String? contactPersonPhoneNo;
  String contactPersonAddress = "";
  bool prospectConverted = false;
  String? accountNo;
  String introducerStaffCode = "";

  /*@override
  void initState() {
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade50,
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.blueGrey.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.none,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create New Concession",
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 85,
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 15.0),
                                        child: Align(
                                            child: Icon(Icons.person_outline, color: Colors.white, size: 20)),
                                      ),
                                      Text('Update', style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {}
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Enter customer information to add concession.",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Account Number',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, enter account name.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Account Name',
                            hintText: 'Enter Name',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Customer Number',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Business Segment',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Region',
                            hintText: 'Enter region',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Area',
                            hintText: 'Enter area',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CallTextField(
                            fillColor: Colors.white,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Pls, fill out this field.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            labelText: 'Branch',
                            hintText: 'Enter branch',
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              child: const Text(
                                'Create Concession',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ConcessionProduct()),
                                );                                }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }

  toAddConcessionDetails() {
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
          /*Navigator.push(context, MaterialPageRoute(
            builder: (context) => CreateConcession()),
          );*/
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
          Text('Concession Added Successfully.',
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

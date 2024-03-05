

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/concession/concession_product.dart';
import 'package:flutter/material.dart';

class ConcessionTextFormField extends StatefulWidget {
  final concessionData;

  ConcessionTextFormField({this.concessionData});

  @override
  State<ConcessionTextFormField> createState() => _ConcessionTextFormFieldState();
}

class _ConcessionTextFormFieldState extends State<ConcessionTextFormField> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          key: _formKey,
          child: Container(
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
                        Text(
                          "Create New Concession",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
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
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              child: const Text(
                                'Create Concession',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ConcessionProduct())
                                );}
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
}

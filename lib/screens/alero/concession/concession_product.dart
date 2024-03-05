

import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/concession_covenant.dart';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'concession_bottom_nav_bar.dart';

class ConcessionProduct extends StatefulWidget {
  const ConcessionProduct({Key? key}) : super(key: key);

  @override
  State<ConcessionProduct> createState() => _ConcessionProductState();
}

class _ConcessionProductState extends State<ConcessionProduct> {
  final Pandora pandora = new Pandora();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0, top: 8),
                child: Text(
                  "Concession Product",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CallTextField(
                  fillColor: Colors.white,
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Pls, enter product type.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Product Type',
                  hintText: 'Enter product type',
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
                      return 'Pls, enter concession type.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Concession Type',
                  hintText: 'Enter concession type',
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
                  labelText: 'Category',
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
                  labelText: 'Old rate(%)',
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
                  labelText: 'Proposed rate(%)',
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
                  labelText: 'Current pricing(%)',
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
                  labelText: 'Proposed pricing(%)',
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    child: const Text(
                      'Approve',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConcessionCovenant()));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget closeButton = TextButton(
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          // pandora.displayToast('Concession has been created and waiting for approval', context, Colors.green.shade200);
          Navigator.pop(context);
          /*Navigator.push(context, MaterialPageRoute(
              builder: (context) => ConcessionPage()),
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
          ],),
      actions: [
        closeButton
      ],
      title: Text('Add Approver(s)'),
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

import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/concession_bottom_nav_bar.dart';
import 'package:alero/screens/alero/concession/concession_upload.dart';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:flutter/material.dart';

class ConcessionCovenant extends StatefulWidget {
  const ConcessionCovenant({Key? key}) : super(key: key);

  @override
  State<ConcessionCovenant> createState() => _ConcessionCovenantState();
}

class _ConcessionCovenantState extends State<ConcessionCovenant> {
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
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  "Concession Covenant",
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
                      return 'Pls, enter covenant type.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Covenant Type',
                  hintText: 'Enter covenant type',
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
                  labelText: 'Amount',
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CallTextField(
                  fillColor: Colors.white,
                  validator: (String? value) {
                    if (value == null) return null;
                    if (value.isEmpty) {
                      return 'Pls, enter the frequency.';
                    }
                    if (value.length < 3) {
                      return 'Pls, enter a valid frequency number.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Frequency',
                  hintText: 'Enter Frequency',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
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
                  labelText: 'Start Date',
                  hintText: 'Start Date',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
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
                  labelText: 'End Date',
                  hintText: 'End Date',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
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
                  labelText: 'Liability Impact',
                  hintText: 'Liability Impact',
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
                  labelText: 'Revenue Impact',
                  hintText: 'Revenue Impact',
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
                      return 'Pls, enter concession details.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Concession details',
                  hintText: 'Please enter the details here',
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                ),
              ),
              Text('Customer Pledge and Commitment/Justification', style: TextStyle(fontSize: 14)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CallTextField(
                  fillColor: Colors.white,
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Please, drop a message.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Present',
                  hintText: 'Please drop a message here',
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
                      return 'Pls, drop a message.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: 'Envisioned',
                  hintText: 'Please drop a message here',
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConcessionUpload()));
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}

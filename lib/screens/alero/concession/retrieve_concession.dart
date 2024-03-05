
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;
import '../../../utils/constants.dart';
import '../components/call_app_bar.dart';
import 'concession_bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class RetrieveConcession extends StatefulWidget {
  const RetrieveConcession({Key? key}) : super(key: key);

  @override
  State<RetrieveConcession> createState() => _RetrieveConcessionState();
}

class _RetrieveConcessionState extends State<RetrieveConcession> {
  String? selectedDate;
  DateTime startDate = DateTime.now();
  String bankDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (_datePicker != null && DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      setState(() {
        selectedDate = _datePicker.toIso8601String();
      });
    }}

  @override
  void initState() {
    super.initState();
    _selectDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: CallAppBar(),
      backgroundColor: Style.Colors.elementBack,
      body: Padding(
        padding: EdgeInsets.only(left: 12, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Retrieve Concession',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Please fill the data below to retrieve Customer Concession',
                          style: kBankItemTitle.copyWith(fontSize: 15)),),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 50,
                      width: 160,
                      child: CallTextField(
                        validator: (String? value) {
                          if (value == null) {
                            return 'Nothing has been picked yet.';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                        hintText: selectedDate,
                        suffixIcon: IconButton(
                            icon: Icon(
                              EvaIcons.calendar,
                              color: Style.Colors.buttonColor,
                              size: 25,
                            ),
                            color: Style.Colors.buttonColor,
                            onPressed: () {},
                        ), onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 160,
                      child: CallTextField(
                        validator: (String? value) {
                          if (value == null) {
                            return 'Nothing has been picked yet.';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        readOnly: false,
                        hintText: selectedDate,
                        suffixIcon: IconButton(
                            icon: Icon(
                              EvaIcons.calendar,
                              color: Style.Colors.buttonColor,
                              size: 25,
                            ),
                            color: Style.Colors.buttonColor,
                           onPressed: () {},
                        ), onChanged: (value) {},
                      ),
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by region',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by region';
                        }
                        return null;
                      },
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by state',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by state';
                        }
                        return null;
                      },
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by branch',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by branch';
                        }
                        return null;
                      },
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by area',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by area';
                        }
                        return null;
                      },
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by zone',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by zone';
                        }
                        return null;
                      },
                    ),
                    CallTextField(
                        onChanged: (value) {},
                        hintText: 'Select by business segment',
                      readOnly: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Pls, select by business segment';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {}
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}

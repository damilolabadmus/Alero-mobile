

import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/concession_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ApproveConcession extends StatefulWidget {
  const ApproveConcession({Key? key}) : super(key: key);

  @override
  State<ApproveConcession> createState() => _ApproveConcessionState();
}

class _ApproveConcessionState extends State<ApproveConcession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left:8.0, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Approve Concession",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
              ),
            ),          Container(
           child: Text('These are the list of approvers'),
              // child: SingleChildScrollView(child: ListView.builder(itemBuilder: itemBuilder),),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  child: const Text(
                    'Create Concession',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {}
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}

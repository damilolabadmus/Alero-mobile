import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/approve_concession.dart';
import 'package:alero/screens/alero/concession/concession_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ConcessionUpload extends StatefulWidget {
  const ConcessionUpload({Key key}) : super(key: key);

  @override
  State<ConcessionUpload> createState() => _ConcessionUploadState();
}

class _ConcessionUploadState extends State<ConcessionUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0, top: 8),
              child: Text(
                "Concession Upload",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  child: const Text(
                    'Upload File',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveConcession()));
                  }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}

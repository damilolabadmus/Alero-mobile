import 'package:alero/screens/alero/call/call_management_page.dart';
import 'package:flutter/material.dart';

class DeleteProspectConfirmed extends StatefulWidget {

  const DeleteProspectConfirmed({Key key}) : super(key: key);

  @override
  _DeleteProspectConfirmedState createState() => _DeleteProspectConfirmedState();
}

class _DeleteProspectConfirmedState extends State<DeleteProspectConfirmed> {

  @override
  Widget build(BuildContext context) {

    Widget closeButton = TextButton(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 10),
          child: Text(
            'Close',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CallManagementPage(),),
          );
        });

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
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
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Center(child: Icon(Icons.thumb_up_alt_sharp, size: 35, color: Colors.lightBlueAccent)),
          ),
          Text('Prospect Deleted Successfully.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ],
      ),
      actions: [
        closeButton,
      ],
    );
  }
}

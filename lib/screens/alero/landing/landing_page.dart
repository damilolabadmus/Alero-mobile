import 'package:flutter/material.dart';
import 'landing_body.dart';
import 'package:alero/screens/alero/components/back_logout_header.dart';

class SingleCustomerViewLanding extends StatelessWidget {
  final String rmName;

  SingleCustomerViewLanding({required this.rmName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackLogoutHeader(),
      backgroundColor: Colors.white,
      body: LandingBody(rmName: rmName),
    );
  }
}

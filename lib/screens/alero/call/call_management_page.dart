import 'package:alero/screens/alero/call/call_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/components/back_logout_header.dart';
import 'package:alero/screens/alero/call/call_management_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class CallManagementPage extends StatelessWidget {

  final String userId;

  CallManagementPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BackLogoutHeader(),
      backgroundColor: Style.Colors.elementBack,
      body: CallManagementDashboard(),
      bottomNavigationBar: CallBottomNavigationBar(),
    );
  }
}


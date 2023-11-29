import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/performance/performance_management_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class PerformanceManagementPage extends StatelessWidget {

  final String userId;

  PerformanceManagementPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      backgroundColor: Style.Colors.elementBack,
      body: PerformanceManagementDashboard(),
      bottomNavigationBar: PerformanceBottomNavigationBar(isPl: false),
    );
  }
}

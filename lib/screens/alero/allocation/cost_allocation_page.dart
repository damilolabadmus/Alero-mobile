

import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;
import 'cost-allocation_dashboard.dart';

class CostAllocationPage extends StatelessWidget {
  final String? userId;

  CostAllocationPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Style.Colors.blackTextColor,
            size: 24,
          ),
        ),
        backgroundColor: Style.Colors.searchActiveBg,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.black45,
              iconSize: 30.0,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/landing', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      backgroundColor: Style.Colors.elementBack,
      body: CostAllocationDashboard(),
      bottomNavigationBar: PerformanceBottomNavigationBar(isPl: false),
    );
  }
}

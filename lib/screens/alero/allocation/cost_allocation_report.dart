import 'package:alero/models/performance/CostAllocationTypeResponse.dart';
import 'package:alero/models/response/ExpenseList.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/allocation/cost_report_table_container.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/allocation/cost_allocation_title_container.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CostAllocationReport extends StatefulWidget {
  final String? userId;

  CostAllocationReport({required this.userId});

  @override
  State<CostAllocationReport> createState() => _CostAllocationReportState();
}

class _CostAllocationReportState extends State<CostAllocationReport> {
  Function? search;
  List<CostAllocationTypeResponse> costAllocationReport = [];
  List<ExpenseList> expensePeriod = [];
  var apiService = AleroAPIService();

  Future<List<ExpenseList>> getExpensePeriod() async {
    List<ExpenseList> _expensePeriod = await apiService.getExpensePeriod();
    setState(() {
      expensePeriod = _expensePeriod;
    });
    return _expensePeriod;
  }

  Future<List<CostAllocationTypeResponse>> getCostAllocationReport(String expensePeriod) async {
    List<CostAllocationTypeResponse> _costReport = await apiService.getCostAllocationReportData(expensePeriod);
    setState(() {
      costAllocationReport = _costReport;
    });
    return _costReport;
  }

  @override
  void initState() {
    super.initState();
    getExpensePeriod();
    getCostAllocationReport('202110');
  }

  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 5, right: 5),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                CostAllocationTitleContainer(
                  title: 'Cost Allocation Report',
                  // expensePeriod: expensePeriod[4].period,
                ),
                SizedBox(height: 20),
                Container(
                    child: AllocationReportTableContainer(
                  allocationReport: costAllocationReport,
                )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PerformanceBottomNavigationBar(isPl: false),
    );
  }
}

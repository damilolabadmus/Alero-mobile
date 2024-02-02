

import 'package:alero/models/performance/CostAllocationUploadResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/performance/report_search_controller.dart';
import 'package:flutter/material.dart';
import 'allocation_upload_table_container.dart';

class AllocationUploadSummary extends StatefulWidget {
  final String? userId;

  AllocationUploadSummary({required this.userId});

  @override
  State<AllocationUploadSummary> createState() => _AllocationUploadSummaryState();
}

class _AllocationUploadSummaryState extends State<AllocationUploadSummary> {
  List<CostAllocationUploadResponse> allocationUpload = [];
  Function? search;
  var apiService = AleroAPIService();

  @override
  void initState() {
    super.initState();
    getCostAllocationUpload();
  }

  Future<List<CostAllocationUploadResponse>> getCostAllocationUpload() async {
    List<CostAllocationUploadResponse> _upload = await apiService.getCostAllocationUploadData();
    setState(() {
      allocationUpload = _upload;
    });
    return _upload;
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Cost Allocation Upload',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Regular',
                  ),),
                SizedBox(height: 20),
                Card(
                  elevation: 10,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        ReportSearchController(
                          search: search,
                        ),
                        SizedBox(height: 15),
                        Container(
                            child: AllocationUploadTableContainer(
                             allocationUpload: allocationUpload,
                            )
                        ),
                      ],
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



import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:flutter/material.dart';

class AllocationReportTableContainer extends StatelessWidget {
  final allocationReport;

  AllocationReportTableContainer({this.allocationReport});

  @override
  Widget build(BuildContext context) {
   return Container(
     child: Column(
       children: [
         SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PipelineDealsHeader(title: 'Expense'),
                        PipelineDealsHeader(title: 'Expense Type'),
                        PipelineDealsHeader(title: 'Expense Period'),
                        PipelineDealsHeader(title: 'Expense Position'),
                        PipelineDealsHeader(title: 'Criteria Code'),
                      ],),),),
                Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allocationReport.length,
                      itemBuilder: (context, index) {
                        var allocationItem = allocationReport[index];
                        return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black45,
                                    width: 1.0,
                                  ),),),
                              child: Container(
                                padding: EdgeInsets.only(left: 2.0, right: 3.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PipelineDealsHeader(title: allocationItem.expenseGroup),
                                        PipelineDealsHeader(title: allocationItem.expenseType),
                                        PipelineDealsHeader(title: allocationItem.expensePeriod),
                                        PipelineDealsHeader(title: allocationItem.expensePosition.toString()),
                                        PipelineDealsHeader(title: allocationItem.criteriaCode.toString()),
                                      ],),
                                  ),),
                              )),);}
                  ),
                ),],),
          ),
       ],
     ),
   );/*},
    future: getReport());*/
  }}

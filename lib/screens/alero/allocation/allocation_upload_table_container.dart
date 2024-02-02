

import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:flutter/material.dart';

class AllocationUploadTableContainer extends StatelessWidget {
  final allocationUpload;

  AllocationUploadTableContainer({this.allocationUpload});

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
                        PipelineDealsHeader(title: 'Serial Number'),
                        PipelineDealsHeader(title: 'Batch Id'),
                        PipelineDealsHeader(title: 'Adjustment Count'),
                        PipelineDealsHeader(title: 'Adjustment Value'),
                        PipelineDealsHeader(title: 'Branch Code'),
                      ],),),),
                Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allocationUpload.length,
                      itemBuilder: (context, index) {
                        var uploadItem = allocationUpload[index];
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
                                        PipelineDealsHeader(title: uploadItem.serialNumber.toString()),
                                        PipelineDealsHeader(title: uploadItem.batchId.toString()),
                                        PipelineDealsHeader(title: uploadItem.adjustmentCount.toString()),
                                        PipelineDealsHeader(title: uploadItem.adjustmentValue.toString()),
                                        PipelineDealsHeader(title: uploadItem.runDateString.toString()),
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

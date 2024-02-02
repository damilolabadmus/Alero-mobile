

import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:flutter/material.dart';

class ConcessionTableContainer extends StatelessWidget {
  final concessionData;

  ConcessionTableContainer({this.concessionData});

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
                        PipelineDealsHeader(title: 'Customer Name'),
                        PipelineDealsHeader(title: 'Customer Number'),
                        PipelineDealsHeader(title: 'Customer ID'),
                        PipelineDealsHeader(title: 'Account Class'),
                        PipelineDealsHeader(title: 'Account Category'),
                      ],),),),
                Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      // itemCount: concessionData.length,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        // var concessionItem = concessionData[index];
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
                                        PipelineDealsHeader(title: 'Adegbola Peter'),
                                        PipelineDealsHeader(title: '0168077703'),
                                        PipelineDealsHeader(title: '296474'),
                                        PipelineDealsHeader(title: 'Corporate'),
                                        PipelineDealsHeader(title: 'Individual'),

                                        /*PipelineDealsHeader(title: concessionItem.customeName),
                                        PipelineDealsHeader(title: concessionItem.expenseType),
                                        PipelineDealsHeader(title: concessionItem.expensePeriod),
                                        PipelineDealsHeader(title: concessionItem.expensePosition.toString()),
                                        PipelineDealsHeader(title: concessionItem.criteriaCode.toString()),*/
                                      ],),
                                  ),),
                              )),);}
                  ),
                ),],),
          ),
        ],
      ),
    );
  }
}

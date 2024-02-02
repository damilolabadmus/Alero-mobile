

import 'package:alero/models/call/DealHistoryResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_clickable.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<CompletedDeals> completedStatus = [];
  DealsStatusResponse? completedDeals;
  int? index;

  Future<dynamic> getCompleted() async {
    return this._asyncMemoizer.runOnce(() async {
      var _completed = await apiService.getAllDeals();
      setState(() {
        completedDeals = _completed;
        completedStatus = completedDeals!.result!.completedDeals!.toList();
      });
      print(completedStatus[0].customerName);
    });
  }

  @override
  void initState() {
    super.initState();
    getCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoadingWidget();
          }
          return  completedStatus.isEmpty ?
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            child: Text("You have not added any pipeline deals yet. Click 'New Deal' to add a new pipeline deal",
              style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ) :
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
                        PipelineDealsHeader(title: 'DATE CREATED'),
                        PipelineDealsHeader(title: 'CUSTOMER NAME'),
                        PipelineDealsHeader(title: 'ACCOUNT NUMBER'),
                        PipelineDealsHeader(title: 'CUSTOMER TYPE'),
                        PipelineDealsHeader(title: 'TRANSACTION TYPE'),
                        PipelineDealsHeader(title: ' AMOUNT'),
                        PipelineDealsHeader(title: 'END DATE'),
                        PipelineDealsHeader(title: ' TAT'),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child:ListView.builder(
                      shrinkWrap: true,
                      itemCount: completedStatus.length,
                      itemBuilder: (context, index) {
                        var dealsCompleted = completedStatus[index];
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
                              padding: EdgeInsets.only(left: 3.0, right: 2.0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PipelineDealsHeader(title: DateFormat('MMM d, yyyy').format(dealsCompleted.entryDate!)),
                                        PipelineDealsHeader(title: dealsCompleted.customerName),
                                        dealsCompleted.accountNo == null || dealsCompleted.accountNo!.isEmpty ? DealsUnset(text: 'prospect', color: Colors.blue.shade200, width: 67) : PipelineDealsHeader(title: dealsCompleted.accountNo),
                                        PipelineDealsHeader(title: dealsCompleted.customerType),
                                        PipelineDealsHeader(title: dealsCompleted.transactionType),
                                        PipelineDealsHeader(title: dealsCompleted.currency! + ' ' + dealsCompleted.amount.toString()),
                                        PipelineDealsHeader(title:  DateFormat('MMM d, yyyy').format(dealsCompleted.endDate!)),
                                        PipelineDealsHeader(title: dealsCompleted.turnAroundTime.toString()),
                                      ],
                                    ),
                                    onTap: () async {
                                      await getDealTimeline(index);
                                      showModalBottomSheet(
                                        context: context, shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ), builder: (context) => buildSheet(index),);}
                                ),),
                            ),),
                        );}),),
              ],),);},
        future: getCompleted()
    );
  }

  DealHistoryResponse? dealHistory;
  List<StatusHistory>? historyDate = [];
  HistoryResult? dateCreated;

  Future<dynamic> getDealTimeline(index) async {
    var _dealTimeline = await apiService.getDealStatusHistory(completedStatus[index].pipelineId!);
    setState(() {
      dealHistory = _dealTimeline;
      historyDate = dealHistory!.result!.statusHistory;
      dateCreated = dealHistory!.result;
    });
  }

  Widget buildSheet(index) => Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10, top: 10, bottom: 15),
      child: ListView(
        clipBehavior: Clip.hardEdge,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              child: IconButton(onPressed: () {
                Navigator.pop(context);
              },
                icon: Icon(Icons.close_outlined), iconSize: 25.0, color: Colors.white70,),
            ),
          ),
          SizedBox(height: 10.0),
          Text(completedStatus[index].customerName.toString(),
            style: kBottomSheetName.copyWith(fontSize: 20)),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].totalRevenue!.toInt().toString(),
                    style: kBlueBottomSheetName),
                  Text('TOTAL REVENUE',
                    style: kCompletedTextStyle.copyWith(fontSize: 13)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].grossRevenue!.toInt().toString(),
                    style: kBlueBottomSheetName),
                  Text('GROSS REVENUE',
                    style: kCompletedTextStyle.copyWith(fontSize: 13)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].feesRate!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('FEES RATE',
                    style: kCompletedTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].interestRate!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('INTEREST RATE',
                    style: kCompletedTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].netInterestMargin!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('NET INTEREST MARGIN',
                    style: kCompletedTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(completedStatus[index].tenor.toString() + ' months',
                    style: KCompletedOtherStyle),
                  Text('TENOR',
                    style: kCompletedTextStyle),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
            child: Divider(
              height: 2.0,
              color: Colors.black45,
              thickness: 1.0,
            ),),
          Text('Timeline',
            style: KCompletedOtherStyle.copyWith(fontSize: 20)),
          SizedBox(
            height: 17.0,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: historyDate!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(DateFormat('MMM d, yyyy').format(historyDate![index].timeIn!),
                        style: kCompletedSubName),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text('Updated status to ',
                              style: kBottomSheetSubName,),
                          ),
                          Text(historyDate![index].dealStatus.toString(),
                            style: kBottomSheetSubName.copyWith(fontSize: 10),),
                        ],
                      ),
                    ],
                  );
                } ),),
          SizedBox(
            height: 22.0,
            child: Divider(
              height: 2.0,
              color: Colors.black45,
              thickness: 1.0,
            ),),
          SizedBox(
            height: 17.0,
            child: Row(
              children: [
                Text(DateFormat('MMM d, yyyy').format(dateCreated!.entryDate!), style: kCompletedSubName),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('Pipeline Created',
                    style: kCompletedSubName),
                ),
                Divider(
                  height: 2.0,
                  color: Colors.black45,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
            child: Divider(
              height: 2.0,
              color: Colors.black45,
              thickness: 1.0,
            ),),
        ],
      ),
    ),
  );
}

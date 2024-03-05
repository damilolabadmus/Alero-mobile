

import 'package:alero/models/call/DealHistoryResponse.dart';
import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_clickable.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:alero/screens/alero/pipeline/pipeline_tab_icon.dart';
import 'package:alero/screens/alero/pipeline/update_deals_form.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusUpdatePage extends StatefulWidget {
  final String? searchQuery;

  StatusUpdatePage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _StatusUpdatePageState createState() => _StatusUpdatePageState();
}

class _StatusUpdatePageState extends State<StatusUpdatePage> {

  var apiService = AleroAPIService();
  List<DealsForStatusUpdate>? pendingStatus = [];
  DealsStatusResponse? pendingDeals;

  @override
  void initState() {
    super.initState();
    getPendingStatusUpdate();
  }

  Future<dynamic> getPendingStatusUpdate() async {
    var _statusUpdate = await apiService.getAllDeals();
    setState(() {
      pendingDeals = _statusUpdate;
      pendingStatus = pendingDeals!.result!.dealsForStatusUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoadingWidget();
          }
          return pendingStatus!.isEmpty ?
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5),
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
                        PipelineDealsHeader(title: 'AMOUNT'),
                        PipelineDealsHeader(title: 'EXP DEAL DATE'),
                        PipelineDealsHeader(title: 'STATUS'),
                        PipelineDealsHeader(title: 'UPDATE STATUS'),
                      ],),),),
                Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pendingStatus!.length,
                    itemBuilder: (context, index) {
                      var pendingUpdate = pendingStatus![index];
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
                                      PipelineDealsHeader(title: DateFormat('MMM d, yyyy').format(pendingUpdate.startDate!)),
                                      PipelineDealsHeader(title: pendingUpdate.customerName),
                                      pendingUpdate.accountNo == null || pendingUpdate.accountNo!.isEmpty ? DealsUnset(text: 'prospect', color: Colors.blue.shade200, width: 67) : PipelineDealsHeader(title: pendingUpdate.accountNo),
                                      PipelineDealsHeader(title: pendingUpdate.customerType),
                                      PipelineDealsHeader(title: pendingUpdate.transactionType),
                                      PipelineDealsHeader(title: pendingUpdate.currency! + ' ' + pendingUpdate.amount.toString()),
                                      PipelineDealsHeader(title: DateFormat('MMM d, yyyy').format(pendingUpdate.expectedDealDate!)),
                                      pendingUpdate.status == null || pendingUpdate.status!.isEmpty ? DealsUnset(text: 'unset', color: Colors.amber.shade200, width: 47) :  PipelineDealsHeader(title: pendingUpdate.status),
                                      PipelineTabViewIcon(
                                        onPressed: () {
                                          showAlertDialog(context, index);
                                        },),
                                    ],),
                                  onTap: () async {
                                    await getDealTimeline(index);
                                    showModalBottomSheet(
                                      context: context, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),), builder: (context) => buildSheet(index),);
                                  }),
                            ),),),);
                    },),
                ),
              ],),);
          },
        future: getPendingStatusUpdate()
    );
  }

  DealHistoryResponse? dealHistory;
  List<StatusHistory>? historyDate = [];
  HistoryResult? dateCreated;

  Future<dynamic> getDealTimeline(index) async {
    var _dealTimeline = await apiService.getDealStatusHistory(pendingStatus![index].pipelineId!);
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
            ),),
          SizedBox(height: 10.0),
          Text(pendingStatus![index].customerName.toString(),
            style: kBottomSheetName.copyWith(fontSize: 20.0),),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].totalRevenue!.toInt().toString(),
                      style: kBlueBottomSheetName),
                  Text('TOTAL REVENUE', style: kBottomSheetSubName,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].grossRevenue!.toInt().toString(),
                    style: kBlueBottomSheetName,),
                  Text('GROSS REVENUE',
                    style: kBottomSheetSubName,),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].feesRate!.toInt().toString(),
                    style: kBottomSheetName,),
                  Text('FEES RATE',
                    style: kBottomSheetSubName,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].interestRate!.toInt().toString(),
                    style: kBottomSheetName,),
                  Text('INTEREST RATE',
                    style: kBottomSheetSubName,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].netInterestMargin!.toInt().toString(),
                    style: kBottomSheetName,),
                  Text('NET INTEREST MARGIN',
                    style: kBottomSheetSubName,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pendingStatus![index].tenor.toString() + ' months',
                    style: kBottomSheetName,),
                  Text('TENOR',
                    style: kBottomSheetSubName,),
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
            style: kBottomSheetName.copyWith(fontSize: 20.0),),
          SizedBox(
            height: 17.0,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: historyDate!.length,
                itemBuilder: (context, index2) {
                  return Row(
                    children: [
                      Text(DateFormat('MMM d, yyyy').format(historyDate![index].timeIn!),
                        style: kBottomSheetSubName,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text('Updated status to ' + historyDate![index].dealStatus.toString() + '.',
                          style: kBottomSheetSubName.copyWith(fontSize: 10),),
                      ),],);} ),),
          SizedBox(
            height: 10.0,
            child: Divider(
              height: 2.0,
              color: Colors.black45,
              thickness: 1.0,
            ),
          ),
          SizedBox(
            height: 17.0,
            child: Row(
              children: [
                Text(DateFormat('MMM d, yyyy').format(dateCreated!.entryDate!),
                  style: kBottomSheetSubName,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text('Pipeline Created.',
                    style: kBottomSheetSubName,),
                ),
                Divider(
                  height: 2.0,
                  color: Colors.black45,
                  thickness: 1.0,
                ),
              ],
            ),),
          SizedBox(
            height: 25.0,
            child: Divider(
              height: 2.0,
              color: Colors.black45,
              thickness: 1.0,
            ),),
        ],),),
  );

  // Update deal status alert
  showAlertDialog(BuildContext context, int index) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return UpdateDealForm(pendingStatus: pendingStatus![index]);
      },);
  }
}


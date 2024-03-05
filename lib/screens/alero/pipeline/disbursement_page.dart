

import 'package:alero/models/call/DealHistoryResponse.dart';
import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_clickable.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:alero/screens/alero/pipeline/pipeline_tab_icon.dart';
import 'package:alero/screens/alero/pipeline/update_disburse_form.dart';
import 'package:alero/screens/alero/pipeline/update_status_form.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class DisbursementPage extends StatefulWidget {

  @override
  _DisbursementPageState createState() => _DisbursementPageState();
}

class _DisbursementPageState extends State<DisbursementPage> {
  String? customerName;
  String? prospectName;

  String? pipelineId;
  String? status;
  String? subStatus;
  String? amount;
  String? transactionComment;
  String disbursementType = '';
  double emptyAmount = 0.0;

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<DealsForDisbursement> disbursedStatus = [];
  DealsStatusResponse? disbursementDeals;

  @override
  void initState() {
    super.initState();
    getDisbursement();
  }

  Future<dynamic> getDisbursement() async {
    return this._asyncMemoizer.runOnce(() async {
      var _disbursement = await apiService.getAllDeals();
      setState(() {
        disbursementDeals = _disbursement;
        disbursedStatus = disbursementDeals!.result!.dealsForDisbursement!.toList();
      });
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
          return disbursedStatus.isEmpty ?
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: [
                Text("You have not added any pipeline deals yet. Click 'New Deal' to add a new pipeline deal",
                  style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
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
                        PipelineDealsHeader(title: 'AMOUNT DISBURSED'),
                        PipelineDealsHeader(title: ' STATUS'),
                        PipelineDealsHeader(title: 'UPDATE DISBURSE'),
                        PipelineDealsHeader(title: 'UPDATE STATUS',)
                      ],),),),
                Container(
                  height: 200,
                  child:ListView.builder(
                      shrinkWrap: true,
                      itemCount: disbursedStatus.length,
                      itemBuilder: (context, index) {
                        var dealsForDisbursement = disbursedStatus[index];
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
                                          PipelineDealsHeader(title: DateFormat('MMM d, yyyy').format(dealsForDisbursement.entryDate!)),
                                          PipelineDealsHeader(title: dealsForDisbursement.customerName),
                                          dealsForDisbursement.accountNo == null || dealsForDisbursement.accountNo!.isEmpty ? DealsUnset(text: 'prospect', color: Colors.blue.shade200, width: 67) : PipelineDealsHeader(title: dealsForDisbursement.accountNo),
                                          PipelineDealsHeader(title: dealsForDisbursement.customerType),
                                          PipelineDealsHeader(title: dealsForDisbursement.transactionType),
                                          PipelineDealsHeader(title: dealsForDisbursement.currency! + ' ' + dealsForDisbursement.amount.toString()),
                                          PipelineDealsHeader(title: DateFormat('MMM d, yyyy').format(dealsForDisbursement.expectedDealDate!)),
                                          PipelineDealsHeader(title: dealsForDisbursement.currency! + ' ' + (dealsForDisbursement.disbursedAmount == null ? emptyAmount.toString() : dealsForDisbursement.disbursedAmount.toString())),
                                          dealsForDisbursement.status== null || dealsForDisbursement.status!.isEmpty ? DealsUnset(text: 'unset', color: Colors.amber.shade200, width: 47) :  PipelineDealsHeader(title: dealsForDisbursement.status),
                                          PipelineTabViewIcon(
                                            onPressed: () {
                                              showAlertDialogForDisburse(context, index);
                                            },),
                                          PipelineTabViewIcon(
                                            onPressed: () {
                                              showAlertDialogForStatus(context, index);
                                            },),
                                        ],),
                                      onTap: () async {
                                        await getDealTimeline(index);
                                        showModalBottomSheet(
                                          context: context, shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ), builder: (context) => buildSheet(index),);
                                      }),),
                              )),);}
                  ),),],),);},
        future: getDisbursement()
    );
  }

  DealHistoryResponse? dealHistory;
  List<StatusHistory>? dealStatusHistory = [];
  List<DisbursementHistory>? disbursedHistory = [];
  HistoryResult? dateCreated;

  Future<dynamic> getDealTimeline(index) async {
    var _dealTimeline = await apiService.getDealStatusHistory(disbursedStatus[index].pipelineId!);
    setState(() {
      dealHistory = _dealTimeline;
      dealStatusHistory = dealHistory!.result!.statusHistory;
      disbursedHistory = dealHistory!.result!.disbursementHistory;
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
          Text(disbursedStatus[index].customerName.toString(),
            style: KCompletedOtherStyle.copyWith(fontSize: 20)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].totalRevenue!.toInt().toString(),
                    style: kBlueBottomSheetName),
                  Text('TOTAL REVENUE',
                    style: kDisburseTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].grossRevenue!.toInt().toString(),
                    style: kBlueBottomSheetName),
                  Text('GROSS REVENUE',
                    style: kDisburseTextStyle),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].feesRate!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('FEES RATE',
                    style: kCompletedTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].interestRate!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('INTEREST RATE',
                    style: kCompletedTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].netInterestMargin!.toInt().toString(),
                    style: KCompletedOtherStyle),
                  Text('NET INTEREST MARGIN',
                    style: TextStyle(fontSize: 11,
                        color: Colors.black45, fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w700),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(disbursedStatus[index].tenor.toString() + ' months',
                    style: KCompletedOtherStyle),
                  Text('Tenor',
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
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(DateFormat('MMM d, yyyy').format(disbursedHistory![index].timeIn!),
                    style: kDisburseBlueStyle),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Disbursed ' + disbursedHistory![index].disbursedAmount.toString(),
                      style: kDisburseStyle),
                    Text('Outstanding - ' + disbursedHistory![index].outstandingAmount.toString(),
                      style: kDisburseStyle),
                  ],
                ),
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
          Text('Disbursement History',
            style: KCompletedOtherStyle.copyWith(fontSize: 20)),
          SizedBox(
            height: 17.0,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: dealStatusHistory!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(DateFormat('MMM d, yyyy').format(disbursedHistory![index].timeIn!), style: kCompletedSubName),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text('Updated Disbursement to ',
                              style: kBottomSheetSubName,),
                          ),
                          Text(disbursedHistory![index].disbursementStatus.toString(),
                            style: kBottomSheetSubName.copyWith(fontSize: 10),),
                        ],
                      ),
                    ],
                  );
                } ),),
          SizedBox(
            height: 25.0,
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
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
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
                itemCount: dealStatusHistory!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 20,
                    child: Row(
                      children: [
                        Text(DateFormat('MMM d, yyyy').format(dealStatusHistory![index].timeIn!), style: kCompletedSubName),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text('Updated status to ',
                                style: kBottomSheetSubName,),
                            ),
                            Text(dealStatusHistory![index].dealStatus.toString(),
                              style: kBottomSheetSubName.copyWith(fontSize: 10),),
                          ],
                        ),
                      ],
                    ),
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
        ],),),);

  showAlertDialogForDisburse(BuildContext context, int index) {
    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return UpdateDisburseForm(disbursedStatus: disbursedStatus[index]);
      },
    );
  }

  showAlertDialogForStatus(BuildContext context, int index) {
    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return UpdateStatusForm(disbursedStatus: disbursedStatus[index]);
      },
    );
  }
}


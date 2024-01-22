import 'dart:async';
import 'dart:ui';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/loading_quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'apr_details_page.dart';

class AprDashboardTableContainer extends StatefulWidget {
  final aprData;

  AprDashboardTableContainer({this.aprData});
  @override
  State<AprDashboardTableContainer> createState() => _AprDashboardTableContainerState();
}

class _AprDashboardTableContainerState extends State<AprDashboardTableContainer> {
  bool isColor;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 10), checkDataAndDisplayCard);
  }

  Future<void> checkDataAndDisplayCard() async {
    if (widget.aprData == null || widget.aprData.isEmpty) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded ? Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 8.0,
                    dataRowHeight: 30,
                    headingRowHeight: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    headingRowColor: MaterialStateProperty.all(
                        Colors.blueGrey.shade50),
                    columns: [
                      DataColumn(label: Text('Account \nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Account \nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('\nNrff', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Account \nMaintenance Fee', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Loan \nRelated Fees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('E \nBusiness Fees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Trade \nFees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Fx \nIncome', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Other \nComm Fees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('View \nMore', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    ],
                    rows: [],
                  ),
                ],
              )
          ),
        ),
      ),
    ) : widget.aprData.isEmpty ? LoadingQuotes(title: 'APR') :
      Padding(
      padding: const EdgeInsets.only(right: 2.0, left: 2, bottom: 5),
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 8.0,
            dataRowHeight: 32,
            headingRowHeight: 37,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            headingRowColor: MaterialStateProperty.all(
                Colors.blueGrey.shade50),
            columns: [
              DataColumn(label: Text('Account \nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Account \nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('\nNrff', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Account \nMaintenance Fee', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Loan \nRelated Fees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('E Business \nFees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Trade \nFees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Fx \nIncome', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Other \nComm Fees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('View \nMore', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
            ],
            rows: List.generate(widget.aprData.length, (index) {
              final accountData = widget.aprData[index];
              return DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme
                            .of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      if (index.isOdd) {
                        return Colors.grey.withOpacity(0.15);
                      }
                      return null;
                    }),
                  cells: [
                    DataCell(Text(accountData.accountName, style: kDealsHeaderStyle)),
                    DataCell(Text(accountData.accountNumber, style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.nrff).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.accountMaintenanceFee).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.loanRelatedFees).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.eBusinessFees).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.tradeFees).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.fxIncome).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(accountData.otherCommFees).toString(), style: kDealsHeaderStyle)),
                    DataCell(
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isColor = true;
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    AprDetailsPage(
                                      aprDetails: widget.aprData,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: isColor == true ? Colors.blueGrey.shade300 : Colors.blue.shade400,
                                  borderRadius: BorderRadius.all(Radius.circular(16))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                          Icons.view_compact_outlined,
                                          color: Colors.white70
                                      ),
                                      Text("View More",
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.white70,
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.w700)),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}

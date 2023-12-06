import 'dart:ui';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
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
  int pageIndex;

  @override
  Widget build(BuildContext context) {
    return /*FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Card(child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 10),
                child: Text('Please wait as this might take a while...',
                  style: TextStyle(
                      color: Colors.black54.withOpacity(0.8),
                      fontFamily: 'Poppins-Regular',
                      fontSize: 11),),
              )),
              SizedBox(height: 5),
              ShimmerLoadingWidget()
            ],);
        }
        return widget.aprData == null ?
        Card(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, left: 10.0, bottom: 7.0),
              child: Text("You do not have any data for now.",
                style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ) :*/
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0, left: 2),
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15.0,
                  dataRowHeight: 36,
                  headingRowHeight: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                  columns: [
                    DataColumn(label: Text('Account \nName ₦', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Account \nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('\nNrff', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Account \nMaintenance Fee', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Loan Related \nFees', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
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
                                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                              }
                              if (index.isOdd) {
                                return Colors.grey.withOpacity(0.15);
                              }
                              return null;
                            }),
                        cells: [
                          DataCell(Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            child: SizedBox(width: 70, child: Text(accountData.accountName, style: kDealsHeaderStyle)),
                          )),
                          DataCell(Text(accountData.accountNumber, style: kDealsHeaderStyle)),
                          DataCell(Text(accountData.nrff, style: kDealsHeaderStyle)),
                          DataCell(Text(accountData.accountMaintenanceFee, style: kDealsHeaderStyle)),
                          DataCell(Text(accountData.loanRelatedFees, style: kDealsHeaderStyle)),
                          DataCell(Text(accountData.eBusinessFees, style: kDealsHeaderStyle)),
                          DataCell(Text(Pandora.moneyFormat(accountData.tradeFees.toDouble()).toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(Pandora.moneyFormat(accountData.fxIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(Pandora.moneyFormat(accountData.otherCommFees.toDouble()).toString(), style: kDealsHeaderStyle)),
                          DataCell(
                             GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isColor = true;
                                    pageIndex = 1;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AprDetailsPage(
                                      aprDetails: widget.aprData,
                                  )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(color: isColor == true ? Colors.blueGrey.shade300 : Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                              Icons.view_compact_outlined, color: Colors.white70
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
          ),
        );

/*
  );}
*/
}}

import 'dart:async';
import 'dart:ui';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/loading_quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'cpr_profit_loss_page.dart';

class CprDashboardTableContainer extends StatefulWidget {
  final cprData;
  final Function(bool data) cprDataNotNull;

  CprDashboardTableContainer({this.cprData, this.cprDataNotNull});

  @override
  State<CprDashboardTableContainer> createState() => _CprDashboardTableContainerState();
}

class _CprDashboardTableContainerState extends State<CprDashboardTableContainer> {
  bool isColor;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 5), checkDataAndDisplayCard);
  }

  Future<void> checkDataAndDisplayCard() async {
    if (widget.cprData == null || widget.cprData.isEmpty) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.cprData == null ? Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 15.0,
                    dataRowHeight: 30,
                    headingRowHeight: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    headingRowColor: MaterialStateProperty.all(
                        Colors.blueGrey.shade50),
                    columns: [
                      DataColumn(label: Text('Customer\nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Customer\nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Customer\nType', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('\nRegion', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('\nArea', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('\nBranch', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Actual\nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Average\nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Total\nIncome', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('View\nMore', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    ],
                    rows: [],
                  ),
                ],
              )
          ),
        ),
      ),
    ) : widget.cprData.isEmpty ? LoadingQuotes(title: 'CPR') :
    Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        elevation: 5,
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
                DataColumn(label: Text('Customer\nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Customer\nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Customer\nType', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nRegion', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nArea', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nBranch', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Actual\nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Average\nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Total\nIncome', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('View\nMore', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              ],
              rows: List.generate(widget.cprData.length, (index) {
                final customerData = widget.cprData[index];
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
                      child: SizedBox(width: 70, child: Text(customerData.customerName, style: kDealsHeaderStyle)),
                    )),
                    DataCell(Text(customerData.customerNo, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.customerType, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.region, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.area, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.branchName, style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.actualBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.averageBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isColor = true;
                            widget.cprDataNotNull(true);
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CprProfitAndLossPage(
                              cprProfitAndLoss: widget.cprData,
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
                                    Icon(Icons.view_compact_outlined, color: Colors.white70
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


/*
class CprDashboardTableContainer extends StatefulWidget {
  final cprData;
  // Function pageIndex;

  CprDashboardTableContainer({this.cprData});

  @override
  State<CprDashboardTableContainer> createState() => _CprDashboardTableContainerState();
}

class _CprDashboardTableContainerState extends State<CprDashboardTableContainer> {
  bool isColor;

  @override
  Widget build(BuildContext context) {
    return widget.cprData.isEmpty ? ShimmerLoadingWidget() :
    Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        elevation: 5,
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
                DataColumn(label: Text('Customer \nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Customer \nNumber', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Customer \nType', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nRegion', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nArea', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('\nBranch', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Actual \nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Average \nBalance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('Total \nIncome', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                DataColumn(label: Text('View \nMore', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              ],
              rows: List.generate(widget.cprData.length, (index) {
                final customerData = widget.cprData[index];
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
                      child: SizedBox(width: 70, child: Text(customerData.customerName, style: kDealsHeaderStyle)),
                    )),
                    DataCell(Text(customerData.customerNo, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.customerType, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.region, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.area, style: kDealsHeaderStyle)),
                    DataCell(Text(customerData.branchName, style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.actualBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.averageBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isColor = true;
                            // pageIndex = 1;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CprProfitAndLossPage(
                              cprProfitAndLoss: widget.cprData,
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
      );
  }
}
*/

import 'dart:ui';
import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/empty_details_item.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AprBalanceSheetTableContainer extends StatefulWidget {
  final aprData;

  AprBalanceSheetTableContainer({@required this.aprData});
  @override
  State<AprBalanceSheetTableContainer> createState() => _AprBalanceSheetTableContainerState();
}

class _AprBalanceSheetTableContainerState extends State<AprBalanceSheetTableContainer> {

  bool isHover = false;
  List<AprExcludedTab> balanceSheetData = [];

  Future<List<AprExcludedTab>> getAprBalanceSheetData() async {
    if (widget.aprData != null) {
      List<AprResponse> _aprData = widget.aprData;
      setState(() {
        print('APR BALANCE SHEET =');
        balanceSheetData = _aprData[1].excludedTab;
      });
      return balanceSheetData;
    }
  }

  @override
  void initState() {
    super.initState();
    getAprBalanceSheetData();
  }

  @override
  Widget build(BuildContext context) {
    return widget.aprData == null ? EmptyDetailsItem() :
    Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 13.0,
                dataRowHeight: 36,
                headingRowHeight: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('Category', style: kDisburseBlueStyle)),
                  /* DataCo lumn(label: Text(completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString().length - 1), style: kDisburseBlueStyle)),
                      DataColumn(label: Text(completeTopCprData[1].mainReport[1].currentMonthVariance.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthVariance.keys.toString().length - 1), style: kDisburseBlueStyle)),
                      DataColumn(label: Text(completeTopCprData[1].mainReport[1].currentMonthAchieved.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthAchieved.keys.toString().length - 1), style: kDisburseBlueStyle)),
                      */DataColumn(label: Text('YTD \nActual (₦\'m)', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nBudget (₦\'m)', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nVariance (₦\'m)', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nAchieved (₦\'m)', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('FullYear \nBudget (₦\'m)', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('Run \nRate (₦\'m)', style: kDisburseBlueStyle)),
                ],
                rows: List.generate(balanceSheetData.length, (index) {
                  final accountData = balanceSheetData[index];
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
                        DataCell(Text(widget.aprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                        /*DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthBudget.values.toString()*//*.substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1)*//*, style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthVariance.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthAchieved.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthAchieved.values.toString().length - 1), style: kDealsHeaderStyle)),*/
                        DataCell(Text(Pandora.moneyFormat(accountData.ytDActualValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(accountData.ytDBudgetValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(accountData.variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(accountData.ytDAchieved.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(accountData.fullYearBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(accountData.runRate.toDouble()).toString(), style: kDealsHeaderStyle)),
                      ]);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

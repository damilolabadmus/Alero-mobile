import 'dart:ui';
import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/screens/alero/components/empty_details_item.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AprBalanceSheetTableContainer extends StatefulWidget {
  final aprData;

  AprBalanceSheetTableContainer({@required this.aprData});
  @override
  State<AprBalanceSheetTableContainer> createState() => _AprBalanceSheetTableContainerState();
}

class _AprBalanceSheetTableContainerState extends State<AprBalanceSheetTableContainer> {

  bool isHover = false;
  List<AprExcludedTab> balanceSheetData = [];

  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '\n${DateFormat.MMM().format(date)} ${DateFormat('y').format(date)}';
  }

  @override
  void initState() {
    super.initState();
    getAprBalanceSheetData();
  }

  Future<List<AprExcludedTab>> getAprBalanceSheetData() async {
    if (widget.aprData != null) {
      List<AprResponse> _aprData = widget.aprData;
      setState(() {
        print('APR BALANCE SHEET =');
        balanceSheetData = _aprData[1].excludedTab;
        print(balanceSheetData);
      });
      return balanceSheetData;
    }
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
                  DataColumn(label: Text(balanceSheetData[0].currentMonthBudget.keys.toString(), style: kDisburseBlueStyle)),
                  DataColumn(label: Text(balanceSheetData[0].currentMonthVariance.keys.toString().replaceAll('_', ' ').toString(), style: kDisburseBlueStyle)),
                  DataColumn(label: Text(balanceSheetData[0].currentMonthBudget.keys.toString().replaceAll('_', ' ').toString(), style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nActual (₦\'m)', style: kDisburseBlueStyle)),
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
                        DataCell(Text(widget.aprData[index].mainReport[0].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                        // DataCell(Text(widget.aprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                        DataCell(Text(balanceSheetData[index].currentMonthBudget.values.toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(balanceSheetData[index].currentMonthVariance.values.toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(balanceSheetData[index].currentMonthAchieved.values.toString(), style: kDealsHeaderStyle)),
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

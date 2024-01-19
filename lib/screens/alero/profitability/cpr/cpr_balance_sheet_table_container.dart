import 'dart:ui';
import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/empty_details_item.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CprBalanceSheetTableContainer extends StatefulWidget {
  final cprData;

  CprBalanceSheetTableContainer({@required this.cprData});
  @override
  State<CprBalanceSheetTableContainer> createState() => _CprBalanceSheetTableContainerState();
}

class _CprBalanceSheetTableContainerState extends State<CprBalanceSheetTableContainer> {

  bool isHover = false;
  bool visible = false;
  int dateIndex;

  List<ExcludedTab> balanceSheetData = [];

  Future<List<ExcludedTab>> getCprBalanceSheetData() async {
    List<CprResponse> _cprData = widget.cprData;
    setState(() {
      balanceSheetData = _cprData[1]?.excludedTab;

      String balanceSheetIncomeType = balanceSheetData[1].incomeType.toString();
      String bsCurrentMonthBudgetKey = balanceSheetData[1].currentMonthBudget.keys.toString();
      String bsCurrentMonthBudget = balanceSheetData[1].currentMonthBudget.values.toString();
      String bsCurrentMonthVariance = balanceSheetData[1].currentMonthVariance.values.toString();
      String bsCurrentMonthAchieved = balanceSheetData[1].currentMonthAchieved.values.toString();
      String bsYtDActualValue = balanceSheetData[1].ytDActualValue.toString();
      String bsYtDBudgetValue = balanceSheetData[1].ytDBudgetValue.toString();
      String bsYdtVariance = balanceSheetData[1].variance.toString();
      String bsYtdAchieved = balanceSheetData[1].ytDAchieved.toString();
      String bsFullYearBudget = balanceSheetData[1].fullYearBudget.toString();
      String bsRunRate = balanceSheetData[1].runRate.toString();

      print('The balance sheet incomeType = $balanceSheetIncomeType');
      print('The balance sheet currentMonthBudget_key = $bsCurrentMonthBudgetKey');
      print('The balance sheet currentMonthBudget = $bsCurrentMonthBudget');
      print('The balance sheet currentMonthVariance = $bsCurrentMonthVariance');
      print('The balance sheet currentMonthAchieved = $bsCurrentMonthAchieved');
      print('The balance sheet ytDActualValue = $bsYtDActualValue');
      print('The balance sheet ytDBudgetValue = $bsYtDBudgetValue');
      print('The balance sheet ydtVariance = $bsYdtVariance');
      print('The balance sheet ytdAchieved = $bsYtdAchieved');
      print('The balance sheet fullYearBudget = $bsFullYearBudget');
      print('The balance sheet runRate = $bsRunRate');
    });
    return balanceSheetData;
  }

  @override
  void initState() {
    super.initState();
    getCprBalanceSheetData();
  }

  @override
  Widget build(BuildContext context) {
    return widget.cprData == null ? EmptyDetailsItem() :
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
                      final customerData = balanceSheetData[index];
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
                            DataCell(Text(widget.cprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                            /*DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthBudget.values.toString()*//*.substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1)*//*, style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthVariance.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthAchieved.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthAchieved.values.toString().length - 1), style: kDealsHeaderStyle)),*/
                            DataCell(Text(Pandora.moneyFormat(customerData.ytDActualValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(customerData.ytDBudgetValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(customerData.variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(customerData.ytDAchieved.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(customerData.fullYearBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(customerData.runRate.toDouble()).toString(), style: kDealsHeaderStyle)),
                          ]);
                    }),
                  ),
                ),
              ),
            ),
          ],
        );
/*
      },);
*/
  }
}

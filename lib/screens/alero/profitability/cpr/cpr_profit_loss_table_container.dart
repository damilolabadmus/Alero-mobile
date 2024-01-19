import 'dart:ui';
import 'package:alero/screens/alero/components/empty_details_item.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/material.dart';

import '../singleton.dart';

class CprProfitAndLossTableContainer extends StatefulWidget {
  final cprData;

  CprProfitAndLossTableContainer({this.cprData});

  @override
  State<CprProfitAndLossTableContainer> createState() => _CprProfitAndLossTableContainerState();
}

class _CprProfitAndLossTableContainerState extends State<CprProfitAndLossTableContainer> {

  void setCprSingletonForBalanceSheet(dynamic newData) {
    CprDataSingleton().cprData = newData;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> incomeTypes = [];
    List<dynamic> currentMonthBudgets = [];
    List<dynamic> ytDActualValues = [];
    List<dynamic> currentMonthVariances = [];
    List<dynamic> currentMonthAchieve = [];
    List<dynamic> ytDBudgetValues = [];
    List<dynamic> variances = [];
    List<dynamic> ytDAchieve = [];
    List<dynamic> fullYearBudgets = [];
    List<dynamic> runRates = [];

    for (final cprResponse in widget.cprData ?? []) {
      if (cprResponse.mainReport != null) {
        for (final report in cprResponse.mainReport) {
          final incomeType = report.incomeType;
          final currentMonthBudget = report.currentMonthBudget;
          final currentMonthVariance = report.currentMonthVariance;
          final currentMonthAchieved = report.currentMonthAchieved;
          final ytDActualValue = report.ytDActualValue;
          final ytDBudgetValue = report.ytDBudgetValue;
          final variance = report.variance;

          final ytDAchieved = report.ytDAchieved;
          final fullYearBudget = report.fullYearBudget;
          final runRate = report.runRate;

          incomeTypes.add(incomeType);
          currentMonthBudgets.add(currentMonthBudget);
          currentMonthVariances.add(currentMonthVariance);
          currentMonthAchieve.add(currentMonthAchieved);
          ytDActualValues.add(ytDActualValue);
          ytDBudgetValues.add(ytDBudgetValue);
          variances.add(variance);
          ytDAchieve.add(ytDAchieved);
          fullYearBudgets.add(fullYearBudget);
          runRates.add(runRate);
        }
      }
    }

    return widget.cprData == null ? EmptyDetailsItem() :
    Column(
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12.0,
                dataRowHeight: 36,
                headingRowHeight: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                columns: [
                  DataColumn(label: Text('Category', style: kDisburseBlueStyle)),
                  DataColumn(label: Text(Pandora.keyItemFormat(currentMonthBudgets[1].keys.toString().replaceAll('_', ' ')).toString(), style: kDisburseBlueStyle)),
                  DataColumn(label: Text(currentMonthVariances[1].keys.toString().replaceAll('_', ' ').toString(), style: kDisburseBlueStyle)),
                  DataColumn(label: Text(currentMonthAchieve[1].keys.toString().replaceAll('_', ' '), style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nActual', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nBudget', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nVariance', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('YTD \nAchieved', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('FullYear \nBudget', style: kDisburseBlueStyle)),
                  DataColumn(label: Text('Run \nRate', style: kDisburseBlueStyle)),
                ],
                rows: List.generate(widget.cprData.length, (index) {
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
                      DataCell(Text(incomeTypes[index], style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(currentMonthBudgets[index].values.toString().substring(1, currentMonthBudgets[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(currentMonthVariances[index].values.toString().substring(1, currentMonthVariances[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(currentMonthAchieve[index].values.toString().substring(1, currentMonthAchieve[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(ytDActualValues[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(ytDBudgetValues[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(variances[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(ytDAchieve[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(fullYearBudgets[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                      DataCell(Text(Pandora.moneyFormat(runRates[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                    ]
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


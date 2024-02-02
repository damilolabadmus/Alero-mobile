

import 'dart:ui';
import 'package:alero/screens/alero/components/empty_details_item.dart';
import 'package:alero/screens/alero/profitability/singleton.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/material.dart';

class AprDetailsTableContainer extends StatefulWidget {
  final aprDetails;

  AprDetailsTableContainer({this.aprDetails});

  @override
  State<AprDetailsTableContainer> createState() => _AprDetailsTableContainerState();
}

class _AprDetailsTableContainerState extends State<AprDetailsTableContainer> {

  void setAprSingletonForBalanceSheet(dynamic newData) {
    AprDataSingleton().aprData = newData;
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

    for (final aprResponse in widget.aprDetails ?? []) {
      if (aprResponse.mainReport != null) {
        for (final report in aprResponse.mainReport) {
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

    return widget.aprDetails == null ? EmptyDetailsItem() :
    Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 10.0,
            dataRowHeight: 32,
            headingRowHeight: 37,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            columns: [
              DataColumn(label: Text('Category', style: kDisburseBlueStyle)),
              DataColumn(label: Text(Pandora.keyItemFormat(currentMonthBudgets[0].keys.toString().replaceAll('_', ' ')).toString(), style: kDisburseBlueStyle)),
              DataColumn(label: Text(Pandora.keyItemFormat(currentMonthVariances[0].keys.toString().replaceAll('_', ' ')).toString(), style: kDisburseBlueStyle)),
              DataColumn(label: Text(Pandora.keyItemFormat(currentMonthAchieve[0].keys.toString().replaceAll('_', ' ')).toString(), style: kDisburseBlueStyle)),
              DataColumn(label: Text('YTD \nActual', style: kDisburseBlueStyle)),
              DataColumn(label: Text('YTD \nBudget', style: kDisburseBlueStyle)),
              DataColumn(label: Text('YTD \nVariance', style: kDisburseBlueStyle)),
              DataColumn(label: Text('YTD \nAchieved', style: kDisburseBlueStyle)),
              DataColumn(label: Text('FullYear \nBudget', style: kDisburseBlueStyle)),
              DataColumn(label: Text('Run \nRate', style: kDisburseBlueStyle)),
            ],
            rows: List.generate(widget.aprDetails.length > 0 ? widget.aprDetails.length : [].length, (index) {
              return DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
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
                    DataCell(Text(incomeTypes[index], style: kDealsHeaderStyle)),
                    DataCell(Text(currentMonthBudgets[index].values.toString().substring(1, currentMonthBudgets[index].values.toString().length - 1), style: kDealsHeaderStyle)),
                    DataCell(Text(currentMonthVariances[index].values.toString().substring(1, currentMonthVariances[index].values.toString().length - 1), style: kDealsHeaderStyle)),
                    DataCell(Text(currentMonthAchieve[index].values.toString().substring(1, currentMonthAchieve[index].values.toString().length - 1), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(ytDActualValues[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(ytDBudgetValues[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(variances[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(ytDAchieve[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(fullYearBudgets[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(runRates[index].toDouble()).toString(), style: kDealsHeaderStyle)),
                  ]
              );
            }),
          ),
        ),
      ),
    );}
}


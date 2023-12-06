import 'dart:ui';
import 'package:alero/screens/alero/components/empty_list_item.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isClicked = false;

    List<dynamic> incomeTypes = [];
    List<dynamic> currentMonthBudgets = [];
    List<dynamic> ytD_ACTUAL_VALUES = [];
    List<dynamic> currentMonthVariances = [];
    List<dynamic> currentMonthAchieve = [];
    List<dynamic> ytD_BUDGET_VALUES = [];
    List<dynamic> variances = [];
    List<dynamic> ytD_ACHIEVE = [];
    List<dynamic> full_Year_Budgets = [];
    List<dynamic> runRates = [];

    for (final aprResponse in widget.aprDetails) {
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

          incomeType.add(incomeType);
          currentMonthBudgets.add(currentMonthBudget);
          currentMonthVariances.add(currentMonthVariance);
          currentMonthAchieve.add(currentMonthAchieved);
          ytD_ACTUAL_VALUES.add(ytDActualValue);
          ytD_BUDGET_VALUES.add(ytDBudgetValue);
          variances.add(variance);

          ytD_ACHIEVE.add(ytDAchieved);
          full_Year_Budgets.add(fullYearBudget);
          runRates.add(runRate);
        }
      }
    }

    return widget.aprDetails == null ?
    // return widget.cprData.mainReport == null ?
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: EmptyListItem(message: 'No reports Found.'),
    ) :
    Column(
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 2.0,
                dataRowHeight: 36,
                headingRowHeight: 35,
                columns: [
                  DataColumn(label: Container(
                    width: 67,
                    child: Stack(children: [
                      Positioned(left: 55, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 55, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('Category', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 180,
                    child: Stack(children: [
                      Positioned(left: 156, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 156, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text(currentMonthBudgets[1].keys.toString().substring(1, currentMonthBudgets[1].keys.toString().length - 1), style: kDisburseBlueStyle)),
                      // Container(alignment: Alignment.centerLeft, child: Text(currentMonthBudgets[1].keys.toString().split(' ').map((str) => str + '\n').join(),/*+ ' (₦\'m)',style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 210,
                    child: Stack(children: [
                      Positioned(left: 156, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 156, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text(currentMonthVariances[1].keys.toString().substring(1, currentMonthVariances[1].values.toString().length - 1), style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 210,
                    child: Stack(children: [
                      Positioned(left: 156, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 156, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text(currentMonthAchieve[1].keys.toString().substring(1, currentMonthAchieve[1].values.toString().length - 1), style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 115,
                    child: Stack(children: [
                      Positioned(left: 94, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 94, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('YTD \nActual (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 117,
                    child: Stack(children: [
                      Positioned(left: 76, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 76, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('YTD \nBudget (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 114,
                    child: Stack(children: [
                      Positioned(left: 88, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 88, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('YTD \nVariance (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 112,
                    child: Stack(children: [
                      Positioned(left: 88, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 88, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('YTD \nAchieved (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 110,
                    child: Stack(children: [
                      Positioned(left: 75, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 75, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('FullYear \nBudget (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 123,
                    child: Stack(children: [
                      Positioned(left: 60, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 60, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('Run \nRate (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                ],
                rows: List.generate(ytD_ACTUAL_VALUES.length, (index) {
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
                      onSelectChanged: (isSelected) {
                        setState(() {
                          isClicked = isSelected;
                        });
                      },
                      cells: [
                        DataCell(Text(incomeTypes[index], style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(currentMonthBudgets[index].values.toString().substring(1, currentMonthBudgets[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(currentMonthVariances[index].values.toString().substring(1, currentMonthVariances[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(currentMonthAchieve[index].values.toString().substring(1, currentMonthAchieve[index].values.toString().length - 1), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(ytD_ACTUAL_VALUES[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(ytD_BUDGET_VALUES[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(variances[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(ytD_ACHIEVE[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(full_Year_Budgets[index].toDouble()).toString(), style: incomeTypes[index] == 'Net Interest Income' || incomeTypes[index] == 'Commissions And Fees' ? kCprHeaderStyle : kDealsHeaderStyle)),
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


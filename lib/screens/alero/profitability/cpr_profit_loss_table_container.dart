import 'dart:ui';
import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:flutter/material.dart';

class CprProfitAndLossTableContainer extends StatefulWidget {
  final cprData;

  CprProfitAndLossTableContainer({this.cprData});

  @override
  State<CprProfitAndLossTableContainer> createState() => _CprProfitAndLossTableContainerState();
}

class _CprProfitAndLossTableContainerState extends State<CprProfitAndLossTableContainer> {

  @override
  Widget build(BuildContext context) {
    bool isClicked = false;

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

    for (final cprResponse in widget.cprData) {
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

    return widget.cprData == null ?
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
                rows: List.generate(ytDActualValues.length, (index) {
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
        isClicked == true ? drop() : Text(' Not working...')
      ],
    );
  }
}

Widget drop() {
  return DataTable(columns: [
    DataColumn(label: Text('Category', style: kDisburseBlueStyle)),
    DataColumn(label: Text('Category', style: kDisburseBlueStyle)),
    DataColumn(label: Text('Category', style: kDisburseBlueStyle))
   ],
    rows: List.generate(1, (index) {
      return DataRow(
        cells: [
          DataCell(Text('11')),
          DataCell(Text('12')),
          DataCell(Text('13')),
        ]);}
    ));
}


/*
  Widget subTableWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          columnSpacing: 2.0,
          dataRowHeight: 36,
          headingRowHeight: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
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
              width: 220,
              child: Stack(children: [
                Positioned(left: 196, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                Positioned(left: 196, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                Container(alignment: Alignment.centerLeft, child: Text(widget.cprData[1].mainReport[1].currentMonthBudget.keys.toString().split(' ').map((str) => str + '\n').join(), style: kDisburseBlueStyle)),
              ]),
            )),
          ],
          rows: List.generate(widget.cprData.length, (index) {
            print(widget.cprData);
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
                  child: SizedBox(width: 137, child: Text(widget.cprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                )),
                DataCell(Text(widget.cprData[index].mainReport[1].currentMonthBudget.values.toString().substring(1, widget.cprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
              ]);
          }),
        ),
    );
  }
*/

/*
  Widget cprDropDown() => Container(
    height: 200,
    child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 8.0,
            dataRowHeight: 36,
            headingRowHeight: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
            columns: [
              DataColumn(label: Container(
                width: 82,
                child: Stack(children: [
                  Positioned(left: 55, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 55, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Category', style: kDisburseBlueStyle)),

                ]),
              )),
              DataColumn(label: Container(
                width: 100,
                child: Stack(children: [
                  Positioned(left: 79, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 79, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Budget Value', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 100,
                child: Stack(children: [
                  Positioned(left: 83, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 83, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Variance(₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 100,
                child: Stack(children: [
                  Positioned(left: 85, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 85, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Achieved(₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 115,
                child: Stack(children: [
                  Positioned(left: 96, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 96, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('YTD Actual (₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 115,
                child: Stack(children: [
                  Positioned(left: 100, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 100, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('YTD Budget (₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 128,
                child: Stack(children: [
                  Positioned(left: 111, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 111, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('YTD Variance (₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 128,
                child: Stack(children: [
                  Positioned(left: 114, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 114, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('YTD Achieved (₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
              DataColumn(label: Container(
                width: 115,
                child: Stack(children: [
                  Positioned(left: 87, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 87, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Run Rate (₦\'m)', style: kDisburseBlueStyle)),
                ]),
              )),
            ],
            rows: List.generate(widget.cprData.length, (index) {
              final customerData = widget.cprData[index];
              return DataRow(
                onSelectChanged: (isSelected) {
                  visible = isSelected;
                },
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
                    DataCell(InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: SizedBox(width: 70, child: Text(customerData.customerName, style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                      ),
                      onTap: () {},
                    )),
                    DataCell(Text(Pandora.moneyFormat(customerData.actualBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.averageBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),DataCell(Text(Pandora.moneyFormat(customerData.actualBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.averageBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.totalIncome.toDouble()).toString(), style: kDealsHeaderStyle)),
                    DataCell(Text(Pandora.moneyFormat(customerData.averageBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                 ]);
            }),
          ),
        ),
      ),
    ),
  );
*/

/*
class CprProfitAndLossTableContainer extends StatefulWidget {
  final cprData;

  CprProfitAndLossTableContainer({this.cprData});

  @override
  State<CprProfitAndLossTableContainer> createState() => _CprProfitAndLossTableContainerState();
}

class _CprProfitAndLossTableContainerState extends State<CprProfitAndLossTableContainer> {

  @override
  Widget build(BuildContext context) {
    final List<String> monthKeys = _extractMonthKeys();
    final List<DataColumn> columns = _buildDataColumns(monthKeys);
    // final List<DataRow> rows = _buildDataRows(monthKeys).cast<DataRow>();
    final List<DataRow> rows = _buildDataRows(monthKeys);
    final List<dynamic> ytDActualValues = _extractFieldValues((report) => report.ytDActualValue);
    final List<dynamic> ytDBudgetValues = _extractFieldValues((report) => report.ytDBudgetValue);
    final List<dynamic> incomeTypes = _extractFieldValues((report) => report.incomeType);
    final List<dynamic> variances = _extractFieldValues((report) => report.variance);
    final List<dynamic> ytDAchieve = _extractFieldValues((report) => report.ytDAchieved);
    final List<dynamic> fullYearBudgets = _extractFieldValues((report) => report.fullYearBudget);
    final List<dynamic> runRates = _extractFieldValues((report) => report.runRate);

    return Column(
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
                columnSpacing: 2.0,
                dataRowHeight: 36,
                headingRowHeight: 35,
                columns: [
                  ...columns,
                  DataColumn(label: Text('YTD Actual (₦\'m)')),
                  DataColumn(label: Text('YTD Budget (₦\'m)')),
                  DataColumn(label: Text('Income Type')),
                  DataColumn(label: Text('Variance')),
                  DataColumn(label: Text('YTDAchieve')),
                  DataColumn(label: Text('FullYearBudget')),
                  DataColumn(label: Text('RunRate')),
                ],
                rows: _combineDataRows(rows, ytDActualValues, ytDBudgetValues, incomeTypes, variances, ytDAchieve, fullYearBudgets, runRates),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<String> _extractMonthKeys() {
    if (widget.cprData.isNotEmpty) {
      final firstReport = widget.cprData.first.mainReport.first;
      return firstReport.monthsData.keys.toList();
    }
    return [];
  }

  List<DataColumn> _buildDataColumns(List<String> monthKeys) {
    return monthKeys.map((key) {
      return DataColumn(label: Text(key));
    }).toList();
  }

  List<DataRow> _buildDataRows(List<String> monthKeys) {
    return widget.cprData.map((cprResponse) {
      final report = cprResponse.mainReport.first;
      final monthsData = report.monthsData;

      final List<DataCell> dataCells = monthKeys.map((key) {
        final value = monthsData[key] ?? 0;
        return DataCell(Text(value.toString()));
      }).toList();

      return DataRow(cells: dataCells);
    }).toList();
  }

  List<dynamic> _extractFieldValues(dynamic Function(MainReport) getterFunction) {
    return widget.cprData
        .map((cprResponse) =>
        cprResponse.mainReport.map((report) => getterFunction(report)))
        .expand((element) => element)
        .toList();
  }

  List<DataRow> _combineDataRows(
      List<DataRow> rows,
      List<DataRow> ytDActualValues,
      List<DataRow> ytDBudgetValues,
      List<DataRow> incomeTypes,
      List<DataRow> variances,
      List<DataRow> ytDAchieve,
      List<DataRow> fullYearBudgets,
      List<DataRow> runRates,
      ) {
    return List.generate(rows.length, (index) {
      final dataRow = rows[index];
      return DataRow(
        cells: [
          ...dataRow.cells,
          DataCell(Text(ytDActualValues[index].toString())),
          DataCell(Text(ytDBudgetValues[index].toString())),
          DataCell(Text(incomeTypes[index].toString())),
          DataCell(Text(variances[index].toString())),
          DataCell(Text(ytDAchieve[index].toString())),
          DataCell(Text(fullYearBudgets[index].toString())),
          DataCell(Text(runRates[index].toString())),
        ],
      );
    });
  }
}
*/

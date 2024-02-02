

import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MyBalanceSheetTypeContainer extends StatefulWidget {
  final balanceSheetData;
  final String? selectedStartDate;
  String? previousDate;
  String? monthEndDate;

  MyBalanceSheetTypeContainer({this.balanceSheetData, this.selectedStartDate, this.previousDate, this.monthEndDate});

  @override
  State<MyBalanceSheetTypeContainer> createState() => _MyBalanceSheetTypeContainerState();
}

class _MyBalanceSheetTypeContainerState extends State<MyBalanceSheetTypeContainer> {
  Map productTotals = {};

  @override
    void initState() {
      super.initState();
      productTotals = {};

      widget.balanceSheetData.forEach((item) {
        final product = item.product ?? 'Unknown';
        productTotals.putIfAbsent(product, () => {
          'currentBalance': 0.0,
          'previousBalance': 0.0,
          'variance': 0.0,
          'monthEndBalance': 0.0,
          'monthEndVariance': 0.0,
        });

        productTotals[product]['currentBalance'] += item.currentBalance ?? 0.0;
        productTotals[product]['previousBalance'] += item.previousBalance ?? 0.0;
        productTotals[product]['variance'] += item.variance ?? 0.0;
        productTotals[product]['monthEndBalance'] += item.monthEndBalance ?? 0.0;
        productTotals[product]['monthEndVariance'] += item.monthEndBalance ?? 0.0;
      });
  }

  @override
  Widget build(BuildContext context) {
    String? previousProduct;
    int rowIndex = 0;

    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 8.0,
                dataRowHeight: 30,
                headingRowHeight: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text(widget.selectedStartDate == null ? '(₦\'m)' : widget.selectedStartDate! + '(₦\'m)')),
                  DataColumn(label: Text(widget.previousDate == null ? '(₦\'m)' : widget.previousDate! + '(₦\'m)')),
                  DataColumn(label: Text('DTD Variance (₦\'m)')),
                  DataColumn(label: Text(widget.monthEndDate == null ? '(₦\'m)' : widget.monthEndDate! + '(₦\'m)')),
                  DataColumn(label: Text('MTD Variance (₦\'m)')),
                ],
                  rows: productTotals.keys.map((product) {
                    final displayProduct = product != previousProduct ? product : '';
                    previousProduct = product;
                    final color = rowIndex.isOdd
                        ? Colors.grey.withOpacity(0.15)
                        : null;
                    rowIndex++;
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                          }
                          if (productTotals.length.isOdd) {
                            return Colors.grey.withOpacity(0.15);
                          }
                          return null;
                            }),
                      cells: [
                        DataCell(Text(displayProduct, style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['currentBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['previousBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['variance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndVariance']).toString(), style: kDealsHeaderStyle)),
                      ],
                    );
                  }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






/*/// This to calculate Total Dep, Total Liabilities and Total Loans did not work

import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MyBalanceSheetTypeContainer extends StatefulWidget {
  final balanceSheetData;
  final String selectedStartDate;

  MyBalanceSheetTypeContainer({this.balanceSheetData, this.selectedStartDate});

  @override
  State<MyBalanceSheetTypeContainer> createState() => _MyBalanceSheetTypeContainerState();
}

class _MyBalanceSheetTypeContainerState extends State<MyBalanceSheetTypeContainer> {
  String monthEndDate;
  String previousDate;

  String presentDate;
  DateTime parsedSelectedDate;
  DateTime previousMonth;
  DateTime previousMonthEnd;
  DateTime previousDay;

  Map<String, Map<String, double>> productTotals = {};
  Map<String, Map<String, double>> categoryTotals = {
  'TOTAL DEPOSITS': {
  'currentBalance': 0.0,
  'previousBalance': 0.0,
  'monthEndBalance': 0.0,
  'variance': 0.0,
  },
  'TOTAL LIABILITIES': {
  'currentBalance': 0.0,
  'previousBalance': 0.0,
  'monthEndBalance': 0.0,
  'variance': 0.0,
  },
  'TOTAL LOANS': {
  'currentBalance': 0.0,
  'previousBalance': 0.0,
  'monthEndBalance': 0.0,
    'variance': 0.0,
  },
  };

  @override
  void initState() {
    super.initState();

    productTotals = {};
    categoryTotals = {
      'TOTAL DEPOSITS': {
    'currentBalance': 0.0,
    'previousBalance': 0.0,
    'monthEndBalance': 0.0,
    'variance': 0.0,
    'monthEndVariance': 0.0,
    },
      'TOTAL LIABILITIES': {
        'currentBalance': 0.0,
        'previousBalance': 0.0,
        'monthEndBalance': 0.0,
        'variance': 0.0,
        'monthEndVariance': 0.0,
      },
      'TOTAL LOANS': {
        'currentBalance': 0.0,
        'previousBalance': 0.0,
        'monthEndBalance': 0.0,
        'variance': 0.0,
        'monthEndVariance': 0.0,
      },
    };

    // Calculate the totals based on product and attribute
    widget.balanceSheetData.forEach((item) {
      final product = item.product ?? 'Unknown'; // Default to 'Unknown' if product is null
      productTotals.putIfAbsent(product, () => {
        'currentBalance': 0.0,
        'previousBalance': 0.0,
        'monthEndBalance': 0.0,
        'variance': 0.0,
        'monthEndVariance': 0.0,
      });

      productTotals[product]['currentBalance'] += item.currentBalance ?? 0.0;
      productTotals[product]['previousBalance'] += item.previousBalance ?? 0.0;
      productTotals[product]['monthEndBalance'] += item.monthEndBalance ?? 0.0;
      productTotals[product]['variance'] += item.variance ?? 0.0;
      productTotals[product]['monthEndVariance'] += item.monthEndVariance ?? 0.0;

      // Calculate category totals
      if (product == 'CURRENT' ||
          product == 'SAVINGS' ||
          product == 'CASA_DOM' ||
          product == 'DOM' ||
          product == 'TIME' ||
          product == 'INT_PAYABLE') {
        categoryTotals['TOTAL DEPOSITS']['currentBalance'] +=
            item.currentBalance ?? 0.0;
        categoryTotals['TOTAL DEPOSITS']['previousBalance'] +=
            item.previousBalance ?? 0.0;
        categoryTotals['TOTAL DEPOSITS']['monthEndBalance'] +=
            item.monthEndBalance ?? 0.0;
        categoryTotals['TOTAL DEPOSITS']['variance'] += item.variance ?? 0.0;
        categoryTotals['TOTAL DEPOSITS']['monthEndVariance'] += item.monthEndVariance ?? 0.0;
      } else if (product == 'LC_MARGIN_LCY' ||
          product == 'INT_RECEIVABLE' ||
          product == 'TERM_LOANS' ||
          product == 'LEASES' ||
          product == 'OVERDRAFT' ||
          product == 'STF') {
        categoryTotals['TOTAL LIABILITIES']['currentBalance'] +=
            item.currentBalance ?? 0.0;
        categoryTotals['TOTAL LIABILITIES']['previousBalance'] +=
            item.previousBalance ?? 0.0;
        categoryTotals['TOTAL LIABILITIES']['monthEndBalance'] +=
            item.monthEndBalance ?? 0.0;
        categoryTotals['TOTAL LIABILITIES']['variance'] += item.variance ?? 0.0;
        categoryTotals['TOTAL LIABILITIES']['monthEndVariance'] += item.monthEndVariance ?? 0.0;
      } else if (product == 'TERM_LOANS_FCY' ||
          product == 'DEVBANK' ||
          product == 'LC_MARGIN_FCY' ||
          product == 'COLLECTION' ||
          product == 'COL_DEP' ||
          product == 'OVERDRAFT_FCY' ||
          product == 'ITF_LOANS' ||
          product == 'INTERVENTION_LOANS') {
        categoryTotals['TOTAL LOANS']['currentBalance'] +=
            item.currentBalance ?? 0.0;
        categoryTotals['TOTAL LOANS']['previousBalance'] +=
            item.previousBalance ?? 0.0;
        categoryTotals['TOTAL LOANS']['monthEndBalance'] +=
            item.monthEndBalance ?? 0.0;
        categoryTotals['TOTAL LOANS']['variance'] += item.variance ?? 0.0;
        categoryTotals['TOTAL LOANS']['monthEndVariance'] += item.monthEndVariance ?? 0.0;
      }
    });
  }

  void getDate() {
    parsedSelectedDate = DateFormat('dd-MM-yyyy').parse(widget.selectedStartDate);
    presentDate = DateFormat('dd-MMM-yyyy').format(parsedSelectedDate);
    previousMonth = DateTime(parsedSelectedDate.year, parsedSelectedDate.month - 1, parsedSelectedDate.day);
    previousMonthEnd = DateTime(previousMonth.year, previousMonth.month + 1, 0);
    previousDay = DateTime(parsedSelectedDate.year, parsedSelectedDate.month, parsedSelectedDate.day - 1);
    setState(() {
      previousDate = DateFormat('dd-MMM-yyyy').format(previousDay);
      monthEndDate = DateFormat('dd-MMM-yyyy').format(previousMonthEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    String previousProduct;

    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 8.0,
                dataRowHeight: 30,
                headingRowHeight: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text(presentDate == null ? '("₦\'m)' : presentDate + '("₦\'m)')),
                  DataColumn(label: Text(previousDate == null ? '("₦\'m)' : previousDate + '("₦\'m)')),
                  DataColumn(label: Text('DTD Variance ("₦\'m)')),
                  DataColumn(label: Text(monthEndDate == null ? '("₦\'m)' : monthEndDate + '("₦\'m)')),
                  DataColumn(label: Text('MTD Variance ("₦\'m)')),
                ],
                  rows: productTotals.keys.map((product) {
                    final displayProduct = product != previousProduct ? product : '';
                    previousProduct = product;
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
                            if (productTotals.length.isOdd) {
                              return Colors.grey.withOpacity(0.15);
                            }
                            return null;
                          }),
                      cells: [
                        DataCell(Text(displayProduct, style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['currentBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['previousBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['variance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndVariance']).toString(), style: kDealsHeaderStyle)),
                      ],
                    );
                  }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/


/*class _MyBalanceSheetTypeContainerState extends State<MyBalanceSheetTypeContainer> {
  String monthEndDate;
  String previousDate;

  String presentDate;
  DateTime parsedSelectedDate;
  DateTime previousMonth;
  DateTime previousMonthEnd;
  DateTime previousDay;

  Map<String, double> totalCurrentBalanceMap = {};
  Map<String, double> totalPreviousBalanceMap = {};
  Map<String, double> totalVarianceMap = {};
  Map<String, double> totalMonthEndBalanceMap = {};
  Map<String, double> totalMonthEndVarianceMap = {};

  /*double totalPreviousBalance = 0.0;
  double totalCurrentBalance = 0.0;
  double totalVariance = 0.0;
  double totalMonthEndBalance = 0.0;
  double totalMonthEndVariance = 0.0;

  double totalProducts = 0.0;
  double totalLiabilities = 0.0;
  double totalLoans = 0.0;*/

   /// This is showing all table contents with the totals but the product key and value not included

  List<DataRow> buildRows(BuildContext context) {
    List<DataRow> rows = [];

    List<List<String>> productGroups = [
      ["SAVINGS", "CURRENT", "TIME", "DOM", "CASA_DOM", "INT_PAYABLE"],
      ["LC_MARGIN_LCY", "LC_MARGIN_FCY", "COLLECTION", "COL_DEP"],
      ["INT_RECEIVABLE", "OVERDRAFT", "DEVBANK", "LEASES", "STF", "TERM_LOANS", "TERM_LOANS_FCY", "ITF_LOANS", "OVERDRAFT_FCY", "INTERVENTION_LOANS"],
    ];

    Map<String, double> totalCurrentBalanceMap = {};
    Map<String, double> totalPreviousBalanceMap = {};
    Map<String, double> totalVarianceMap = {};
    Map<String, double> totalMonthEndBalanceMap = {};
    Map<String, double> totalMonthEndVarianceMap = {};


    for (var data in widget.balanceSheetData) {
      if (!totalCurrentBalanceMap.containsKey(data.product)) {
        totalCurrentBalanceMap[data.product] = 0.0;
        totalPreviousBalanceMap[data.product] = 0.0;
        totalVarianceMap[data.product] = 0.0;
        totalMonthEndBalanceMap[data.product] = 0.0;
        totalMonthEndVarianceMap[data.product] = 0.0;
      }

      totalCurrentBalanceMap[data.product] += data.currentBalance;
      totalPreviousBalanceMap[data.product] += data.previousBalance;
      totalVarianceMap[data.product] += data.variance;
      totalMonthEndBalanceMap[data.product] += data.monthEndBalance;
      totalMonthEndVarianceMap[data.product] += data.monthEndVariance;
    }

    totalCurrentBalanceMap.forEach((product, currentBalance) {
      var previousBalance = totalPreviousBalanceMap[product];
      var variance = totalVarianceMap[product];
      var monthEndBalance = totalMonthEndBalanceMap[product];
      var monthEndVariance = totalMonthEndVarianceMap[product];

      rows.add(createDataRow(product, previousBalance, currentBalance, variance, monthEndBalance, monthEndVariance));
    });

    double totalProducts = calculateTotalForProductGroup(productGroups[0], totalCurrentBalanceMap);
    double totalLiabilities = calculateTotalForProductGroup(productGroups[1], totalCurrentBalanceMap);
    double totalLoans = calculateTotalForProductGroup(productGroups[2], totalCurrentBalanceMap);

    rows.add(createTotalDataRow("Total Products", totalProducts));
    rows.add(createTotalDataRow("Total Liabilities", totalLiabilities));
    rows.add(createTotalDataRow("Total Loans", totalLoans));

    return rows;
  }

  void calculateAndDisplayTotals(List<MyBalanceSheetTypeResponse> balanceSheetData) {
    double totalPreviousBalance = 0.0;
    double totalCurrentBalance = 0.0;
    double totalVariance = 0.0;
    double totalMonthEndBalance = 0.0;
    double totalMonthEndVariance = 0.0;
    List<DataRow> rows = [];

    for (var data in widget.balanceSheetData) {
      totalPreviousBalance += data.previousBalance;
      totalCurrentBalance += data.currentBalance;
      totalVariance += data.variance;
      totalMonthEndBalance += data.monthEndBalance;
      totalMonthEndVariance += data.monthEndVariance;

      rows.add(DataRow(
          cells: [
      DataCell(Text(data.previousBalance.toString())),
        DataCell(Text(data.currentBalance.toString())),
        DataCell(Text(data.variance.toString())),
        DataCell(Text(data.monthEndBalance.toString())),
        DataCell(Text(data.monthEndVariance.toString())),
      ],
      ));
    }

    CalculateResult(totalPreviousBalance, totalCurrentBalance, totalVariance, totalMonthEndBalance, totalMonthEndVariance, rows);
  }

  double calculateTotalForProductGroup(List<String> productGroup, Map<String, double> totalCurrentBalanceMap) {
    double total = 0.0;

    for (var product in productGroup) {
      if (totalCurrentBalanceMap.containsKey(product)) {
        total += totalCurrentBalanceMap[product];
      }
    }

    return total;
  }

  DataRow createDataRow(String product, double previousBalance, double currentBalance, double variance, double monthEndBalance, double monthEndVariance) {
    return DataRow(
      cells: [
        DataCell(Text(previousBalance.toString())),
        DataCell(Text(currentBalance.toString())),
        DataCell(Text(variance.toString())),
        DataCell(Text(monthEndBalance.toString())),
        DataCell(Text(monthEndVariance.toString())),
      ],
    );
  }

  DataRow createTotalDataRow(String label, double total) {
    return DataRow(
      cells: [
        DataCell(Text(
          label, // Make the label bold
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          total.toString(), // Make the total value bold
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
      ],
    );
  }



  @override
    void initState() {
      super.initState();
      getDate();
  }

  void getDate() {
    parsedSelectedDate = DateFormat('dd-MM-yyyy').parse(widget.selectedStartDate);
    presentDate = DateFormat('dd-MMM-yyyy').format(parsedSelectedDate);
    previousMonth = DateTime(parsedSelectedDate.year, parsedSelectedDate.month - 1, parsedSelectedDate.day);
    previousMonthEnd = DateTime(previousMonth.year, previousMonth.month + 1, 0);
    previousDay = DateTime(parsedSelectedDate.year, parsedSelectedDate.month, parsedSelectedDate.day - 1);
    setState(() {
      previousDate = DateFormat('dd-MMM-yyyy').format(previousDay);
      monthEndDate = DateFormat('dd-MMM-yyyy').format(previousMonthEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10.0,
                dataRowHeight: 30,
                headingRowHeight: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  // DataColumn(label: Text('Category')),
                  DataColumn(label: Text(presentDate == null ? '("₦\'m)' : presentDate + '("₦\'m)')),
                  DataColumn(label: Text(previousDate == null ? '("₦\'m)' : previousDate + '("₦\'m)')),
                  DataColumn(label: Text('DTD Variance ("₦\'m)')),
                  DataColumn(label: Text(monthEndDate == null ? '("₦\'m)' : monthEndDate + '("₦\'m)')),
                  DataColumn(label: Text('MTD Variance ("₦\'m)')),
                ],
                rows: buildRows(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculateResult {
    double totalPreviousBalance;
    double totalCurrentBalance;
    double totalVariance;
    double totalMonthEndBalance;
    double totalMonthEndVariance;
    List<DataRow> rows;

    CalculateResult(this.totalPreviousBalance, this.totalCurrentBalance, this.totalVariance, this.totalMonthEndBalance, this.totalMonthEndVariance, this.rows);
  }*/


/* /// This is looping all and not seen but then Shows key and value Total Products, Total Liabilities, Total Loans

List<DataRow> buildRows(BuildContext context) {
      List<DataRow> rows = [];

      List<List<String>> productGroups = [
        ["SAVINGS", "CURRENT", "TIME", "DOM", "CASA_DOM", "INT_PAYABLE"],
        ["LC_MARGIN_LCY", "LC_MARGIN_FCY", "COLLECTION", "COL_DEP"],
        ["INT_RECEIVABLE", "OVERDRAFT", "DEVBANK", "LEASES", "STF", "TERM_LOANS", "TERM_LOANS_FCY", "ITF_LOANS", "OVERDRAFT_FCY", "INTERVENTION_LOANS"],
      ];

      for (var group in productGroups) {
        var result = calculateAndDisplayTotals(group);
        rows.addAll(result.rows);

        for (var product in group) {
          if (!totalCurrentBalanceMap.containsKey(product)) {
            totalCurrentBalanceMap[product] = 0.0;
          }
          if (!totalPreviousBalanceMap.containsKey(product)) {
            totalPreviousBalanceMap[product] = 0.0;
          }
          if (!totalVarianceMap.containsKey(product)) {
            totalVarianceMap[product] = 0.0;
          }
          if (!totalMonthEndBalanceMap.containsKey(product)) {
            totalMonthEndBalanceMap[product] = 0.0;
          }
          if (!totalMonthEndVarianceMap.containsKey(product)) {
            totalMonthEndVarianceMap[product] = 0.0;
          }

      totalCurrentBalanceMap[product] += result.totalCurrentBalance;
      totalPreviousBalanceMap[product] += result.totalPreviousBalance;
      totalVarianceMap[product] += result.totalVariance;
      totalMonthEndBalanceMap[product] += result.totalMonthEndBalance;
      totalMonthEndVarianceMap[product] += result.totalMonthEndVariance;
    }
  }

    totalCurrentBalanceMap.forEach((product, total) {
    rows.add(createDataRow(product, total, "Current Balance"));
    });

    totalPreviousBalanceMap.forEach((product, total) {
    rows.add(createDataRow(product, total, "Previous Balance"));
    });

    totalVarianceMap.forEach((product, total) {
    rows.add(createDataRow(product, total, "Variance"));
    });

    totalMonthEndBalanceMap.forEach((product, total) {
      rows.add(createDataRow(product, total, "Month End Balance"));
    });

    totalMonthEndVarianceMap.forEach((product, total) {
      rows.add(createDataRow(product, total, "Month End Variance"));
    });

    double totalProducts = calculateTotalForProductGroup(productGroups[0]);
    double totalLiabilities = calculateTotalForProductGroup(productGroups[1]);
    double totalLoans = calculateTotalForProductGroup(productGroups[2]);

    rows.add(createTotalDataRow("Total Products", totalProducts));
    rows.add(createTotalDataRow("Total Liabilities", totalLiabilities));
    rows.add(createTotalDataRow("Total Loans", totalLoans));

    return rows;
  }


    CalculateResult calculateAndDisplayTotals(List<String> productTypes) {
      List<DataRow> rows = [];

      double totalPreviousBalance = 0.0;
      double totalCurrentBalance = 0.0;
      double totalVariance = 0.0;
      double totalMonthEndBalance = 0.0;
      double totalMonthEndVariance = 0.0;

      for (var data in widget.balanceSheetData) {
        if (productTypes.contains(data.product)) {
          totalPreviousBalance += data.previousBalance;
          totalCurrentBalance += data.currentBalance;
          totalVariance += data.variance;
          totalMonthEndBalance += data.monthEndBalance;
          totalMonthEndVariance += data.monthEndVariance;

    if(!uniqueProductNames.contains(data.product)) {
      uniqueProductNames.add(data.product);
      rows.add(DataRow(
        cells: [
          // DataCell(Text(data.product)),
          DataCell(Text(data.previousBalance.toString())),
          DataCell(Text(data.currentBalance.toString())),
          DataCell(Text(data.variance.toString())),
          DataCell(Text(data.monthEndBalance.toString())),
          DataCell(Text(data.monthEndVariance.toString())),
      ],
    ));
    }
  }
}
return CalculateResult(totalPreviousBalance, totalCurrentBalance, totalVariance, totalMonthEndBalance, totalMonthEndVariance, rows);
}

    double calculateTotalForProductGroup(List<String> productGroup) {
    double total = 0.0;

    for (var product in productGroup) {
      if (totalCurrentBalanceMap.containsKey(product)) {
        total += totalCurrentBalanceMap[product];
      }
    }

    return total;
  }

    DataRow createDataRow(String product, double total, String label) {
          return DataRow(
            cells: [
              DataCell(Text(product, style: kMyBalanceSheetHeaderStyle)),
              DataCell(Text(total.toString(), style: kMyBalanceSheetHeaderStyle)),
              DataCell(Text(label)),
              DataCell(Text("")),
              DataCell(Text("")),
            ],
          );
        }

    DataRow createTotalDataRow(String label, double total) {
    return DataRow(
      cells: [
        DataCell(Text(label, style: kMyBalanceSheetHeaderStyle)),
        DataCell(Text(total.toString(), style: kMyBalanceSheetHeaderStyle)),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
      ],
    );
  }*/


/*class _MyBalanceSheetTypeContainerState extends State<MyBalanceSheetTypeContainer> {
  String monthEndDate;
  String previousDate;

  String presentDate;
  DateTime parsedSelectedDate;
  DateTime previousMonth;
  DateTime previousMonthEnd;
  DateTime previousDay;

  Map<String, Map<String, double>> productTotals = {};


  @override
    void initState() {
      super.initState();
      getDate();
      productTotals = {};

      // Calculate the totals based on product and attribute
      widget.balanceSheetData.forEach((item) {
        final product = item.product ?? 'Unknown'; // Default to 'Unknown' if product is null
        productTotals.putIfAbsent(product, () => {
          'currentBalance': 0.0,
          'previousBalance': 0.0,
          'monthEndBalance': 0.0,
          'variance': 0.0,
        });

        productTotals[product]['currentBalance'] += item.currentBalance ?? 0.0;
        productTotals[product]['previousBalance'] += item.previousBalance ?? 0.0;
        productTotals[product]['monthEndBalance'] += item.monthEndBalance ?? 0.0;
        productTotals[product]['variance'] += item.variance ?? 0.0;
      });
  }

  void getDate() {
    parsedSelectedDate = DateFormat('dd-MM-yyyy').parse(widget.selectedStartDate);
    presentDate = DateFormat('dd-MMM-yyyy').format(parsedSelectedDate);
    previousMonth = DateTime(parsedSelectedDate.year, parsedSelectedDate.month - 1, parsedSelectedDate.day);
    previousMonthEnd = DateTime(previousMonth.year, previousMonth.month + 1, 0);
    previousDay = DateTime(parsedSelectedDate.year, parsedSelectedDate.month, parsedSelectedDate.day - 1);
    setState(() {
      previousDate = DateFormat('dd-MMM-yyyy').format(previousDay);
      monthEndDate = DateFormat('dd-MMM-yyyy').format(previousMonthEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    String previousProduct;

    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10.0,
                dataRowHeight: 30,
                headingRowHeight: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text(presentDate == null ? '("₦\'m)' : presentDate + '("₦\'m)')),
                  DataColumn(label: Text(previousDate == null ? '("₦\'m)' : previousDate + '("₦\'m)')),
                  DataColumn(label: Text('DTD Variance ("₦\'m)')),
                  DataColumn(label: Text(monthEndDate == null ? '("₦\'m)' : monthEndDate + '("₦\'m)')),
                  DataColumn(label: Text('MTD Variance ("₦\'m)')),
                ],
                  rows: productTotals.keys.map((product) {
                    // Display the product value only if it's different from the previous one
                    final displayProduct = product != previousProduct ? product : '';
                    previousProduct = product; // Update the previous product

                    return DataRow(
                      cells: [
                        DataCell(Text(displayProduct)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['currentBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['previousBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['variance']).toString(), style: kDealsHeaderStyle)),
                        // Add other cells for additional columns if needed
                      ],
                    );
                  }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
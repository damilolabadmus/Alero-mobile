import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MyBalanceSheetRmContainer extends StatefulWidget {
  final balanceSheetData;
  final String selectedStartDate;
  String previousDate;
  String monthEndDate;

  MyBalanceSheetRmContainer({this.balanceSheetData, this.selectedStartDate, this.previousDate, this.monthEndDate});

  @override
  State<MyBalanceSheetRmContainer> createState() => _MyBalanceSheetRmContainerState();
}

class _MyBalanceSheetRmContainerState extends State<MyBalanceSheetRmContainer> {

  Map productTotals = {};

  @override
  void initState() {
    super.initState();

    productTotals = {};

    widget.balanceSheetData.forEach((item) {
      final product = item.product ?? 'Unknown';
      productTotals.putIfAbsent(product, () => {
        'currentBalance': 0.0,
        'previousBal': 0.0,
        'monthEndBalance': 0.0,
        'variance': 0.0,
        'varianceFromMonthEnd': 0.0,
        'budget': 0.0,
        'varianceFromBudget': 0.0,
      });

      productTotals[product]['currentBalance'] += item.currentBalance ?? 0.0;
      productTotals[product]['previousBal'] += item.previousBal ?? 0.0;
      productTotals[product]['variance'] += item.variance ?? 0.0;
      productTotals[product]['monthEndBalance'] += item.monthEndBalance ?? 0.0;
      productTotals[product]['varianceFromMonthEnd'] += item.varianceFromMonthEnd ?? 0.0;
      productTotals[product]['budget'] += item.budget ?? 0.0;
      productTotals[product]['varianceFromBudget'] += item.varianceFromBudget ?? 0.0;
    });
  }


  @override
  Widget build(BuildContext context) {
    String previousProduct;
    int rowIndex = 0;

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
                headingRowHeight: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text(widget.selectedStartDate == null ? '(₦\'m)' : widget.selectedStartDate + '(₦\'m)')),
                  DataColumn(label: Text(widget.previousDate == null ? '(₦\'m)' : widget.previousDate + '(₦\'m)')),
                  DataColumn(label: Text('DTD Variance (₦\'m)')),
                  DataColumn(label: Text(widget.monthEndDate == null ? '(₦\'m)' : widget.monthEndDate + '(₦\'m)')),
                  DataColumn(label: Text('MTD Variance (₦\'m)')),
                  DataColumn(label: Text('Budget (₦\'m)')),
                  DataColumn(label: Text('Variance From Budget (₦\'m)')),
                  // DataColumn(label: Text('Achievement % (₦\'m)')),
                ],
                rows: productTotals.keys.map((product) {
                  final displayProduct = product != previousProduct ? product : '';
                  previousProduct = product;
                  final color = rowIndex.isOdd
                      ? Colors.grey.withOpacity(0.15)
                      : null;
                  rowIndex++;
                  return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                          }
                          return color; // Use the calculated color here
                        },
                      ),
                      cells: [
                        DataCell(Text(displayProduct, style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['currentBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['previousBal']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['variance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['monthEndBalance']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['varianceFromMonthEnd']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['budget']).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(productTotals[product]['varianceFromBudget']).toString(), style: kDealsHeaderStyle)),
                        // DataCell(Text((widget.balanceSheetData[index].achievementPercent).String(), style: kDealsHeaderStyle)),
                      ]);
                }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }}
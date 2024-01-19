import 'dart:ui';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBalanceSheetTableContainer extends StatelessWidget {
  final balanceSheetDepData;
  final balanceSheetLoanData;
  final String selectedStartDate;
  String previousDate;
  String monthEndDate;

  MyBalanceSheetTableContainer({this.balanceSheetDepData, this.balanceSheetLoanData, this.selectedStartDate, this.previousDate, this.monthEndDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 10, top: 5.0),
                  child: Text('DEPOSIT', style: kDealsBlueHeading),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columnSpacing: 15.0,
                        dataRowHeight: 30,
                        headingRowHeight: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                      columns: [
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text(selectedStartDate == null ? '(₦\'m)' : selectedStartDate + '(₦\'m)')),
                        DataColumn(label: Text(previousDate == null ? '(₦\'m)' : previousDate + ' (₦\'m)')),
                        DataColumn(label: Text('DTD Variance (₦\'m)')),
                        DataColumn(label: Text(monthEndDate == null ? '(₦\'m)' : monthEndDate + '(₦\'m)')),
                        DataColumn(label: Text('MTD Variance (₦\'m)')),
                        DataColumn(label: Text('Budget (₦\'m)')),
                        DataColumn(label: Text('Variance From Budget (₦\'m)')),
                        DataColumn(label: Text('Achievement % (₦\'m)')),
                        // ], rows: [],
                      ], rows: List.generate(balanceSheetDepData.length, (index) {
                      return DataRow(
                        color:  MaterialStateProperty.resolveWith<Color>(
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
                             DataCell(Text(balanceSheetDepData[index].product == "Demand_Deposits" ? 'CURRENT'
                                : balanceSheetDepData[index].product == "Savings_Deposits" ? 'SAVINGS'
                                : balanceSheetDepData[index].product == "Term_Deposits" ? 'TIME'
                                : balanceSheetDepData[index].product == "Dom_Deposits" ? 'DOM'
                                : balanceSheetDepData[index].product == "CASA_Dom_Deposits" ? 'CASA_DOM'
                                : balanceSheetDepData[index].product,
                              style: balanceSheetDepData[index].product == 'Total Deposits' ? KPmItemsHeader : kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].currentBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].previousBal.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].monthEndBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].varianceFromMonthEnd.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].budget.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(balanceSheetDepData[index].varianceFromBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(balanceSheetDepData[index].achievementPercent.toString(), style: balanceSheetDepData[index].product == 'Total Deposits' ? KPmItemsHeader : kDealsHeaderStyle)),
                      ]);}
                    ),
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 10, top: 5.0),
                  child: Text('LOAN', style: kDealsBlueHeading),
                ),
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
                        headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                        columns: [
                          DataColumn(label: Text('Category')),
                          DataColumn(label: Text(selectedStartDate == null ? '(₦\'m)' : selectedStartDate + '(₦\'m)')),
                          DataColumn(label: Text(previousDate == null ? '(₦\'m)' : previousDate + ' (₦\'m)')),
                          DataColumn(label: Text('DTD Variance (₦\'m)')),
                          DataColumn(label: Text(monthEndDate == null ? '(₦\'m)' : monthEndDate + '(₦\'m)')),
                          DataColumn(label: Text('MTD Variance (₦\'m)')),
                          DataColumn(label: Text('Budget (₦\'m)')),
                          DataColumn(label: Text('Variance From Budget (₦\'m)')),
                          DataColumn(label: Text('Achievement % (₦\'m)')),
                          // ], rows: [],
                        ], rows: List.generate(balanceSheetLoanData.length, (index) {
                        return DataRow(
                            color:  MaterialStateProperty.resolveWith<Color>(
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
                              DataCell(Text(balanceSheetLoanData[index].product, style: balanceSheetLoanData[index].product == 'Total Loans' ? KPmItemsHeader : kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].currentBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].previousBal.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].monthEndBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].varianceFromMonthEnd.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].budget.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(Pandora.moneyFormat(balanceSheetLoanData[index].varianceFromBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                              DataCell(Text(balanceSheetLoanData[index].achievementPercent.toString(), style: balanceSheetLoanData[index].product == 'Total Loans' ? KPmItemsHeader : kDealsHeaderStyle)),
                        ]);}
                      ),
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
     );
}}

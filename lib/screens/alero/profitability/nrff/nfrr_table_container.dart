import 'dart:async';
import 'package:alero/models/performance/NrffReponse.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/loading_quotes.dart';
import 'package:flutter/material.dart';

class NrffTableContainer extends StatefulWidget {

  List<NrffResponse> nrffData = [];

  NrffTableContainer({@required this.nrffData});

  @override
  State<NrffTableContainer> createState() => _NrffTableContainerState();
}

class _NrffTableContainerState extends State<NrffTableContainer> {

  bool isDataLoaded = false;

  double sumColumn(List<NrffResponse> products, double Function(NrffResponse) getValue) {
    double sum = 0.0;
    for (var product in products) {
      sum += getValue(product).toDouble() ?? 0.0;
    }
    return sum;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 4), checkDataAndDisplayCard);
  }

  Future<void> checkDataAndDisplayCard() async {
    if (widget.nrffData == null || widget.nrffData.isEmpty) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    List<NrffResponse> depositProducts = [];
    List<NrffResponse> liabilityProducts = [];
    List<NrffResponse> loanProducts = [];

    for (var data in widget.nrffData) {
      if (data.product == 'CURRENT' ||
          data.product == 'SAVINGS' ||
          data.product == 'CASADOM' ||
          data.product == 'DOM' ||
          data.product == 'TIME') {
        depositProducts.add(data);
      } else if (data.product == 'LCMARGINLCY' ||
          data.product == 'LCMARGINFCY' ||
          data.product == 'COLDEP' ||
          data.product == 'SOLS' ||
          data.product == 'COLLECTION' ||
          data.product == 'OTHLIAB') {
        liabilityProducts.add(data);
      } else {
        loanProducts.add(data);
      }
    }

    double depositActualSum = sumColumn(depositProducts, (data) => data.actualValue);
    double depositAverageSum = sumColumn(depositProducts, (data) => data.averageValue);
    double depositInterestSum = sumColumn(depositProducts, (data) => data.interestExpense);
    double depositEffInRateSum = sumColumn(depositProducts, (data) => 0.0);
    // double depositEffInRateSum = sumColumn(depositProducts, (data) => data.effInRate);
    double depositFtpSum = sumColumn(depositProducts, (data) => data.ftpExpense);
    double depositEffFtpSum = sumColumn(depositProducts, (data) => data.effFtpRate);
    double depositNrffSum = sumColumn(depositProducts, (data) => data.nrff);

    double liabilityActualSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityAverageSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityInterestSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityEffInRateSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityFtpSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityEffFtpSum = sumColumn(liabilityProducts, (data) => 0.0);
    double liabilityNrffSum = sumColumn(liabilityProducts, (data) => 0.0);

    double loanActualSum = sumColumn(loanProducts, (data) => 0.0);
    double loanAverageSum = sumColumn(loanProducts, (data) => 0.0);
    double loanInterestSum = sumColumn(loanProducts, (data) => 0.0);
    double loanEffInRateSum = sumColumn(loanProducts, (data) => 0.0);
    double loanFtpSum = sumColumn(loanProducts, (data) => 0.0);
    double loanEffFtpSum = sumColumn(loanProducts, (data) => 0.0);
    double loanNrffSum = sumColumn(loanProducts, (data) => 0.0);


    /*double liabilityActualSum = sumColumn(liabilityProducts, (data) => data.actualValue);
    double liabilityAverageSum = sumColumn(liabilityProducts, (data) => data.averageValue);
    double liabilityInterestSum = sumColumn(liabilityProducts, (data) => data.interestExpense);
    double liabilityEffInRateSum = sumColumn(liabilityProducts, (data) => data.effInRate);
    double liabilityFtpSum = sumColumn(liabilityProducts, (data) => data.ftpExpense);
    double liabilityEffFtpSum = sumColumn(liabilityProducts, (data) => data.effFtpRate);
    double liabilityNrffSum = sumColumn(liabilityProducts, (data) => data.nrff);

    double loanActualSum = sumColumn(loanProducts, (data) => data.actualValue);
    double loanAverageSum = sumColumn(loanProducts, (data) => data.averageValue);
    double loanInterestSum = sumColumn(loanProducts, (data) => data.interestExpense);
    double loanEffInRateSum = sumColumn(loanProducts, (data) => data.effInRate);
    double loanFtpSum = sumColumn(loanProducts, (data) => data.ftpExpense);
    double loanEffFtpSum = sumColumn(loanProducts, (data) => data.effFtpRate);
    double loanNrffSum = sumColumn(loanProducts, (data) => data.nrff);
*/

    return isDataLoaded ? Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 15.0,
                    dataRowHeight: 30,
                    headingRowHeight: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    headingRowColor: MaterialStateProperty.all(
                        Colors.blueGrey.shade50),
                    columns: [
                      DataColumn(label: Text('\nPRODUCT', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('\nACTUAL', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('\nAVERAGE', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('INTEREST \nAMOUNT', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('EFFECTIVE \nINTEREST RATE %', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('FTP \nAMOUNT', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('EFFECTIVE \nFTP RATE %', style: kDisburseBlueStyle)),
                      DataColumn(label: Text('\nNRFF', style: kDisburseBlueStyle))
                    ],
                    rows: [],
                  ),
                ],
              )
          ),
        ),
      ),
    ) : widget.nrffData.isEmpty ? LoadingQuotes(title: 'NRFF')
        : Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15.0,
                  dataRowHeight: 30,
                  headingRowHeight: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  headingRowColor:
                  MaterialStateProperty.all(Colors.blueGrey.shade50),
                  columns: [
                    DataColumn(label: Text('\nPRODUCT', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('\nACTUAL', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('\nAVERAGE', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('INTEREST \nAMOUNT', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('EFFECTIVE \nINTEREST RATE %', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('FTP \nAMOUNT', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('EFFECTIVE \nFTP RATE %', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('\nNRFF', style: kDisburseBlueStyle)),
                  ],
                  rows: [
                    ...depositProducts.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(Pandora.replaceHyphenFormat(data.product ?? ''), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.actualValue).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.averageValue).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.interestExpense).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.effInRate).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.ftpExpense).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.effFtpRate).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.nrff).toString(), style: kDealsHeaderStyle)),
                      ]);
                    }),
                    DataRow(cells: [
                      DataCell(Text('TOTAL DEPOSITS', style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositActualSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositAverageSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositInterestSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositEffInRateSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositEffFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(depositNrffSum).toString(), style: KPmItemsHeader)),
                    ]),
                    ...liabilityProducts.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(Pandora.replaceHyphenFormat(data.product), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.actualValue).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.averageValue).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.interestExpense).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.effInRate).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.ftpExpense).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.effFtpRate).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.dynamicMoneyFormat(data.nrff).toString(), style: kDealsHeaderStyle)),
                      ]);
                    }),
                    DataRow(cells: [
                      DataCell(Text('TOTAL LIABILITIES', style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityActualSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityAverageSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityInterestSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityEffInRateSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityEffFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(liabilityNrffSum).toString(), style: KPmItemsHeader)),
                    ]),
                    ...loanProducts.map((data) {
                      return DataRow(
                          cells: [
                            DataCell(Text(Pandora.replaceHyphenFormat(data.product), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.actualValue).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.averageValue).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.interestExpense).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.effInRate).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.ftpExpense).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.effFtpRate).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(data.nrff).toString(), style: kDealsHeaderStyle)),
                          ]);
                    }),
                    DataRow(cells: [
                      DataCell(Text('TOTAL LOANS', style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanActualSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanAverageSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanInterestSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanEffInRateSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanEffFtpSum).toString(), style: KPmItemsHeader)),
                      DataCell(Text(Pandora.moneyFormat(loanNrffSum).toString(), style: KPmItemsHeader)),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class NrffTableContainer extends StatefulWidget {
  final List<NrffResponse> nrffData;

  const NrffTableContainer({@required this.nrffData});

  @override
  State<NrffTableContainer> createState() => _NrffTableContainerState();
}

class _NrffTableContainerState extends State<NrffTableContainer> {

  @override
  Widget build(BuildContext context) {
    return widget.nrffData.isEmpty ? LoadingQuotes(title: 'NRFF')
        : Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 12.0,
                  dataRowHeight: 30,
                  headingRowHeight: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  headingRowColor:
                  MaterialStateProperty.all(Colors.blueGrey.shade50),
                  columns: [
                    DataColumn(label: Text('PRODUCT' ?? 'OTH', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('ACTUAL', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('AVERAGE', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('INTEREST AMOUNT', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('EFFECTIVE INTEREST RATE %', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('FTP AMOUNT', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('EFFECTIVE FTP RATE %', style: kDisburseBlueStyle)),
                    DataColumn(label: Text('NRFF', style: kDisburseBlueStyle)),
                  ],
                  rows: List.generate(widget.nrffData.length, (index) {
                    final nrffData = widget.nrffData[index];
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
                            if (index.isOdd) {
                              return Colors.grey.withOpacity(0.15);
                            }
                            return null;
                          }),
                        cells: [
                          DataCell(Text(nrffData.product, style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.nrff.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.effFtpRate.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.ftpExpense.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.effInRate.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.interestExpense.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.averageValue.toString(), style: kDealsHeaderStyle)),
                          DataCell(Text(nrffData.actualValue.toString(), style: kDealsHeaderStyle)),
                        ]);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';

/*
class NrffTableContainer extends StatefulWidget {
  final nrffData;

  const NrffTableContainer({this.nrffData});

  @override
  State<NrffTableContainer> createState() => _NrffTableContainerState();
}

class _NrffTableContainerState extends State<NrffTableContainer> {
  Map productTotals = {};

 @override
 void initState() {
    super.initState();
    productTotals = {};

    widget.nrffData.forEach((item) {
      final Product = item.Product ?? 'Unknown';
      productTotals.putIfAbsent(Product, () => {
        'ActualValue': 0.0,
        'AverageValue': 0.0,
        'InterestExpense': 0.0,
        'EffInRate': 0.0,
        'FtpExpense': 0.0,
        'EffFtpRate': 0.0,
        'Nrff': 0.0,
      });

      productTotals[Product]['ActualValue'] += item.ActualValue ?? 0.0;
      productTotals[Product]['AverageValue'] += item.AverageValue ?? 0.0;
      productTotals[Product]['InterestExpense'] += item.InterestExpense ?? 0.0;
      productTotals[Product]['EffInRate'] += item.EffInRate ?? 0.0;
      productTotals[Product]['FtpExpense'] += item.FtpExpense ?? 0.0;
      productTotals[Product]['EffFtpRate'] += item.EffFtpRate ?? 0.0;
      productTotals[Product]['Nrff'] += item.Nrff ?? 0.0;
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
                columnSpacing: 15.0,
                dataRowHeight: 30,
                headingRowHeight: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('PRODUCT')),
                  DataColumn(label: Text('ACTUAL ("₦\'m)')),
                  DataColumn(label: Text('AVERAGE ("₦\'m)')),
                  DataColumn(label: Text('INTEREST AMOUNT ("₦\'m)')),
                  DataColumn(label: Text('EFFECTIVE INTEREST RATE %')),
                  DataColumn(label: Text('FTP AMOUNT ("₦\'m)')),
                  DataColumn(label: Text('EFFECTIVE FTP RATE %')),
                  DataColumn(label: Text('NRFF ("₦\'m)')),
                ],
                rows: productTotals.keys.map((Product) {
                  final displayProduct = Product != previousProduct ? Product : '';
                  previousProduct = Product;
                  final color = rowIndex.isOdd
                      ? Colors.grey.withOpacity(0.15)
                      : null;
                  rowIndex++;
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
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['ActualValue']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['AverageValue']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['InterestExpense']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['EffInRate']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['FtpExpense']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['EffFtpRate']).toString(), style: kDealsHeaderStyle)),
                       DataCell(Text(Pandora.moneyFormat(productTotals[Product]['Nrff']).toString(), style: kDealsHeaderStyle)),
                     ],);
                }).toList(),
              ),
            ),)]
      ),
    );
  }
}
*/


class NrffTableContainer extends StatefulWidget {
  final nrffData;

  const NrffTableContainer({this.nrffData});

  @override
  State<NrffTableContainer> createState() => _NrffTableContainerState();
}

class _NrffTableContainerState extends State<NrffTableContainer> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return widget.nrffData.isEmpty ?
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, bottom: 5.0),
            child: Text("You do not have any data for now.",
              style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ) :
        Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Column(
              children: [
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
                      headingRowColor: MaterialStateProperty.all(
                          Colors.blueGrey.shade50),
                      columns: [
                        DataColumn(label: Text('PRODUCT')),
                        DataColumn(label: Text('ACTUAL ("₦\'m)')),
                        DataColumn(label: Text('AVERAGE ("₦\'m)')),
                        DataColumn(label: Text('INTEREST AMOUNT ("₦\'m)')),
                        DataColumn(label: Text('EFFECTIVE INTEREST RATE %')),
                        DataColumn(label: Text('FTP AMOUNT ("₦\'m)')),
                        DataColumn(label: Text('EFFECTIVE FTP RATE %')),
                        DataColumn(label: Text('NRFF ("₦\'m)')),
                      ],
                      rows: List.generate(widget.nrffData.length, (index) {
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
                                if (widget.nrffData.length.isOdd) {
                                  return Colors.grey.withOpacity(0.15);
                                }
                                return null;
                              }),
                          cells: [
                            DataCell(Text(widget.nrffData[index].product, style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].actualValue).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].averageValue).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].interestExpense).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].effInRate).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].ftpExpense).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].effFtpRate).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.dynamicMoneyFormat(widget.nrffData[index].nrff).toString(), style: kDealsHeaderStyle)),
                          ],);}
                      ),
                    ),
                  ),)]
          ),
        );
      },
    );
  }
}





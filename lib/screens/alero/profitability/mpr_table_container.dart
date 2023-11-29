import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MprTableContainer extends StatefulWidget {
  final mprData;

  MprTableContainer({this.mprData});

  @override
  State<MprTableContainer> createState() => _MprTableContainerState();
}

class _MprTableContainerState extends State<MprTableContainer> {
  @override
  Widget build(BuildContext context) {

    List<String> allKeys = [];
    widget.mprData.forEach((response) {
      response.rowMonthsItem?.forEach((key, value) {
        if (!allKeys.contains(key)) {
          allKeys.add(key);
        }
      });
    });

    String convertToMonthYear(String key) {
      DateTime dateTime = DateTime.parse(key.substring(0, 4) + '-' + key.substring(4) + '-01');
      return DateFormat('MMM\nyyyy').format(dateTime);
    }

    return FutureBuilder(
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
        // return ShimmerLoadingWidget();
        return Column(
          children: [
            Card(child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 10),
              child: Text('Please wait as this might take a while...',
                style: TextStyle(color: Colors.black54.withOpacity(0.8), fontFamily: 'Poppins-Regular', fontSize: 11),),
            )),
            SizedBox(height: 5),
            // ShimmerLoadingWidget()
          ],);
      }
      return widget.mprData == null ?
      Column(
        children: [
          SizedBox(height: 10),
          Card(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 10.0, bottom: 7.0),
                child: Text("You do not have any data for now.",
                  style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ) :
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(right: 3.0, left: 2, top: 4, bottom: 4),
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 15.0,
                dataRowHeight: 30,
                headingRowHeight: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(
                    Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  ...allKeys.map((key) => DataColumn(label: Text(convertToMonthYear(key) + ' (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600)))).toList(),
                  DataColumn(label: Text('Current \nBudget (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Current \nActual (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Current \nVariance (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Current \nAchieved (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Ytd \nBudget (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Ytd \nActual (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Ytd \nVariance ("₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Ytd \nAchieved ("₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('FullYear \nBudget (₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  DataColumn(label: Text('Run \nRate ("₦\'m)', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                ],
                rows: List.generate(widget.mprData.length, (index) {
                  var data = widget.mprData[index];
                  List<DataCell> cells = [
                    DataCell(Text(data.categoryName, style: kMprItemStyle)),
                  ];
                  allKeys.forEach((key) {
                    String value = data.rowMonthsItem[key]?.toString() ?? '';
                    cells.add(DataCell(Text(Pandora.moneyFormat(double.parse(value)).toString(), style: kMprItemStyle)));
                  });
                  cells.addAll([
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.currentBudgetValue).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.currentActualValue).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.currentVariance).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.currentAchieved).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.ytdBudgetValue).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.ytdActualValue).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.ytdVariance).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.ytdAchieved).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.fyBudget).toString(), style: kMprItemStyle)),
                    DataCell(Text(Pandora.dynamicMoneyFormat(data.runRate).toString(), style: kMprItemStyle)),
                  ]);
                  return DataRow(cells: cells, color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
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
                  );}
                ),
              ),
            ),
          ),
        ),
      );
   });}
}




/*
class _MprTableContainerState extends State<MprTableContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(right: 3.0, left: 2, top: 4),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('\nCategory')),
                DataColumn(label: Text('Current \nBudget')),
                DataColumn(label: Text('Current \nVariance')),
                DataColumn(label: Text('Current \nAchieved')),
                DataColumn(label: Text('Ytd \nActual')),
                DataColumn(label: Text('Ytd \nBudget')),
                DataColumn(label: Text('Ytd \nVariance')),
                DataColumn(label: Text('Ytd \nAchieved')),
                DataColumn(label: Text('FullYear \nBudget')),
                DataColumn(label: Text('Run \nRate')),
              ],
              rows: List.generate(widget.mprData.length, (index) {
                List<dynamic> rowObjectSubList = widget.mprData[index]['rowObjectSubList'];
                List<DataCell> subCells = [];
                for (var subItem in rowObjectSubList) {
                  subCells.addAll([
                    DataCell(Text(subItem['CategoryName'].toString())),
                    DataCell(Text(subItem['CurrentBudgetValue'].toString())),
                    DataCell(Text(subItem['CurrentVariance'].toString())),
                    DataCell(Text(subItem['CurrentAchieved'].toString())),
                    DataCell(Text(subItem['YtdActualValue'].toString())),
                    DataCell(Text(subItem['YtdBudgetValue'].toString())),
                    DataCell(Text(subItem['YtdVarianceValue'].toString())),
                    DataCell(Text(subItem['YtdAchieved'].toString())),
                    DataCell(Text(subItem['FyBudget'].toString())),
                    DataCell(Text(subItem['RunRate'].toString())),
                  ]);
                }
                return DataRow(cells: [
                  DataCell(Text(widget.mprData[index]['CategoryName'].toString())),
                  DataCell(Text(widget.mprData[index]['CurrentBudgetValue'].toString())),
                  DataCell(Text(widget.mprData[index]['CurrentVariance'].toString())),
                  DataCell(Text(widget.mprData[index]['CurrentAchieved'].toString())),
                  DataCell(Text(widget.mprData[index]['YtdActualValue'].toString())),
                  DataCell(Text(widget.mprData[index]['YtdBudgetValue'].toString())),
                  DataCell(Text(widget.mprData[index]['YtdVariance'].toString())),
                  DataCell(Text(widget.mprData[index]['YtdAchieved'].toString())),
                  DataCell(Text(widget.mprData[index]['FyBudget'].toString())),
                  DataCell(Text(widget.mprData[index]['RunRate'].toString())),
                ] + subCells);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
*/




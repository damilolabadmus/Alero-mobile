import 'package:alero/models/performance/MprResponse.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MprTableContainer extends StatefulWidget {
  // Data that is coming in for the first time should not load again when you want to display again
  final mprData;

  MprTableContainer({this.mprData});

  @override
  State<MprTableContainer> createState() => _MprTableContainerState();
}



/// Below is the Drop down to see subclass, complete the code and run to check if its okay
class _MprTableContainerState extends State<MprTableContainer> {
  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '${DateFormat.MMM().format(date)}\n${DateFormat('y').format(date)}';
  }

  List<DataRow> _buildRowsForMprResponse(MprResponse rowData) {
    List<DataRow> rows = [];
    rows.add(
      DataRow(
        cells: [
          DataCell(Text(rowData.categoryName ?? '')),
          if (rowData.rowMonthsItem != null)
            for (var value in rowData.rowMonthsItem.values)
              DataCell(Text(value.toString())),
          DataCell(Text(rowData.currentBudgetValue.toString())),
          DataCell(Text(rowData.currentActualValue.toString())),
          DataCell(Text(rowData.currentVariance.toString())),
          DataCell(Text(rowData.currentAchieved.toString())),
          DataCell(Text(rowData.ytdBudgetValue.toString())),
          DataCell(Text(rowData.ytdActualValue.toString())),
          DataCell(Text(rowData.ytdVariance.toString())),
          DataCell(Text(rowData.ytdAchieved.toString())),
          DataCell(Text(rowData.fyBudget.toString())),
          DataCell(Text(rowData.runRate.toString())),
        ],
      ),
    );

    if (rowData.rowObjectSubList != null) {
      for (var subCategory in rowData.rowObjectSubList) {
        rows.add(
          DataRow(
            cells: [
              DataCell(
                ExpansionTile(
                  title: Text(subCategory.categoryName ?? ''),
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(label: Text('SubClass')),
                        DataColumn(label: Text('SubClass currentBudgetValue')),
                        DataColumn(label: Text('SubClass ytdBudgetValue')),
                        // Add more DataColumn widgets for SubClass attributes
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text('SubClass.categoryName ?? ''')),
                            DataCell(Text(subCategory.currentBudgetValue.toString())),
                            DataCell(Text(subCategory.ytdBudgetValue.toString())),
                            // Add more DataCell widgets for SubClass attributes
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DataCell(Text(subCategory.currentBudgetValue.toString())),
              DataCell(Text(subCategory.currentActualValue.toString())),
              DataCell(Text(subCategory.currentVariance.toString())),
              DataCell(Text(subCategory.currentAchieved.toString())),
              DataCell(Text(subCategory.ytdBudgetValue.toString())),
              DataCell(Text(subCategory.ytdActualValue.toString())),
              DataCell(Text(subCategory.ytdVariance.toString())),
              DataCell(Text(subCategory.ytdAchieved.toString())),
              DataCell(Text(subCategory.fyBudget.toString())),
              DataCell(Text(subCategory.runRate.toString())),
            ],
          ),
        );
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columnSpacing: 15.0,
                        dataRowHeight: 30,
                        headingRowHeight: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                        columns: [
                          DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                          if (widget.mprData.isNotEmpty)
                            for (var key in widget.mprData.first.rowMonthsItem.keys)
                               DataColumn(label: Text(formatMonthKey(key))),
                          DataColumn(label: Text('Current \nBudget (₦\'m)')),
                          DataColumn(label: Text('Current \nActual (₦\'m)')),
                          DataColumn(label: Text('Current \nVariance (₦\'m)')),
                          DataColumn(label: Text('Current \nAchieved (₦\'m)')),
                          DataColumn(label: Text('Ytd \nBudget (₦\'m)')),
                          DataColumn(label: Text('Ytd \nActual (₦\'m)')),
                          DataColumn(label: Text('Ytd \nVariance ("₦\'m)')),
                          DataColumn(label: Text('Ytd \nAchieved ("₦\'m)')),
                          DataColumn(label: Text('FullYear \nBudget (₦\'m)')),
                          DataColumn(label: Text('Run \nRate ("₦\'m)')),
                        ],
                        rows: [
                          for (var rowData in widget.mprData)
                             ..._buildRowsForMprResponse(rowData),
                        ],
                     ),
                 ),
              ),
          ),
    );
  }
}


/*
/// This is the code before adding code for SubClass
class _MprTableContainerState extends State<MprTableContainer> {
  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '${DateFormat.MMM().format(date)}\n${DateFormat('y').format(date)}';
  }

  List<DataRow> _buildRowsForMprResponse(MprResponse rowData) {
    List<DataRow> rows = [];
    rows.add(
      DataRow(
        cells: [
          DataCell(Text(rowData.categoryName ?? '', style: kMprItemStyle)),
          if (rowData.rowMonthsItem != null)
            for (var value in rowData.rowMonthsItem.values)
              DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.currentBudgetValue.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.currentActualValue.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.currentVariance.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.currentAchieved.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.ytdBudgetValue.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.ytdActualValue.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.ytdVariance.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.ytdAchieved.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.fyBudget.toString(), style: kMprItemStyle)),
          DataCell(Text(rowData.runRate.toString(), style: kMprItemStyle)),
        ],
      ),
    );

    if (rowData.rowObjectSubList != null) {
      for (var subCategory in rowData.rowObjectSubList) {
        rows.add(
          DataRow(
            cells: [
              DataCell(Text(subCategory.categoryName ?? '', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              if (subCategory.rowMonthsItem != null)
                for (var value in subCategory.rowMonthsItem.values)
                  DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.currentBudgetValue.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.currentActualValue.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.currentVariance.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.currentAchieved.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.ytdBudgetValue.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.ytdActualValue.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.ytdVariance.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.ytdAchieved.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.fyBudget.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
              DataCell(Text(subCategory.runRate.toString(), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade300))),
            ],
          ),
        );
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      if (widget.mprData.isNotEmpty)
                        for (var key in widget.mprData.first.rowMonthsItem.keys)
                          DataColumn(label: Text(formatMonthKey(key), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
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
                    rows: [
                      for (var rowData in widget.mprData)
                        ..._buildRowsForMprResponse(rowData),
                    ],
                  ),
                ),
              ),
            ),
          );
        });}
}
*/






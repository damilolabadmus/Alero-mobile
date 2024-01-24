import 'dart:async';
import 'package:alero/models/performance/MprResponse.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:alero/utils/loading_quotes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*class MprTableContainer extends StatefulWidget {
  final mprData;

  MprTableContainer({this.mprData});

  @override
  State<MprTableContainer> createState() => _MprTableContainerState();
}

class _MprTableContainerState extends State<MprTableContainer> {
  bool underlineText = false;

  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '\n${DateFormat.MMM().format(date)} ${DateFormat('y').format(date)}';
  }

  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 6), checkDataAndDisplayCard);
  }

  Future<void> checkDataAndDisplayCard() async {
    if (widget.mprData == null || widget.mprData.isEmpty) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  List<DataRow> _buildRowsForMprResponse(MprResponse rowData) {
    List<DataRow> rows = [];
    rows.add(
        DataRow(
        cells: [
          DataCell(Text(rowData.categoryName ?? '', style: kDealsHeaderStyle)),
          if (rowData.rowMonthsItem != null)
            for (var value in rowData.rowMonthsItem.values)
              DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentBudgetValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentActualValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentVariance).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentAchieved).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdBudgetValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdActualValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdVariance).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdAchieved).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.fyBudget).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.runRate).toString(), style: kDealsHeaderStyle)),
        ],
      ),
    );

    if (rowData.rowObjectSubList != null) {
      for (var subCategory in rowData.rowObjectSubList) {
        rows.add(
          DataRow(
            cells: [
              DataCell(InkWell(
                  onTap: () {
                      showSubCategoryDropdownMenu(context, subClassList);
                  }, child: Text(Pandora.replaceUnderscoreFormat(subCategory.categoryName) ?? '', style: underlineText == true
                        ? kCprHeadingText.copyWith(color: Colors.blue.shade300, decoration: TextDecoration.underline)
                        : kCprHeadingText.copyWith(color: Colors.blue.shade300),
                  ),
                ),
              ),
              if (subCategory.rowMonthsItem != null)
                for (var value in subCategory.rowMonthsItem.values)
                  DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentBudgetValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentActualValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentVariance).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentAchieved).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdBudgetValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdActualValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdVariance).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdAchieved).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.fyBudget).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.runRate).toString(), style: kDealsHeaderStyle)),
            ],
          ),
        );
      }
    }
    return rows;
  }

  List<DataRow> _buildRowsForSubClass(List<SubClass> subClassList) {
    List<DataRow> rows = [];
    for (var subClass in subClassList) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(subClass.categoryName ?? '', style: kDealsHeaderStyle)),
            if (subClass.rowMonthsItem != null)
              for (var value in subClass.rowMonthsItem.values)
                DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.fyBudget.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.runRate.toString(), style: kDealsHeaderStyle)),
          ],
        ),
      );
    }
    return rows;
  }

  void showSubCategoryDropdownMenu(BuildContext context, List<SubClass> subClassList) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.33),
          child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 230,
                child: DataTable(
                  columnSpacing: 15.0,
                  dataRowHeight: 30,
                  headingRowHeight: 40,
                  headingRowColor: MaterialStateProperty.all(
                      Colors.blueGrey.shade50),
                  columns: [
                    DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    if (subClassList.isNotEmpty)
                      for (var key in subClassList.first.rowMonthsItem.keys)
                        DataColumn(label: Text(formatMonthKey(key), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('FullYear \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Run \nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  ],
                  rows: _buildRowsForSubClass(subClassList),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Card(
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
                      DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('FullYear \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Run \nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    ],
                    rows: [],
                  ),
                ],
              )
          ),
        ),
      ),
    ) : widget.mprData.isEmpty ? LoadingQuotes(title: 'MPR') :
      Card(
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
                        DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        if (widget.mprData.isNotEmpty)
                          for (var key in widget.mprData.first.rowMonthsItem.keys)
                            DataColumn(label: Text(formatMonthKey(key), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('FullYear \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Run \nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      ],
                      rows: [
                        for (var rowData in widget.mprData)
                          ..._buildRowsForMprResponse(rowData),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ),
      );
  }
}*/

class MprTableContainer extends StatefulWidget {
  final mprData;

  MprTableContainer({this.mprData});

  @override
  State<MprTableContainer> createState() => _MprTableContainerState();
}

class _MprTableContainerState extends State<MprTableContainer> {
  bool underlineText = false;

  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '\n${DateFormat.MMM().format(date)} ${DateFormat('y').format(date)}';
  }

  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 6), checkDataAndDisplayCard);
  }

  Future<void> checkDataAndDisplayCard() async {
    if (widget.mprData == null || widget.mprData.isEmpty) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  List<DataRow> _buildRowsForMprResponse(MprResponse rowData) {
    List<DataRow> rows = [];
    rows.add(
        DataRow(
        cells: [
          DataCell(Text(rowData.categoryName ?? '', style: kDealsHeaderStyle)),
          if (rowData.rowMonthsItem != null)
            for (var value in rowData.rowMonthsItem.values)
              DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentBudgetValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentActualValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentVariance).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.currentAchieved).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdBudgetValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdActualValue).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdVariance).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.ytdAchieved).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.fyBudget).toString(), style: kDealsHeaderStyle)),
          DataCell(Text(Pandora.dynamicMoneyFormat(rowData.runRate).toString(), style: kDealsHeaderStyle)),
        ],
      ),
    );

    if (rowData.rowObjectSubList != null) {
      for (var subCategory in rowData.rowObjectSubList) {
        rows.add(
          DataRow(
            cells: [
              DataCell(InkWell(
                  onTap: () {
                      showSubCategoryDropdownMenu(context, subCategory.rowObjectSubClass);
                  }, child: Text(Pandora.replaceUnderscoreFormat(subCategory.categoryName) ?? '', style: underlineText == true
                        ? kCprHeadingText.copyWith(color: Colors.blue.shade300, decoration: TextDecoration.underline)
                        : kCprHeadingText.copyWith(color: Colors.blue.shade300),
                  ),
                ),
              ),
              if (subCategory.rowMonthsItem != null)
                for (var value in subCategory.rowMonthsItem.values)
                  DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentBudgetValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentActualValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentVariance).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.currentAchieved).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdBudgetValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdActualValue).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdVariance).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.ytdAchieved).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.fyBudget).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(Pandora.dynamicMoneyFormat(subCategory.runRate).toString(), style: kDealsHeaderStyle)),
            ],
          ),
        );
      }
    }
    return rows;
  }

  List<DataRow> _buildRowsForSubClass(List<SubClass> subClassList) {
    List<DataRow> rows = [];
    for (var subClass in subClassList) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(subClass.categoryName ?? '', style: kDealsHeaderStyle)),
            if (subClass.rowMonthsItem != null)
              for (var value in subClass.rowMonthsItem.values)
                DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.fyBudget.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.runRate.toString(), style: kDealsHeaderStyle)),
          ],
        ),
      );
    }
    return rows;
  }

  void showSubCategoryDropdownMenu(BuildContext context, List<SubClass> subClassList) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.33),
          child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 230,
                child: DataTable(
                  columnSpacing: 15.0,
                  dataRowHeight: 30,
                  headingRowHeight: 40,
                  headingRowColor: MaterialStateProperty.all(
                      Colors.blueGrey.shade50),
                  columns: [
                    DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    if (subClassList.isNotEmpty)
                      for (var key in subClassList.first.rowMonthsItem.keys)
                        DataColumn(label: Text(formatMonthKey(key), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Current \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Ytd \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('FullYear \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    DataColumn(label: Text('Run \nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                  ],
                  rows: _buildRowsForSubClass(subClassList),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Card(
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
                      DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current\nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current\nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current\nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Current\nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd\nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd\nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd\nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Ytd\nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('FullYear\nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      DataColumn(label: Text('Run\nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                    ],
                    rows: [],
                  ),
                ],
              )
          ),
        ),
      ),
    ) : widget.mprData.isEmpty ? LoadingQuotes(title: 'MPR') :
      Card(
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
                        DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        if (widget.mprData.isNotEmpty)
                          for (var key in widget.mprData.first.rowMonthsItem.keys)
                            DataColumn(label: Text(formatMonthKey(key), style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Current \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nActual', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nVariance', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Ytd \nAchieved', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('FullYear \nBudget', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                        DataColumn(label: Text('Run \nRate', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
                      ],
                      rows: [
                        for (var rowData in widget.mprData)
                          ..._buildRowsForMprResponse(rowData),
                      ],
                    ),
                  ],
                )
              ),
            ),),
    );
  }
}

 /// Trying to get the grand daughter
/*
class _MprTableContainerState extends State<MprTableContainer> {

  bool isSelected = false;
  bool underlineText = false;
  bool isSubClassVisible = false;
  List<DataRow> subClassRows = [];

  String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' + monthKey.substring(4, 6) + '-01');
    return '${DateFormat.MMM().format(date)}\n${DateFormat('y').format(date)}';
  }

  List<DataRow> _buildRowsForSubClass(List<SubClass> subClassList) {
    List<DataRow> rows = [];
    for (var subClass in subClassList) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(subClass.categoryName ?? '', style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.currentAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdBudgetValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdActualValue.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdVariance.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.ytdAchieved.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.fyBudget.toString(), style: kDealsHeaderStyle)),
            DataCell(Text(subClass.runRate.toString(), style: kDealsHeaderStyle)),          ],
        ),
      );
    }
    return rows;
  }

  List<DataRow> _buildRowsForMprResponse(MprResponse rowData) {
    List<DataRow> rows = [];
    rows.add(
        DataRow(
          selected: isSelected,
          onSelectChanged: (value) {
            isSelected = value;
            underlineText = value;
          },
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
      ),);

    if (rowData.rowObjectSubList != null) {
      for (var subCategory in rowData.rowObjectSubList) {
        rows.add(
          DataRow(
            selected: subCategory.isExpanded ?? false,
            onSelectChanged: (isSelected) {
              setState(() {
                subCategory.isExpanded = isSelected ?? false;
                if (subCategory.isExpanded) {
                  subClassRows = _buildRowsForSubClass(subCategory.rowObjectSubClass);
                } else {
                  subClassRows.clear();
                }
              });
            },
            cells: [
              DataCell(Text(subCategory.categoryName ?? '', style: underlineText == true ? kCprHeadingText.copyWith(color: Colors.blue.shade300, decoration: TextDecoration.underline) : kCprHeadingText.copyWith(color: Colors.blue.shade300))),
              if (subCategory.rowMonthsItem != null)
                for (var value in subCategory.rowMonthsItem.values)
                  DataCell(Text(Pandora.dynamicMoneyFormat(value).toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.currentBudgetValue.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.currentActualValue.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.currentVariance.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.currentAchieved.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.ytdBudgetValue.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.ytdActualValue.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.ytdVariance.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.ytdAchieved.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.fyBudget.toString(), style: kDealsHeaderStyle)),
              DataCell(Text(subCategory.runRate.toString(), style: kDealsHeaderStyle)),
            ],
          ),
        );
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    SubCategory subCat = SubCategory();
    return widget.mprData.isEmpty ? LoadingQuotes(title: 'Mpr') :
      Card(
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
                  if (subCat.isExpanded && subClassRows.isNotEmpty)
                    DataTable(
                      columns: [
                        DataColumn(label: Text('\nCategory', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
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
                      rows: subClassRows,
                    ),
                ],
              )
            ),
          ),
        ),
      );
  }
}
*/

/// Overflow grand daughter
/*
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
                        // DataColumn(label: Text('SubClass currentBudgetValue')),
                        // DataColumn(label: Text('SubClass ytdBudgetValue')),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text('SubClass.categoryName')),
                            // DataCell(Text(subCategory.currentBudgetValue.toString())),
                            // DataCell(Text(subCategory.ytdBudgetValue.toString())),
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
    return widget.mprData.isEmpty ? LoadingQuotes(title: 'Mpr') : Card(
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
  }
}
*/


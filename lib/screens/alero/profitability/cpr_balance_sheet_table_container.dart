import 'dart:ui';
import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/search/shimmer_loading_widget.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CprBalanceSheetTableContainer extends StatefulWidget {

  @override
  State<CprBalanceSheetTableContainer> createState() => _CprBalanceSheetTableContainerState();
}

class _CprBalanceSheetTableContainerState extends State<CprBalanceSheetTableContainer> {
  var apiService = AleroAPIService();

  bool isHover = false;
  bool visible = false;
  int dateIndex;
  bool isRowClicked = false;

  List<CprResponse> completeTopCprData = [];
  List<CprResponse> completeBottomCprData = [];

  Future<List<CprResponse>> getCompleteTopCprData() async {
    List<CprResponse> _cprData = await apiService.getTopCprData();
    setState(() {
      completeTopCprData = _cprData;

      String balanceSheetIncomeType = completeTopCprData[1].excludedTab[1].incomeType.toString();
      String bsCurrentMonthBudgetKey = completeTopCprData[1].excludedTab[1].currentMonthBudget.keys.toString();
      String bsCurrentMonthBudget = completeTopCprData[1].excludedTab[1].currentMonthBudget.values.toString();
      String bsCurrentMonthVariance = completeTopCprData[1].excludedTab[1].currentMonthVariance.values.toString();
      String bsCurrentMonthAchieved = completeTopCprData[1].excludedTab[1].currentMonthAchieved.values.toString();
      String bsYtDActualValue = completeTopCprData[1].excludedTab[1].ytDActualValue.toString();
      String bsYtDBudgetValue = completeTopCprData[1].excludedTab[1].ytDBudgetValue.toString();
      String bsYdtVariance = completeTopCprData[1].excludedTab[1].variance.toString();
      String bsYtdAchieved = completeTopCprData[1].excludedTab[1].ytDAchieved.toString();
      String bsFullYearBudget = completeTopCprData[1].excludedTab[1].fullYearBudget.toString();
      String bsRunRate = completeTopCprData[1].excludedTab[1].runRate.toString();

      print('The balance sheet incomeType = $balanceSheetIncomeType');
      print('The balance sheet currentMonthBudget_key = $bsCurrentMonthBudgetKey');
      print('The balance sheet currentMonthBudget = $bsCurrentMonthBudget');
      print('The balance sheet currentMonthVariance = $bsCurrentMonthVariance');
      print('The balance sheet currentMonthAchieved = $bsCurrentMonthAchieved');
      print('The balance sheet ytDActualValue = $bsYtDActualValue');
      print('The balance sheet ytDBudgetValue = $bsYtDBudgetValue');
      print('The balance sheet ydtVariance = $bsYdtVariance');
      print('The balance sheet ytdAchieved = $bsYtdAchieved');
      print('The balance sheet fullYearBudget = $bsFullYearBudget');
      print('The balance sheet runRate = $bsRunRate');
    });
    return completeTopCprData;
  }

  Future<List<CprResponse>> getCompleteBottomCprData() async {
    List<CprResponse> _cprData = await apiService.getBottomCprData();
    setState(() {
      completeBottomCprData = _cprData;
      print('The bottom data = $completeBottomCprData');
    });
    return completeBottomCprData;
  }

  @override
  void initState() {
    super.initState();
    getCompleteTopCprData();
    getCompleteBottomCprData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return completeTopCprData.isEmpty ?
        Card(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, left: 10.0, bottom: 7.0),
              child: Text("Data not found...",
                style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ) :
        Column(
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
                          Container(alignment: Alignment.centerLeft, child: Text(completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString().length - 1), style: kDisburseBlueStyle)),
                        ]),
                      )),
                      DataColumn(label: Container(
                        width: 140,
                        child: Stack(children: [
                          Positioned(left: 54, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                          Positioned(left: 54, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                          Container(alignment: Alignment.centerLeft, child: Text(completeTopCprData[1].mainReport[1].currentMonthVariance.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthVariance.keys.toString().length - 1), style: kDisburseBlueStyle)),
                        ]),
                      )),
                      DataColumn(label: Container(
                        width: 140,
                        child: Stack(children: [
                          Positioned(left: 95, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                          Positioned(left: 95, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                          Container(alignment: Alignment.centerLeft, child: Text(completeTopCprData[1].mainReport[1].currentMonthAchieved.keys.toString().substring(1, completeTopCprData[1].mainReport[1].currentMonthAchieved.keys.toString().length - 1), style: kDisburseBlueStyle)),
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
                    rows: List.generate(completeTopCprData.length, (index) {
                      // final customerData = widget.cprData[index];
                      return DataRow(
                        /*onSelectChanged: (isSelected) {
                          setState(() {
                            isRowClicked = true;
                          });
                        },*/
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
                            DataCell(
                              InkWell(
                                highlightColor: Colors.grey.shade300,
                                onHover: (isColor) {
                                  setState((){
                                    isHover = isColor;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                                  child: SizedBox(width: 137, child: Text(completeTopCprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                                ),
                              )),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthBudget.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthVariance.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
                            DataCell(Text(completeTopCprData[index].excludedTab[1].currentMonthAchieved.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthAchieved.values.toString().length - 1), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].ytDActualValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].ytDBudgetValue.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].ytDAchieved.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].fullYearBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                            DataCell(Text(Pandora.moneyFormat(completeTopCprData[index].excludedTab[1].runRate.toDouble()).toString(), style: kDealsHeaderStyle)),
                          ]);
                    }),
                  ),
                ),
              ),
            ),
            // if (isRowClicked == true) dummmy(),
            // if (isRowClicked == true) subTableWidget(),
          ],
        );
      },);
  }

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
              Container(alignment: Alignment.centerLeft, child: Text(completeTopCprData[1].mainReport[1].currentMonthBudget.keys.toString().split(' ').map((str) => str + '\n').join(), /*+ ' (₦\'m)',*/ style: kDisburseBlueStyle)),
            ]),
          )),
        ],
        rows: List.generate(completeTopCprData.length, (index) {
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
                DataCell(InkWell(
                  highlightColor: Colors.grey.shade300,
                  onHover: (isColor) {
                    setState((){
                      isHover = isColor;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                    child: SizedBox(width: 137, child: Text(completeTopCprData[index].mainReport[1].incomeType.toString(), style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                  ),
                )),
                DataCell(Text(completeTopCprData[index].mainReport[1].currentMonthBudget.values.toString().substring(1, completeTopCprData[index].mainReport[1].currentMonthVariance.values.toString().length - 1), style: kDealsHeaderStyle)),
              ]);
        }),
      ),
    );
  }






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
                width: 140  ,
                child: Stack(children: [
                  Positioned(left: 128, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 128, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Full Year Budget (₦\'m)', style: kDisburseBlueStyle)),
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
            rows: List.generate(completeTopCprData.length, (index) {
              final customerData = completeTopCprData[index];
              return DataRow(
                  // onSelectChanged: (isSelected) {
                  //   visible = isSelected;
                  // },
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
}


/*
class CprProfitAndLossTableContainer extends StatefulWidget {
  final cprData;

  CprProfitAndLossTableContainer({this.cprData});

  @override
  State<CprProfitAndLossTableContainer> createState() => _CprProfitAndLossTableContainerState();
}

class _CprProfitAndLossTableContainerState extends State<CprProfitAndLossTableContainer> {

  bool isHover = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null && snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return widget.cprData== null ?
        Card(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, left: 10.0, bottom: 7.0),
              child: Text("Data not found...",
                style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ) :
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 2,

          // DataColumn(label: Text('Jan 2023')),
          // DataColumn(label: Text('Feb 2023')),
          // DataColumn(label: Text('Mar 2023')),
          // DataColumn(label: Text('Apr 2023')),
          // DataColumn(label: Text('May 2023')),
          // DataColumn(label: Text('Jun 2023')),
          // DataColumn(label: Text('Jul 2023')),
          // DataColumn(label: Text('Aug 2023')),
          // DataColumn(label: Text('Sep 2023')),
          // DataColumn(label: Text('Oct 2023')),

          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 8.0,
                dataRowHeight: 36,
                headingRowHeight: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
                columns: [
                  DataColumn(label: Container(
                    width: 87,
                    child: Stack(children: [
                      Positioned(left: 55, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 55, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('Category', style: kDisburseBlueStyle)),
                    ]),
                  )),

                  // DataColumn(label: Container(
                  //   width: 100,
                  //   child: Stack(children: [
                  //     Positioned(left: 79, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  //     Positioned(left: 79, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  //     Container(alignment: Alignment.centerLeft, child: Text('Budget Value', style: kDisburseBlueStyle)),
                  //   ]),
                  // )),
                  // DataColumn(label: Container(
                  //   width: 100,
                  //   child: Stack(children: [
                  //     Positioned(left: 83, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  //     Positioned(left: 83, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  //     Container(alignment: Alignment.centerLeft, child: Text('Variance(₦\'m)', style: kDisburseBlueStyle)),
                  //   ]),
                  // )),
                  // DataColumn(label: Container(
                  //   width: 100,
                  //   child: Stack(children: [
                  //     Positioned(left: 85, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  //     Positioned(left: 85, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  //     Container(alignment: Alignment.centerLeft, child: Text('Achieved(₦\'m)', style: kDisburseBlueStyle)),
                  //   ]),
                  // )),

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
                    width: 132,
                    child: Stack(children: [
                      Positioned(left: 114, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 114, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('YTD Achieved (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 148,
                    child: Stack(children: [
                      Positioned(left: 130, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 130, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('FullYear Budget (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                  DataColumn(label: Container(
                    width: 113,
                    child: Stack(children: [
                      Positioned(left: 87, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                      Positioned(left: 87, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                      Container(alignment: Alignment.centerLeft, child: Text('Run Rate (₦\'m)', style: kDisburseBlueStyle)),
                    ]),
                  )),
                ],
                rows: List.generate(widget.cprData.length, (index) {
                  final customerData = widget.cprData[index];
                  print(widget.cprData);
                  // visible == true ? cprDropDown() : Text('');
                  return DataRow(
                    // onSelectChanged: (isSelected) {
                    //   visible = isSelected;
                    // },
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
                          highlightColor: Colors.grey.shade300,
                          onHover: (isColor) {
                            setState((){
                              isHover = isColor;
                              print("OnHover---> $isColor");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            child: SizedBox(width: 137, child: Text(customerData.incomeType, style: (isHover) ? kDisburseBlueStyle : kDealsHeaderStyle)),
                          ),
                        )),

                        // DataCell(Text(Pandora.moneyFormat(customerData.currentMonthBudget.toDouble()).toString(), style: kDealsHeaderStyle)),
                        // DataCell(Text(Pandora.moneyFormat(customerData.currentMonthVariance.toDouble()).toString(), style: kDealsHeaderStyle)),
                        // DataCell(Text(Pandora.moneyFormat(customerData.currentMonthAchieved.toDouble()).toString(), style: kDealsHeaderStyle)),

                        DataCell(Text(Pandora.moneyFormat(customerData.ytD_ACTUAL_VALUE.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(customerData.ytD_BUDGET_VALUE.toDouble()).toString(), style: kDealsHeaderStyle)),DataCell(Text(Pandora.moneyFormat(customerData.actualBalance.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(customerData.variance.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(customerData.ytD_ACHIEVED.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(customerData.full_Year_Budget.toDouble()).toString(), style: kDealsHeaderStyle)),
                        DataCell(Text(Pandora.moneyFormat(customerData.runRate.toDouble()).toString(), style: kDealsHeaderStyle)),
                      ]);
                }),
              ),
            ),
          ),
        );
      },);
  }

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
                width: 140  ,
                child: Stack(children: [
                  Positioned(left: 128, child: Icon(Icons.arrow_drop_up_sharp, color: Colors.grey, size: 18)),
                  Positioned(left: 128, bottom: 0.5, child: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18)),
                  Container(alignment: Alignment.centerLeft, child: Text('Full Year Budget (₦\'m)', style: kDisburseBlueStyle)),
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
              print(widget.cprData);
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
}
*/

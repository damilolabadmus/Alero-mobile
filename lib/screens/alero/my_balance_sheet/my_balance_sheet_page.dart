

import 'dart:ui';
import 'package:alero/models/performance/MyBalanceSheetReponse.dart';
import 'package:alero/models/performance/MyBalanceSheetRmResponse.dart';
import 'package:alero/models/performance/MyBalanceSheetTypeResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/performance/performance_title_container.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:one_context/one_context.dart';
import 'balance_sheet_side_menu.dart';
import 'balance_sheet_table_container.dart';
import 'package:alero/style/theme.dart' as Style;
import 'my_balance_sheet_rm_container.dart';
import 'my_balance_sheet_type_container.dart';

class MyBalanceSheetPage extends StatefulWidget {
  final String? regionId;

  const MyBalanceSheetPage({this.regionId});

  @override
  State<MyBalanceSheetPage> createState() => _MyBalanceSheetPageState();
}

class _MyBalanceSheetPageState extends State<MyBalanceSheetPage> with TickerProviderStateMixin {
  String? selectedDate;

  String? regionId;
  String? regCode;
  String? arCode;
  String? brCode;
  String? rCode;
  String? regionItem;

  String? areaItem;
  String? branchItem;
  String? rmItem;
  String? segmentItem;

  List<String>? areaByRegion;

  var apiService = AleroAPIService();

  String? selectedStartDate;
  late DateTime pickedDate;
  late DateTime twoDaysAgoSelectedDate;
  String? formattedDateStr;
  DateTime? currentSelectedDate;
  late DateTime yesterdayDate;
  late DateTime twoDaysAgo;
  String? previousDate;
  String? previousSelectedDate;
  DateTime? lastDayOfCurrentMonth;
  late DateTime selectedLastDayOfLastMonth;
  late DateTime lastDayOfLastMonth;
  String? selectedLastDayOfLastMonthString;
  String? lastDayOfLastMonthString;
  String? yesterdayDateString;
  String? yesterDayDateString;

  String selectedState = '';

  String? areaId;
  String? zoneId;
  String? areaCode;
  String? branchCode;
  String? rmCode;
  String? date;
  String? regionName;
  String? areaName;
  String? branchName;
  String? rmName;
  String? segment;

  String? appDate;
  String? regionType;
  String? segmentType;
  String? areaType;
  String? branchType;
  String? rmType;

  List<MyBalanceSheetResponse> balanceSheet = [];
  List<MyBalanceSheetResponse> bankDepActual = [];
  List<MyBalanceSheetResponse> bankLoanActual = [];
  List<MyBalanceSheetResponse> segmentBankWide = [];

  List<MyBalanceSheetResponse> bankWideDepAvg = [];
  List<MyBalanceSheetResponse> bankWideLoanAvg = [];
  List<MyBalanceSheetResponse> getBankWideLoanAvg = [];
  List<MyBalanceSheetResponse> avgSegmentBankWide = [];

  List<MyBalanceSheetTypeResponse> regionActual = [];
  List<MyBalanceSheetTypeResponse> areaActual = [];
  List<MyBalanceSheetTypeResponse> branchActual = [];

  List<MyBalanceSheetTypeResponse> regionAvg = [];
  List<MyBalanceSheetTypeResponse> areaAvg = [];
  List<MyBalanceSheetTypeResponse> branchAvg = [];

  List<MyBalanceSheetRmResponse> rmData = [];
  List<MyBalanceSheetRmResponse> actualSegmentRegion = [];
  List<MyBalanceSheetRmResponse> actualSegmentArea = [];
  List<MyBalanceSheetRmResponse> actualSegmentBranch = [];
  List<MyBalanceSheetRmResponse> avgSegmentRegion = [];
  List<MyBalanceSheetRmResponse> avgSegmentArea = [];
  List<MyBalanceSheetRmResponse> avgSegmentBranch = [];

  late AnimationController controller;
  late Animation animation1;
  late Animation animation2;

  Future<List<String>?> getAreaListByRegionId(String regionId) async {
    List<String>? _listOfAreas = await apiService.getAreaList(regionId);
    setState(() {
      areaByRegion = _listOfAreas;
    });
    return areaByRegion;
  }

  final Pandora pandora = new Pandora();
  String? _code;
  Future<String?> getRegionCode() async {
    String reg = await pandora.getFromSharedPreferences('regionItem');
    setState(() async {
      // Future<String> rgCode = pandora.saveToSharedPreferences('regCode', regCode);
      _code = await apiService.getRegionCode(reg);
      regCode = _code;
    });
    return regCode;
  }

  Future<String?> getAreaCode() async {
    var reg = await pandora.getFromSharedPreferences('regionItem');
    var area = await pandora.getFromSharedPreferences('areaItem');
    String? _code = await apiService.getAreaCode(reg, area);
    setState(() {
      arCode = _code;
    });
    return _code;
  }

  Future<String?> getBranchCode(String arCode) async {
    var reg = await pandora.getFromSharedPreferences('regionItem');
    var branc = await pandora.getFromSharedPreferences('branchItem');
    String? _code = await apiService.getBranchCode(reg, arCode, branc);
    setState(() {
      brCode = _code;
    });
    return _code;
  }

  Future<String?> getRmCode(String arCode, String branchCode) async {
    var reg = await pandora.getFromSharedPreferences('regionItem');
    var rmIte = await pandora.getFromSharedPreferences('rmItem');
    String? _code = await apiService.getRmCode(reg, arCode, branchCode, rmIte);
    setState(() {
      rCode = _code;
    });
    return _code;
  }




  DateTime startDate = DateTime.now();

  String bankDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
    );
    if (_datePicker != null && DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      final newSelectedDate = _datePicker.toIso8601String();
      updateSelectedDate(newSelectedDate);
      setState(() {
        selectedDate = _datePicker.toIso8601String();
      });
    }}

  void getDate() {
    if (selectedDate != null) {
      pickedDate = DateTime.parse(selectedDate!);
      selectedStartDate = DateFormat('yyyy-MMM-dd').format(pickedDate);

      twoDaysAgoSelectedDate = pickedDate.subtract(Duration(days: 2));
      previousSelectedDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgoSelectedDate);
      selectedLastDayOfLastMonth = DateTime(pickedDate.year, pickedDate.month, 0);
      selectedLastDayOfLastMonthString = DateFormat('yyyy-MMM-dd').format(selectedLastDayOfLastMonth);

    } else {
      yesterdayDate = startDate.subtract(Duration(days: 1));
      twoDaysAgo = startDate.subtract(Duration(days: 2));
      previousDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgo);
      lastDayOfLastMonth = DateTime(startDate.year, startDate.month, 0);
      lastDayOfLastMonthString = DateFormat('yyyy-MMM-dd').format(lastDayOfLastMonth);
      yesterdayDateString = DateFormat('yyyy-MM-dd').format(yesterdayDate);
      yesterDayDateString = DateFormat('yyyy-MMM-dd').format(yesterdayDate);
    }}

  void updateSelectedDate(String newSelectedDate) {
    setState(() {
      selectedDate = newSelectedDate;
    });
  }

  List<String>? regionList;
  Future<List<String>?> getRegionList() async {
    List<String>? _listOfRegions = await apiService.getRegionList();
    setState(() {
      regionList = _listOfRegions;
    });
    return regionList;
  }

  List<String> regionLis = [
    'HEAD OFFICE',
    'SOUTH',
    'NORTH 1',
    'NORTH 2',
    'NORTH 3',
    'LAGOS AND SOUTHWEST',
    'CORPORATE BANKING GROUP',
    'TREASURY'
  ];

  List<String> segmentList = [
      'SME',
      'RETAIL',
      'COMMERCIAL',
      'PUBLIC SECTOR',
      'CORPORATE',
      'UNTAGGED',
  ];

  List<String>? branchByArea;
  Future<List<String>?> getBranchListByAreaCode(String areaCode) async {
      List<String>? _branchArea = await apiService.getBranchList(areaCode);
      setState(() {
        branchByArea = _branchArea;
      });
      return branchByArea;
    }

  List<String>? rmByBranch;
  Future<List<String>?> getRmListByAreaCode(String branchCode) async {
    List<String>? _rmBranch = await apiService.getRmList(branchCode);
    setState(() {
      rmByBranch = _rmBranch;
    });
    return rmByBranch;
  }

  @override
  void initState() {
    super.initState();

    getDate();

    active = false;
    isActive = true;

    getRegionList();

    getAreaListByRegionId('SO001');
    getBranchListByAreaCode('IMO001');
    getRmListByAreaCode('010');

    getBankWideDepositActualData(selectedDate == null ? yesterdayDateString! : selectedDate!);
    getBankWideLoanActualData(selectedDate == null ? yesterdayDateString! : selectedDate!);

    getRegionActualData(selectedDate == null ? yesterdayDateString! : selectedDate!, 'SOUTH');
    getAreaActualData('SO001', 'DELTA', selectedDate == null ? yesterdayDateString! : selectedDate!);
    getBranchActualData('IMO001', 'ORLU', selectedDate == null ? yesterdayDateString! : selectedDate!);
    getRmData('WFG10289', selectedDate == null ? yesterdayDateString! : selectedDate!);


    getBankWideDepositAvgData(selectedDate == null ? yesterdayDateString! : selectedDate!);
    getBankWideLoanAvgData(selectedDate == null ? yesterdayDateString! : selectedDate!);
    getRegionAvgData('SO001');
    getAreaAvgData('SO001', 'DELTA', selectedDate == null ? yesterdayDateString! : selectedDate!);
    getBranchAvgData('IMO001', '010', selectedDate == null ? yesterdayDateString! : selectedDate!);


    getActualSegmentBankWideData('2023-07-24', 'SME'); // DON'T USE ANOTHER DATE and api response is very slow
    getActualSegmentRegionData('SME', selectedDate == null ? yesterdayDateString! : selectedDate!, 'SO001');
    getActualSegmentAreaData('SO001', 'SME', 'IMO001', selectedDate == null ? yesterdayDateString! : selectedDate!); // OR
    getActualSegmentBranchData('IMO001', 'SME', '010', selectedDate == null ? yesterdayDateString : selectedDate);

    getAvgSegmentBankWideData(selectedDate == null ? yesterdayDateString! : selectedDate!, 'Sme'); // Make Sure you use camel case for segment e.g. Sme, Corporate, etc
    getAvgSegmentRegionData('SME', selectedDate == null ? yesterdayDateString! : selectedDate!, 'SO001');
    getAvgSegmentAreaData('SO001', 'SME', selectedDate == null ? yesterdayDateString! : selectedDate!);
    getAvgSegmentBranchData('IMO001', 'SME', selectedDate == null ? yesterdayDateString! : selectedDate!);


    controller = AnimationController(vsync: this, duration: Duration(seconds: 1),);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation2 = ColorTween(begin: Colors.white12, end: Colors.black54).animate(controller);
    controller.forward();

    animation1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.addListener(() {
      setState(() {});
    });
  }


  // Geography actual...
  Future<List<MyBalanceSheetResponse>> getBankWideDepositActualData(String date) async {
    List<MyBalanceSheetResponse> depData;
    depData = await apiService.getBankWideDepositActual(date);
      setState(() {
        bankDepActual = depData;
      });
    return bankDepActual;
  }

  Future<List<MyBalanceSheetResponse>> getBankWideLoanActualData(String date) async {
      List<MyBalanceSheetResponse> bankLoan;
      bankLoan = await apiService.getBankWideLoanActual(date);
        setState(() {
          bankLoanActual = bankLoan;
        });
      return bankLoanActual;
  }

  Future<List<MyBalanceSheetTypeResponse>> getRegionActualData(String date, String regionName) async {
    List<MyBalanceSheetTypeResponse> regionActualData;
    regionActualData = await apiService.getRegionActual(date, regionName);
    setState(() {
      regionActual = regionActualData;
    });

    return regionActualData;
  }

  Future<List<MyBalanceSheetTypeResponse>> getAreaActualData(String regionId, String area, String date) async {
      List<MyBalanceSheetTypeResponse> areaActualData;
      areaActualData = await apiService.getAreaActual(regionId, area, date);
        setState(() {
          areaActual = areaActualData;
        });
      return areaActual;
  }

  Future<List<MyBalanceSheetTypeResponse>> getBranchActualData(String zoneId, String branch, String date) async {
      List<MyBalanceSheetTypeResponse> branchActualData;
      branchActualData = await apiService.getBranchActual(zoneId, branch, date);
        setState(() {
          branchActual = branchActualData;
        });
      return branchActual;
  }

  // Geography Average...
  Future<List<MyBalanceSheetResponse>> getBankWideDepositAvgData(String date) async {
    List<MyBalanceSheetResponse> bankWideDepAvg;
    bankWideDepAvg = await apiService.getBankWideDepositAvg(date);
      setState(() {
        bankWideDepAvg = bankWideDepAvg;
      });
    return bankWideDepAvg;
  }

  Future<List<MyBalanceSheetResponse>> getBankWideLoanAvgData(String date) async {
    List<MyBalanceSheetResponse> bankWideLoanAvgData;
    bankWideLoanAvgData = await apiService.getBankWideLoanAvg(date);
      setState(() {
        bankWideLoanAvg = bankWideLoanAvgData;
      });
    return bankWideLoanAvg;
  }

  Future<List<MyBalanceSheetTypeResponse>> getRegionAvgData(String regionId) async {
      List<MyBalanceSheetTypeResponse> regionAvgData;
      regionAvgData = await apiService.getRegionAvg(regionId);
        setState(() {
          regionAvg = regionAvgData;
        });
      return regionAvg;
  }

  Future<List<MyBalanceSheetTypeResponse>> getAreaAvgData(String regionId, String area,String date) async {
    List<MyBalanceSheetTypeResponse> areaAvgData;
    areaAvgData = await apiService.getAreaAvg(regionId, area, date);
      setState(() {
        areaAvg = areaAvgData;
      });
    return areaAvg;
  }

  // Not working = check AleroApiService
  Future<List<MyBalanceSheetTypeResponse>> getBranchAvgData(String zoneId, String branchCode, String date) async {
    List<MyBalanceSheetTypeResponse> branchAvgData;
    branchAvgData = await apiService.getBranchAvg(zoneId, branchCode, date);
      setState(() {
        branchAvg = branchAvgData;
      });
    return branchAvg;
  }

  // Segment Actual..
  Future<List<MyBalanceSheetResponse>> getActualSegmentBankWideData(String date, String segment) async {
    List<MyBalanceSheetResponse> segmentBankWideData;
    segmentBankWideData = await apiService.getActualSegmentBankWide(date, segment);
      setState(() {
        segmentBankWide = segmentBankWideData;
      });
    return segmentBankWide;
  }

  Future<List<MyBalanceSheetRmResponse>> getActualSegmentRegionData(String segment, String runDate, String regionCode) async {
      List<MyBalanceSheetRmResponse> actualSegmentRegionData;
      actualSegmentRegionData = await apiService.getActualSegmentRegion(segment, runDate, regionCode);
        setState(() {
          actualSegmentRegion = actualSegmentRegionData;
        });
      return actualSegmentRegion;
  }

  Future<List<MyBalanceSheetRmResponse>> getActualSegmentAreaData(String regionCode, String segment, String areaId, String date) async {
      List<MyBalanceSheetRmResponse> actualSegmentAreaData;
      actualSegmentAreaData = await apiService.getActualSegmentArea(regionCode, segment, areaId, date);
        setState(() {
          actualSegmentArea = actualSegmentAreaData;
        });
      return actualSegmentArea;
  }

  Future<List<MyBalanceSheetRmResponse>> getActualSegmentBranchData(String areaCode, String segment, branchCode, runDate) async {
        List<MyBalanceSheetRmResponse> actualSegmentBranchData;
        actualSegmentBranchData = await apiService.getActualSegmentBranch(areaCode, segment, branchCode, runDate);
          setState(() {
            actualSegmentBranch = actualSegmentBranchData;
          });
        return actualSegmentBranch;
  }

  // Segment Average...
  Future<List<MyBalanceSheetResponse>> getAvgSegmentBankWideData(String date, String segment) async {
    List<MyBalanceSheetResponse> avgSegmentBankWideData;
    avgSegmentBankWideData = await apiService.getAvgSegmentBankWide(date, segment);
    setState(() {
      avgSegmentBankWide = avgSegmentBankWideData;
    });
    return avgSegmentBankWide;
  }

  Future<List<MyBalanceSheetRmResponse>> getAvgSegmentRegionData(String segment, String date, String regionCode) async {
    List<MyBalanceSheetRmResponse> avgSegmentRegionData;
    avgSegmentRegionData = await apiService.getAvgSegmentRegion(segment, date, regionCode);
    setState(() {
      avgSegmentRegion = avgSegmentRegionData;
    });
    return avgSegmentRegion;
  }

  Future<List<MyBalanceSheetRmResponse>> getAvgSegmentAreaData(String division, String segment, String date) async {
    List<MyBalanceSheetRmResponse> avgSegmentAreaData;
    avgSegmentAreaData = await apiService.getAvgSegmentArea(division, segment, date);
    setState(() {
      avgSegmentArea = avgSegmentAreaData;
    });
    return avgSegmentArea;
  }

  Future<List<MyBalanceSheetRmResponse>> getAvgSegmentBranchData(String cluster, String segment, String date) async {
      List<MyBalanceSheetRmResponse> avgSegmentBranchData;
      avgSegmentBranchData = await apiService.getAvgSegmentBranch(cluster, segment, date);
      setState(() {
        avgSegmentBranch = avgSegmentBranchData;
      });
      return avgSegmentBranch;
  }

  Future<List<MyBalanceSheetRmResponse>> getRmData(String rmCode, String date) async {
      List<MyBalanceSheetRmResponse> avgSegmentRmData;
      avgSegmentRmData = await apiService.getRmAvg(rmCode, date);
      setState(() {
        rmData = avgSegmentRmData;
      });
      return rmData;
  }

  String measureType = 'Actual';

  bool active = true;
  bool isActive = false;

  bool isSegment = false;
  bool isRegion = true;

  bool isColor = false;
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.lightBlue.shade50,
        ),
        child: BalanceSheetSideMenu(
          isActive: isActive,
          active: active,
          tap : () {
            setState(() {
              active = true;
              isActive = false;
            });
            setState(() {});
          },
            ontap: () {
              setState(() {
                active = false;
                isActive = true;
              });
              setState(() {});
          }
        ),
      ),
       resizeToAvoidBottomInset: false,
       body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 12, right: 5),
              child: Column(
                  children: [
                    Container(
                      height: 40,
                      color: Style.Colors.searchActiveBg,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Builder(
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () =>
                                          Scaffold.of(context).openDrawer(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 13.0, left: 10),
                                        child: Icon(EvaIcons.menu2Outline, color: Colors.black38.withOpacity(0.5),
                                          size: 28,
                                        ),
                                      ),
                                    );
                                  }
                               ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_right_alt, size: 30,
                                        color: animation2.value),
                                    Text('slide',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: animation2.value,
                                        fontFamily: 'Poppins-Regular'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                         Padding(
                           padding: const EdgeInsets.only(right: 16.0),
                           child: IconButton(
                             icon: Icon(Icons.home),
                             color: Colors.black54,
                             iconSize: 30.0,
                             onPressed: () {
                               Navigator.of(context)
                                   .pushNamedAndRemoveUntil(
                                   '/landing', (Route<dynamic> route) => false);
                             },
                           ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('My Balance Sheet',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular',
                          ),),
                        SizedBox(width: 2),
                        Text(isActive == true ? '(ACTUAL)' : '(AVERAGE)',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular',
                          ),),
                        areaType != null && branchType == null && rmType == null ? Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Container(
                              width: areaType != null ? areaType!.length > 12 ? 100.0 : null : null,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(areaType!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Regular',
                                ),
                                  softWrap: false,
                                overflow: TextOverflow.ellipsis),
                            )) :
                        areaType != null && branchType != null && rmType == null ? Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Container(
                              width: branchType != null ? branchType!.length > 12 ? 100.0 : null : null,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(branchType!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Regular',
                                ),softWrap: false,
                                  overflow: TextOverflow.ellipsis),
                            )) :
                        areaType != null && branchType != null && rmType != null  ? Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Container(
                              width: rmType != null ? rmType!.length > 12 ? 100.0 : null : null,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(rmType!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Regular',
                                ),softWrap: false,
                                  overflow: TextOverflow.ellipsis),
                            )) :
                        segmentType != null && rmType != null && branchType != null ? Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Container(
                              width: segmentType != null ? segmentType!.length > 12 ? 100.0 : null : null,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(segmentType!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Regular',
                                ),softWrap: false,
                                  overflow: TextOverflow.ellipsis),
                            ))
                        : Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Container(
                                width: regionType != null ? regionType!.length > 12 ? 100.0 : null : null,
                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(8.0)),
                                child: Text(regionType == null ? 'Bank' : regionType!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins-Regular',
                                  ),softWrap: false,
                                    overflow: TextOverflow.ellipsis),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        PopupMenuButton<String>(
                          itemBuilder: regionType == null && areaType == null && branchType == null && rmType == null
                              ? (context) {
                            return regionList == null ? regionLis.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList() : regionList!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : regionType != null && areaType == null && branchType == null && rmType == null ?
                              (context) {
                            return areaByRegion == null ? [] : areaByRegion!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : regionType != null && areaType != null && branchType == null && rmType == null ?
                              (context) {
                            return branchByArea == null ? [] : branchByArea!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          }
                          : regionType != null && areaType != null && branchType != null && rmType == null ? (context) {
                            return rmByBranch == null ? [] : rmByBranch!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : (context) {
                            return rmByBranch == null ? [] : rmByBranch!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(regionType == null && areaType == null && branchType == null ? 'View by Region'
                                      : regionType != null && areaType == null && branchType == null ? 'View by Area'
                                      : regionType != null && areaType != null && branchType == null ? 'View by Branch'
                                      : 'View By Rm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: 23),
                                ],
                              ),
                          ),
                          onSelected: (item) {
                            setState(() {
                              regionType == null && areaType == null && branchType == null ? regionType = item
                                  : regionType != null && areaType == null && branchType == null ? areaType = item
                              : regionType != null && areaType != null && branchType == null ? branchType = item
                                  : rmType = item;

                              regionItem = regionType;
                              areaItem = areaType;
                              branchItem = branchType;
                              rmItem = rmType;

                              pandora.saveToSharedPreferences('regionItem', regionItem!);
                              pandora.saveToSharedPreferences('areaItem', areaItem!);
                              pandora.saveToSharedPreferences('branchItem', branchItem!);
                              pandora.saveToSharedPreferences('rmItem', rmItem!);

                            });
                          },
                        ),
                        SizedBox(width: 7),
                        PopupMenuButton<String>(
                          itemBuilder: segmentType == null ?
                              (context) {
                            return segmentList.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : regionType != null ?
                            (context) {
                            return regionList!.map((item) {
                             return PopupMenuItem(
                              value: item,
                              child: Text(item),
                              );
                             }).toList();
                            }
                           : areaType != null ?
                              (context) {
                            return areaByRegion!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : branchType != null ?
                              (context) {
                            return branchByArea!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          } : rmType != null ?
                              (context) {
                            return rmByBranch!.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          }
                          : (context) {
                            return segmentList.map((item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 35,
                            width: 152,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.shade200,
                                borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(segmentType == null ? 'View by Segment'
                                      : segmentType != null && regionType != null && areaType == null && branchType == null && rmType == null ? 'Other Regions'
                                      : segmentType != null && regionType != null && areaType != null && branchType == null && rmType == null ? 'Other Areas'
                                      : segmentType != null && regionType != null && areaType != null && branchType != null && rmType == null ? 'Other Branches'
                                      : segmentType != null && regionType != null && areaType != null && branchType != null && rmType != null ? 'Other Rms'
                                      : 'Other Segments',
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: 23),
                                ],
                              ),
                            // ),
                          ),
                          onSelected: (item) {
                            setState(() {
                              segmentType == null ? segmentType = item
                                  : regionType != null ? regionType = item
                                  : areaType != null ? areaType = item
                                  : branchType != null ? branchType = item
                                  : rmType != null ? rmType = item
                                  : segmentType != null ? segmentType = item
                                : segmentType = item;

                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    PmTitleContainer(
                      measure: isActive == true ? 'Actual Balance Sheet' : 'AVG Balance Sheet',
                      subTitle: segmentType == null ?
                            regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : null
                          : regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : segmentType,

                      subText: segmentType == null ?
                        regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Bank'
                          : regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Segment',
                      selectedDate: selectedDate == null ? yesterdayDateString : DateFormat('yyyy-MM-dd').format(DateTime.parse(selectedDate!)),
                      selectDate: () {
                        setState(() {
                          _selectDate(context);
                        });
                      },
                      // updateSelectedDate: updateSelectedDate,
                    ),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    elevation: 5,
                    child:
                    regionActual.isNotEmpty ?
                      active == false ?
                        segmentType == null ?
                          regionType == null && areaType == null && branchType == null && rmType == null ?
                            MyBalanceSheetTableContainer(
                              balanceSheetDepData: bankDepActual,
                              balanceSheetLoanData: bankLoanActual,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            )
                              : regionType != null && areaType == null && branchType == null && rmType == null ?
                            MyBalanceSheetTypeContainer(
                              balanceSheetData: regionActual,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            ) : regionType != null && areaType != null && branchType == null && rmType == null ?
                            MyBalanceSheetTypeContainer(
                              balanceSheetData: areaActual,  // date = June 5
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            ) : regionType != null && areaType != null && branchType != null && rmType == null ?
                            MyBalanceSheetTypeContainer(
                              balanceSheetData: branchActual,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            ) : MyBalanceSheetRmContainer(
                              balanceSheetData: rmData,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            )
                          :
                            regionType == null && areaType == null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                                balanceSheetData: segmentBankWide,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) : // date = 2023-07-24
                            regionType != null && areaType == null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                                balanceSheetData: actualSegmentRegion,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) :
                            regionType != null && areaType != null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                                balanceSheetData: actualSegmentArea,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) :
                            regionType != null && areaType != null && branchType != null && rmType == null ?
                             MyBalanceSheetRmContainer(
                              balanceSheetData: actualSegmentBranch,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            ) : MyBalanceSheetRmContainer(
                              balanceSheetData: rmData,
                              selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                              previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                              monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                            )
                         :
                            segmentType == null ?
                              regionType == null && areaType == null && branchType == null && rmType == null ?
                                MyBalanceSheetTableContainer(
                                  balanceSheetDepData: bankWideDepAvg,
                                  balanceSheetLoanData: bankWideLoanAvg,
                                  selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                  previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                  monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                                ) :
                               regionType != null && areaType == null && branchType == null && rmType == null ?
                                 MyBalanceSheetTypeContainer(
                                   balanceSheetData: regionAvg,
                                   selectedStartDate: selectedDate == null ? yesterDayDateString : selectedStartDate,
                                   previousDate: selectedDate == null ? previousDate : previousSelectedDate,
                                   monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                                 ) :
                               regionType != null && areaType != null && branchType == null && rmType == null ?
                                 MyBalanceSheetTypeContainer(
                                   balanceSheetData: areaAvg,  // date = June 5
                                   selectedStartDate: selectedDate == null ? yesterDayDateString : selectedStartDate,
                                   previousDate: selectedDate == null ? previousDate : previousSelectedDate,
                                   monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                                ) :
                               regionType != null && areaType != null && branchType != null && rmType == null ?
                                MyBalanceSheetTypeContainer(
                                 balanceSheetData: branchAvg,
                                 selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                 previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                 monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                                ) :
                                MyBalanceSheetRmContainer(
                                  balanceSheetData: rmData,
                                  selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                  previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                  monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                                )
                          :

                            regionType == null && areaType == null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                                balanceSheetData: avgSegmentBankWide,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) : // date = 2023-07-24
                            regionType != null && areaType == null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                               balanceSheetData: avgSegmentRegion,
                               selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                               previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                               monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) :
                            regionType != null && areaType != null && branchType == null && rmType == null ?
                              MyBalanceSheetRmContainer(
                                balanceSheetData: avgSegmentArea,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                               monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) :
                            regionType != null && areaType != null && branchType != null && rmType == null ?
                              MyBalanceSheetTypeContainer(
                                balanceSheetData: avgSegmentBranch,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              ) :
                              MyBalanceSheetRmContainer(
                                balanceSheetData: rmData,
                                selectedStartDate: selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!)),
                                previousDate: selectedDate == null ? previousDate : previousSelectedDate ?? DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate!).subtract(Duration(days: 1))),
                                monthEndDate: selectedDate == null ? lastDayOfLastMonthString : selectedLastDayOfLastMonthString,
                              )
                        : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PipelineDealsHeader(title: 'Category'),
                                PipelineDealsHeader(title: selectedStartDate == null ? yesterDayDateString ?? '(₦\'m)' : selectedStartDate ?? '(₦\'m)'),
                                PipelineDealsHeader(title: bankDate + '(₦\'m)'),
                                PipelineDealsHeader(title: 'Variance (₦\'m)'),
                                PipelineDealsHeader(title: selectedDate != null ? selectedLastDayOfLastMonthString ?? '(₦\'m)' : lastDayOfLastMonthString ?? '(₦\'m)'),
                                PipelineDealsHeader(title: 'MTD Variance (₦\'m)'),
                                PipelineDealsHeader(title: 'Category Code (₦\'m)'),
                                PipelineDealsHeader(title: 'Budget (₦\'m)'),
                                ],),),)
                 ),
                ],
              ),
            ),
          ),
        ),
      bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      position = 0;
                    });
                  },
                  child: Stack(
                    children: [
                      InkWell(
                        child: SvgPicture.asset(
                          'assets/customer/profile_dashboard.svg',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              height: 3,
                              width: position == 0 ? 26 : 0,
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400.withOpacity(0.8),
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                            )),
                      ),
                    ],
                  ),
                ),
          GestureDetector(
            onTap: () {
              setState(() {
                position = 1;
              });
            },
            child: Stack(
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/customer/profile_logout.svg',
                  ),
                  onTap: () {
                    logoutUser(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        height: 3,
                        width: position == 1 ? 25 : 0,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400.withOpacity(0.8),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      )),
                ),
              ],
            ),
          )
          ],
        ),
      )));
  }


  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


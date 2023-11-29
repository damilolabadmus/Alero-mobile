import 'package:alero/models/performance/MprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/concession/concession_bottom_nav_bar.dart';
import 'package:alero/screens/alero/performance/pm_title_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'mpr_table_container.dart';

class MonthlyProfitabilityReport extends StatefulWidget {
  final String userId;

  MonthlyProfitabilityReport({@required this.userId});

  @override
  State<MonthlyProfitabilityReport> createState() =>
      _MonthlyProfitabilityReportState();
}

class _MonthlyProfitabilityReportState extends State<MonthlyProfitabilityReport> {
  var apiService = AleroAPIService();

  Function search;
  List<MprResponse> mprSummary = [];

  String regionType;
  String segmentType;
  String areaType;
  String branchType;
  String rmType;

  String regionItem;
  String areaItem;
  String branchItem;
  String rmItem;

  List<MprResponse> mprBankWide = [];
  List<MprResponse> regionGeoMpr = [];
  List<MprResponse> areaGeoMpr = [];
  List<MprResponse> segmentBranchNrff = [];
  List<MprResponse> branchGeoMpr = [];
  List<MprResponse> rmGeoMpr = [];
  List<MprResponse> mprSegment = [];

  Function selectDate;
  DateTime startDate = DateTime.now();
  String selectedDate;
  String bankDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));
    if (_datePicker != null &&
        DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      setState(() {
        selectedDate = _datePicker.toIso8601String();
      });
    }
  }

  List<String> segmentList = [
    'SME',
    'RETAIL',
    'COMMERCIAL',
    'PUBLIC SECTOR',
    'CORPORATE',
    'UNTAGGED',
  ];

  List<String> regionList;
  Future<List<String>> getRegionList() async {
    List<String> _listOfRegions = await apiService.getRegionList();
    setState(() {
      regionList = _listOfRegions;
    });
    return regionList;
  }

  List<String> areaByRegion;
  Future<List<String>> getAreaListByRegionId(String regionId) async {
    List<String> _listOfAreas = await apiService.getAreaList(regionId);
    setState(() {
      areaByRegion = _listOfAreas;
    });
    return areaByRegion;
  }

  List<String> branchByArea;
  Future<List<String>> getBranchListByAreaCode(String areaCode) async {
    List<String> _branchArea = await apiService.getBranchList(areaCode);
    setState(() {
      branchByArea = _branchArea;
    });
    return branchByArea;
  }

  List<String> rmByBranch;
  Future<List<String>> getRmListByAreaCode(String branchCode) async {
    List<String> _rmBranch = await apiService.getRmList(branchCode);
    setState(() {
      rmByBranch = _rmBranch;
    });
    return rmByBranch;
  }

  @override
  void initState() {
    super.initState();
    getRegionList();
    getAreaListByRegionId('NO003');
    getBranchListByAreaCode('ABU003');
    getRmListByAreaCode('251');

    getBankWideMpr(selectedDate);
    getRegionMpr('NORTH 3', 'NO003', '2023-05-06', '2023-06-06');
    getAreaMpr('ABUJA 2', 'ABU002', '2023-05-06', '2023-06-06');
    getBranchMpr('DEI-DEI', '180', '2023-05-06', '2023-06-06');
    getRmMpr('Shola Meseru', 'NDA11544', '2023-05-06', '2023-06-06');

    getSegmentMpr('RETAIL', '2023-05-06', '2023-06-06');
  }

  Future<List<MprResponse>> getBankWideMpr(String reportDate) async {
    List<MprResponse> _monthlyPr;
    _monthlyPr = await apiService.getBankWideMprData(reportDate);
    setState(() {
      mprBankWide = _monthlyPr;
    });
    return mprBankWide;
  }

  Future<dynamic> getRegionMpr(String reportLevel, String regionId, String startDate, String endDate) async {
    List<MprResponse> _regionMprData;
    _regionMprData = await apiService.getMprGeoRegionData(reportLevel, regionId, startDate, endDate);
    setState(() {
      regionGeoMpr = _regionMprData;
    });
    return regionGeoMpr;
  }

  Future<dynamic> getAreaMpr(String reportLevel, String areaId, String startDate, String endDate) async {
    List<MprResponse> _areaMprData;
    _areaMprData = await apiService.getMprGeoAreaData(reportLevel, areaId, startDate, endDate);
    setState(() {
      areaGeoMpr = _areaMprData;
    });
    return areaGeoMpr;
  }

  Future<dynamic> getBranchMpr(String reportLevel, String branchId, String startDate, String endDate) async {
    List<MprResponse> _branchMprData;
    _branchMprData = await apiService.getMprGeoBranchData(reportLevel, branchId, startDate, endDate);
    setState(() {
      branchGeoMpr = _branchMprData;
    });
    return branchGeoMpr;
  }

  Future<List<MprResponse>> getRmMpr(String reportLevel, String rmCode, String startDate, String endDate) async {
    List<MprResponse> _rmMprData;
    _rmMprData = await apiService.getRmMprData(reportLevel, rmCode, startDate, endDate);
    setState(() {
      rmGeoMpr = _rmMprData;
    });
    return rmGeoMpr;
  }

  Future<List<MprResponse>> getSegmentMpr(String segmentId, String startDate, String endDate) async {
    List<MprResponse> _mprSegmentBankWideData;
    _mprSegmentBankWideData = await apiService.getSegmentMprData(segmentId, startDate, endDate);
    setState(() {
      mprSegment = _mprSegmentBankWideData;
    });
    return mprSegment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Profitability Report',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  areaType != null && branchType == null && rmType == null ? Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Container(
                        width: areaType != null ? areaType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(areaType,
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
                        width: branchType != null ? branchType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(branchType,
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
                        width: rmType != null ? rmType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(rmType,
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
                        width: segmentType != null ? segmentType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(segmentType,
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
                      width: regionType != null ? regionType.length > 12 ? 100.0 : null : null,
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(regionType == null ? 'Bank' : regionType,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-Regular',
                          ),softWrap: false,
                          overflow: TextOverflow.ellipsis),),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  segmentType == null ?
                  PopupMenuButton<String>(
                    itemBuilder: regionType == null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType != null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null && areaType != null &&
                        branchType != null &&
                        rmType == null
                        ? (context) {
                      return rmByBranch.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : (context) {
                          return rmByBranch.map((item) {
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
                              Text(
                                  regionType == null && areaType == null && branchType == null
                                      ? 'View by Region'
                                      : regionType != null &&
                                      areaType == null &&
                                      branchType == null
                                      ? 'View by Area'
                                      : regionType != null &&
                                      areaType != null &&
                                      branchType == null
                                      ? 'View by Branch'
                                      : 'View By Rm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.white, size: 23),
                            ],
                          ),
                          // ),
                        ),
                        onSelected: (item) {
                          setState(() {
                            regionType == null && areaType == null && branchType == null ? regionType = item : regionType != null && areaType == null && branchType == null ? areaType = item
                                : regionType != null && areaType != null && branchType == null ? branchType = item : rmType = item;

                            regionItem = regionType;
                            areaItem = areaType;
                            branchItem = branchType;
                            rmItem = rmType;

                          });
                        },
                      )
                      : PopupMenuButton<String>(
                    itemBuilder: regionType == null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                      }
                        : regionType != null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType != null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null && areaType != null &&
                        branchType != null &&
                        rmType == null
                        ? (context) {
                      return rmByBranch.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : (context) {
                      return rmByBranch.map((item) {
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
                          Text(
                              regionType == null && areaType == null && branchType == null
                                  ? 'View by Region'
                                  : regionType != null &&
                                  areaType == null &&
                                  branchType == null
                                  ? 'View by Area'
                                  : regionType != null &&
                                  areaType != null &&
                                  branchType == null
                                  ? 'View by Branch'
                                  : 'View By Rm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 23),
                        ],
                      ),
                      // ),
                    ),
                    onSelected: (item) {
                      setState(() {
                        regionType == null && areaType == null && branchType == null ? regionType = item : regionType != null && areaType == null && branchType == null ? areaType = item
                            : regionType != null && areaType != null && branchType == null ? branchType = item : rmType = item;

                        regionItem = regionType;
                        areaItem = areaType;
                        branchItem = branchType;
                        rmItem = rmType;

                      });
                    },
                  ),
                  SizedBox(width: 7),
                  PopupMenuButton<String>(
                    itemBuilder: segmentType == null
                        ? (context) {
                      return segmentList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : areaType != null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : branchType != null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : rmType != null
                        ? (context) {
                      return rmByBranch.map((item) {
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 23),
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
                  measure: 'MPR',
                  subTitle: segmentType == null ?
                  regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : null
                      : regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : segmentType,

                  subText: segmentType == null ?
                  regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Bank'
                      : regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Segment',

                  selectedDate: selectedDate == null
                      ? bankDate
                      : DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(selectedDate)),
                  selectDate: () {
                    setState(() {
                      _selectDate(context);
                    });
                  }),

                 segmentType == null ?
                  regionType == null && areaType == null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: mprBankWide)
                      : regionType != null && areaType == null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: regionGeoMpr)
                      : regionType != null && areaType != null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: areaGeoMpr)
                      : regionType != null && areaType != null && branchType != null && rmType == null ?
                  MprTableContainer(mprData: branchGeoMpr)
                      : MprTableContainer(mprData: rmGeoMpr)
                      :
                  MprTableContainer(mprData: mprSegment)
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}



/*
class MonthlyProfitabilityReport extends StatefulWidget {
  final String userId;

  MonthlyProfitabilityReport({@required this.userId});

  @override
  State<MonthlyProfitabilityReport> createState() =>
      _MonthlyProfitabilityReportState();
}

class _MonthlyProfitabilityReportState extends State<MonthlyProfitabilityReport> {
  var apiService = AleroAPIService();

  Function search;
  List<MprResponse> mprSummary = [];

  String regionType;
  String segmentType;
  String areaType;
  String branchType;
  String rmType;

  String regionItem;
  String areaItem;
  String branchItem;
  String rmItem;

  List<MprResponse> mprBankWide = [];
  List<MprResponse> regionGeoMpr = [];
  List<MprResponse> areaGeoMpr = [];
  List<MprResponse> segmentBranchNrff = [];
  List<MprResponse> branchGeoMpr = [];
  List<MprResponse> rmGeoMpr = [];
  List<MprResponse> mprSegment = [];

  Function selectDate;
  DateTime startDate = DateTime.now();
  String selectedDate;
  String bankDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));
    if (_datePicker != null &&
        DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      setState(() {
        selectedDate = _datePicker.toIso8601String();
      });
    }
  }

  List<String> segmentList = [
    'SME',
    'RETAIL',
    'COMMERCIAL',
    'PUBLIC SECTOR',
    'CORPORATE',
    'UNTAGGED',
  ];

  List<String> regionList;
  Future<List<String>> getRegionList() async {
    List<String> _listOfRegions = await apiService.getRegionList();
    setState(() {
      regionList = _listOfRegions;
    });
    return regionList;
  }

  List<String> areaByRegion;
  Future<List<String>> getAreaListByRegionId(String regionId) async {
    List<String> _listOfAreas = await apiService.getAreaList(regionId);
    setState(() {
      areaByRegion = _listOfAreas;
    });
    return areaByRegion;
  }

  List<String> branchByArea;
  Future<List<String>> getBranchListByAreaCode(String areaCode) async {
    List<String> _branchArea = await apiService.getBranchList(areaCode);
    setState(() {
      branchByArea = _branchArea;
    });
    return branchByArea;
  }

  List<String> rmByBranch;
  Future<List<String>> getRmListByAreaCode(String branchCode) async {
    List<String> _rmBranch = await apiService.getRmList(branchCode);
    setState(() {
      rmByBranch = _rmBranch;
    });
    return rmByBranch;
  }

  @override
  void initState() {
    super.initState();
    getRegionList();
    getAreaListByRegionId('NO003');
    getBranchListByAreaCode('ABU003');
    getRmListByAreaCode('251');

    getBankWideMpr('2023-05-06');
    getRegionMpr('NORTH 3', 'NO003', '2023-05-06', '2023-06-06');
    getAreaMpr('ABUJA 2', 'ABU002', '2023-05-06', '2023-06-06');
    getBranchMpr('DEI-DEI', '180', '2023-05-06', '2023-06-06');
    getRmMpr('Shola Meseru', 'NDA11544', '2023-05-06', '2023-06-06');

    getSegmentMpr('RETAIL', '2023-05-06', '2023-06-06');
  }

  Future<List<MprResponse>> getBankWideMpr(String reportDate) async {
    List<MprResponse> _monthlyPr;
    _monthlyPr = await apiService.getBankWideMprData(reportDate);
    setState(() {
      mprBankWide = _monthlyPr;
    });
    return mprBankWide;
  }

  Future<dynamic> getRegionMpr(String reportLevel, String regionId, String startDate, String endDate) async {
    List<MprResponse> _regionMprData;
    _regionMprData = await apiService.getMprGeoRegionData(reportLevel, regionId, startDate, endDate);
    setState(() {
      regionGeoMpr = _regionMprData;
    });
    return regionGeoMpr;
  }

  Future<dynamic> getAreaMpr(String reportLevel, String areaId, String startDate, String endDate) async {
    List<MprResponse> _areaMprData;
    _areaMprData = await apiService.getMprGeoAreaData(reportLevel, areaId, startDate, endDate);
    setState(() {
      areaGeoMpr = _areaMprData;
    });
    return areaGeoMpr;
  }

  Future<dynamic> getBranchMpr(String reportLevel, String branchId, String startDate, String endDate) async {
    List<MprResponse> _branchMprData;
    _branchMprData = await apiService.getMprGeoBranchData(reportLevel, branchId, startDate, endDate);
    setState(() {
      branchGeoMpr = _branchMprData;
    });
    return branchGeoMpr;
  }

  Future<List<MprResponse>> getRmMpr(String reportLevel, String rmCode, String startDate, String endDate) async {
    List<MprResponse> _rmMprData;
    _rmMprData = await apiService.getRmMprData(reportLevel, rmCode, startDate, endDate);
    setState(() {
      rmGeoMpr = _rmMprData;
    });
    return rmGeoMpr;
  }

  Future<List<MprResponse>> getSegmentMpr(String segmentId, String startDate, String endDate) async {
    List<MprResponse> _mprSegmentBankWideData;
    _mprSegmentBankWideData = await apiService.getSegmentMprData(segmentId, startDate, endDate);
    setState(() {
      mprSegment = _mprSegmentBankWideData;
    });
    return mprSegment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Profitability Report',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  areaType != null && branchType == null && rmType == null ? Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Container(
                        width: areaType != null ? areaType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(areaType,
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
                        width: branchType != null ? branchType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(branchType,
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
                        width: rmType != null ? rmType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(rmType,
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
                        width: segmentType != null ? segmentType.length > 12 ? 100.0 : null : null,
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(segmentType,
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
                      width: regionType != null ? regionType.length > 12 ? 100.0 : null : null,
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(regionType == null ? 'Bank' : regionType,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-Regular',
                          ),softWrap: false,
                          overflow: TextOverflow.ellipsis),),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  segmentType == null ?
                  PopupMenuButton<String>(
                    itemBuilder: regionType == null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType != null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null && areaType != null &&
                        branchType != null &&
                        rmType == null
                        ? (context) {
                      return rmByBranch.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : (context) {
                          return rmByBranch.map((item) {
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
                              Text(
                                  regionType == null && areaType == null && branchType == null
                                      ? 'View by Region'
                                      : regionType != null &&
                                      areaType == null &&
                                      branchType == null
                                      ? 'View by Area'
                                      : regionType != null &&
                                      areaType != null &&
                                      branchType == null
                                      ? 'View by Branch'
                                      : 'View By Rm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.white, size: 23),
                            ],
                          ),
                          // ),
                        ),
                        onSelected: (item) {
                          setState(() {
                            regionType == null && areaType == null && branchType == null ? regionType = item : regionType != null && areaType == null && branchType == null ? areaType = item
                                : regionType != null && areaType != null && branchType == null ? branchType = item : rmType = item;

                            regionItem = regionType;
                            areaItem = areaType;
                            branchItem = branchType;
                            rmItem = rmType;

                          });
                        },
                      )
                      : PopupMenuButton<String>(
                    itemBuilder: regionType == null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                      }
                        : regionType != null &&
                        areaType == null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null &&
                        areaType != null &&
                        branchType == null &&
                        rmType == null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null && areaType != null &&
                        branchType != null &&
                        rmType == null
                        ? (context) {
                      return rmByBranch.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : (context) {
                      return rmByBranch.map((item) {
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
                          Text(
                              regionType == null && areaType == null && branchType == null
                                  ? 'View by Region'
                                  : regionType != null &&
                                  areaType == null &&
                                  branchType == null
                                  ? 'View by Area'
                                  : regionType != null &&
                                  areaType != null &&
                                  branchType == null
                                  ? 'View by Branch'
                                  : 'View By Rm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 23),
                        ],
                      ),
                      // ),
                    ),
                    onSelected: (item) {
                      setState(() {
                        regionType == null && areaType == null && branchType == null ? regionType = item : regionType != null && areaType == null && branchType == null ? areaType = item
                            : regionType != null && areaType != null && branchType == null ? branchType = item : rmType = item;

                        regionItem = regionType;
                        areaItem = areaType;
                        branchItem = branchType;
                        rmItem = rmType;

                      });
                    },
                  ),
                  SizedBox(width: 7),
                  PopupMenuButton<String>(
                    itemBuilder: segmentType == null
                        ? (context) {
                      return segmentList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : regionType != null
                        ? (context) {
                      return regionList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : areaType != null
                        ? (context) {
                      return areaByRegion.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : branchType != null
                        ? (context) {
                      return branchByArea.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    }
                        : rmType != null
                        ? (context) {
                      return rmByBranch.map((item) {
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 23),
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
                  measure: 'MPR',
                  subTitle: segmentType == null ?
                  regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : null
                      : regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : segmentType,

                  subText: segmentType == null ?
                  regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Bank'
                      : regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Segment',

                  selectedDate: selectedDate == null
                      ? bankDate
                      : DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(selectedDate)),
                  selectDate: () {
                    setState(() {
                      _selectDate(context);
                    });
                  }),

                // MprTableContainer(mprData: mprBankWide)

              segmentType == null ?
                  regionType == null && areaType == null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: mprBankWide)
                      : regionType != null && areaType == null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: regionGeoMpr)
                      : regionType != null && areaType != null && branchType == null && rmType == null ?
                  MprTableContainer(mprData: areaGeoMpr)
                      : regionType != null && areaType != null && branchType != null && rmType == null ?
                  MprTableContainer(mprData: branchGeoMpr)
                      : MprTableContainer(mprData: rmGeoMpr)
                      :
                  MprTableContainer(mprData: mprSegment)
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConcessionBottomNavigationBar(),
    );
  }
}
*/

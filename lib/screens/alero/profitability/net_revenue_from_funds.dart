import 'package:alero/models/performance/NrffReponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/performance/pm_title_container.dart';
import 'package:alero/screens/alero/profitability/pl_title_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';
import 'nfrr_table_container.dart';
import 'package:intl/intl.dart';

class NetRevenueFromFunds extends StatefulWidget {
  final String userId;

  NetRevenueFromFunds({@required this.userId});

  @override
  State<NetRevenueFromFunds> createState() => _NetRevenueFromFundsState();
}

class _NetRevenueFromFundsState extends State<NetRevenueFromFunds> {
  String segmentType;
  var apiService = AleroAPIService();
  List<NrffResponse> nrffGeoBankWide = [];
  List<NrffResponse> regionGeoNrff = [];
  List<NrffResponse> areaGeoNrff = [];
  List<NrffResponse> branchGeoNrff = [];
  List<NrffResponse> rmGeoNrff = [];
  List<NrffResponse> nfffSegmentBankWide = [];
  List<NrffResponse> segmentRegionNrff = [];
  List<NrffResponse> segmentAreaNrff = [];
  List<NrffResponse> segmentBranchNrff = [];
  List<NrffResponse> segmentRmNrff = [];

  String regionType;
  String areaType;
  String branchType;
  String rmType;

  String regionItem;
  String areaItem;
  String branchItem;
  String rmItem;

  String selectedDate;
  String selectedStartDate;
  DateTime pickedDate;
  DateTime twoDaysAgoSelectedDate;
  String formattedDateStr;
  DateTime currentSelectedDate;
  DateTime yesterdayDate;
  DateTime twoDaysAgo;
  String previousDate;
  String previousSelectedDate;
  String yesterdayDateString;
  String yesterDayDateString;

  DateTime startDate = DateTime.now();
  String bankDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (_datePicker != null && DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      setState(() {
        selectedDate = _datePicker.toIso8601String();
      });
    }}

  void getDate() {
    if (selectedDate != null) {
      pickedDate = DateTime.parse(selectedDate);
      selectedStartDate = DateFormat('yyyy-MMM-dd').format(pickedDate);

      twoDaysAgoSelectedDate = pickedDate.subtract(Duration(days: 2));
      previousSelectedDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgoSelectedDate);

    } else {
      yesterdayDate = startDate.subtract(Duration(days: 1));
      twoDaysAgo = startDate.subtract(Duration(days: 2));
      previousDate = DateFormat('yyyy-MMM-dd').format(twoDaysAgo);
      yesterdayDateString = DateFormat('yyyy-MM-dd').format(yesterdayDate);
      yesterDayDateString = DateFormat('yyyy-MMM-dd').format(yesterdayDate);
    }}

  List<String> regionList;
  Future<List<String>> getRegionList() async {
    List<String> _listOfRegions = await apiService.getRegionList();
    setState(() {
      regionList = _listOfRegions;
    });
    return regionList;
  }

  List<String> segmentList = [
    'SME',
    'RETAIL',
    'COMMERCIAL',
    'PUBLIC SECTOR',
    'CORPORATE',
    'UNTAGGED',
  ];

  List<String> areaByRegion;
  getAreaListByRegionId(String regionId) async {
    List<String> _areaList = await apiService.getAreaList(regionId);
    setState(() {
      areaByRegion = _areaList;
    });
    return areaByRegion;
  }

  List<String> branchByArea;
  getBranchListByAreaCode(String areaCode) async {
    List<String> _branchList = await apiService.getBranchList(areaCode);
    setState(() {
      branchByArea = _branchList;
    });
    return branchByArea;
  }

  List<String> rmByBranch;
  getRmListByAreaCode(String branchCode) async {
    List<String> _rmList = await apiService.getRmList(branchCode);
    setState(() {
      rmByBranch = _rmList;
    });
    return rmByBranch;
  }

  @override
  void initState() {
    super.initState();

    getNrffGeoBankWide('2023-05-06');
    getRegionNrff('2023-05-06', 'NO001');
    getAreaNrff('ABU002', '2023-05-06');
    getBranchNrff('251', '2023-05-06');
    getRmNrff('251', 'ICS102276', '2023-05-06'); // Or NDA11544, 5429618, , 5430369, NDA11206

    getSegmentBankWideNrff('2023-07-05', 'SME');
    getSegmentRegionNrff('SME', 'SO001', '2023-07-05');
    getSegmentAreaNrff('SO001', 'SME', 'IMO001', '2023-05-06');
    getSegmentBranchNrff('IMO001', 'SME', '2023-05-06');
    getSegmentRmNrff('010', 'RETAIL', '5428883', '2023-07-27'); // Use RETAIL

    // getDate();

    /*getNrffGeoBankWide(selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getRegionNrff(selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)), 'NO001');
    getAreaNrff('ABU002', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getBranchNrff('251', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getRmNrff('251', 'NDA11544', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate))); // Or 5429618, ICS102276, 5430369, NDA11206

    getSegmentBankWideNrff(selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)), 'SME');
    getSegmentRegionNrff('SME', 'SO001', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getSegmentAreaNrff('SO001', 'SME', 'IMO001', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getSegmentBranchNrff('IMO001', 'SME', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate)));
    getSegmentRmNrff('010', 'RETAIL', '5428883', selectedDate == null ? yesterDayDateString : DateFormat('yyyy-MMM-dd').format(DateTime.parse(selectedDate))); // Use RETAIL
 */

    getRegionList();
    segmentType == null ? getAreaListByRegionId('NO001') : getAreaListByRegionId('SO001');
    segmentType == null ? getBranchListByAreaCode('ABU002') : getBranchListByAreaCode('IMO001');
    segmentType == null ? getRmListByAreaCode('251') : getRmListByAreaCode('010');

  }

  Future<List<NrffResponse>> getNrffGeoBankWide(String date) async {
      List<NrffResponse> _nfffBankWide;
      _nfffBankWide = await apiService.getNrffGeoBankWideData(date);
      setState(() {
        nrffGeoBankWide = _nfffBankWide;
      });
  }

  Future<dynamic> getRegionNrff(String date, String regionId) async {
      List<NrffResponse> _regionNrffData;
      _regionNrffData = await apiService.getNrffGeoRegionData(date, regionId);
      setState(() {
        regionGeoNrff = _regionNrffData;
      });
  }

  Future<dynamic> getAreaNrff(String areaId, String date) async {
      List<NrffResponse> _areaNrffData;
      _areaNrffData = await apiService.getNrffGeoAreaData(areaId, date);
      setState(() {
        areaGeoNrff = _areaNrffData;
      });
  }

  Future<dynamic> getBranchNrff(String branchCode, String date) async {
      List<NrffResponse> _branchNrffData;
      _branchNrffData = await apiService.getNrffGeoBranchData(branchCode, date);
      setState(() {
        branchGeoNrff = _branchNrffData;
      });
  }

  Future<List<NrffResponse>> getRmNrff(
      String branchCode, String rmCode, String date) async {
      List<NrffResponse> _rmNrffData;
      _rmNrffData = await apiService.getRmNrffData(branchCode, rmCode, date);
      setState(() {
        rmGeoNrff = _rmNrffData;
      });
  }

  Future<List<NrffResponse>> getSegmentBankWideNrff(String date, String segment) async {
      List<NrffResponse> _nfffSegmentBankWideData;
      _nfffSegmentBankWideData =
          await apiService.getSegmentBankWideNrffData(date, segment);
      setState(() {
        nfffSegmentBankWide = _nfffSegmentBankWideData;
      });
  }

  Future<List<NrffResponse>> getSegmentRegionNrff(
      String segment, String regionCode, String date) async {
      List<NrffResponse> _segmentRegionNrffData;
      _segmentRegionNrffData = await apiService.getSegmentRegionNrffData(segment, regionCode, date);
      setState(() {
        segmentRegionNrff = _segmentRegionNrffData;
      });
  }

  Future<List<NrffResponse>> getSegmentAreaNrff(
      String regionId, String segment, String areaId, String date) async {
      List<NrffResponse> _segmentAreaNrffData;
      _segmentAreaNrffData = await apiService.getSegmentAreaNrffData(
          regionId, segment, areaId, date);
      setState(() {
        segmentAreaNrff = _segmentAreaNrffData;
      });
  }

  Future<List<NrffResponse>> getSegmentBranchNrff(
      String areaId, String segment, String date) async {
      List<NrffResponse> _segmentBranchNrffData;
      _segmentBranchNrffData =
          await apiService.getSegmentBranchNrffData(areaId, segment, date);
      setState(() {
        segmentBranchNrff = _segmentBranchNrffData;
      });
  }

  Future<List<NrffResponse>> getSegmentRmNrff(
      String branchCode, String segment, String rmCode, String date) async {
      List<NrffResponse> _segmentRmNrffData;
      _segmentRmNrffData = await apiService.getSegmentRmNrffData(
          branchCode, segment, rmCode, date);
      setState(() {
        segmentRmNrff = _segmentRmNrffData;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CallAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 15, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Net Revenue From Funds',
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
              SizedBox(height: 15),
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
              Container(
                width: 400,
                child: PlTitleContainer(
                    measure: 'Net Revenue From Funds',
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
              ),
              SizedBox(height: 10),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  elevation: 5,
                  child:
                    segmentType == null ?
                      regionType == null && areaType == null && branchType == null && rmType == null ?
                        NrffTableContainer(nrffData: nrffGeoBankWide)
                      : regionType != null && areaType == null && branchType == null && rmType == null ?
                         NrffTableContainer(nrffData: regionGeoNrff)
                      : regionType != null && areaType != null && branchType == null && rmType == null ?
                         NrffTableContainer(nrffData: areaGeoNrff)
                      : regionType != null && areaType != null && branchType != null && rmType == null ?
                         NrffTableContainer(nrffData: branchGeoNrff)
                      : NrffTableContainer(nrffData: rmGeoNrff)
                    :
                      regionType == null && areaType == null && branchType == null && rmType == null ?
                       NrffTableContainer(nrffData: nfffSegmentBankWide)
                      : regionType != null && areaType == null && branchType == null && rmType == null ?
                       NrffTableContainer(nrffData: segmentRegionNrff)
                      : regionType != null && areaType != null && branchType == null && rmType == null ?
                       NrffTableContainer(nrffData: segmentAreaNrff)
                      : regionType != null && areaType != null && branchType != null && rmType == null ?
                       NrffTableContainer(nrffData: segmentBranchNrff)
                      : NrffTableContainer(nrffData: segmentRmNrff)
              ),
            ],
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
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/customer/profile_dashboard.svg',
                      color: Colors.black26,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/customer/profile_logout.svg',
                    ),
                    onTap: () {
                      logoutUser(context);
                    },
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
}

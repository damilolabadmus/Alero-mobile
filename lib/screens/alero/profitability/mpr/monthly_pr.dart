

import 'package:alero/models/performance/MprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_title_container.dart';
import 'package:alero/screens/alero/components/simple_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../dummy/dummy.dart';
import 'mpr_table_container.dart';

class MonthlyProfitabilityReport extends StatefulWidget {

  @override
  State<MonthlyProfitabilityReport> createState() =>
      _MonthlyProfitabilityReportState();
}

class _MonthlyProfitabilityReportState extends State<MonthlyProfitabilityReport> {
  var apiService = AleroAPIService();
  List<MprResponse> mprSummary = [];
  String? dateSelected;
  Function? search;

  String? regionType;
  String? segmentType;
  String? areaType;
  String? branchType;
  String? rmType;

  String? regionItem;
  String? areaItem;
  String? branchItem;
  String? rmItem;

  List<MprResponse> mprBankWide = [];
  List<MprResponse> regionGeoMpr = [];
  List<MprResponse> areaGeoMpr = [];
  List<MprResponse> segmentBranchNrff = [];
  List<MprResponse> branchGeoMpr = [];
  List<MprResponse> rmGeoMpr = [];
  List<MprResponse> mprSegment = [];

  bool dataLoaded = false;
  bool isInitialLoading = true;
  bool isFetchingData = false;

  DateTime startDate = DateTime.now();
  String? selectedDate;
  String bankDate = DateFormat('MMM yyyy').format(DateTime.now());
  String initialDate = DateFormat('yyyy-MM').format(DateTime.now());

  void _selectDate(BuildContext context) async {
    OverlayEntry? overlayEntry;
    try {
      setState(() {
        isFetchingData = true;
      });
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: MediaQuery.of(context).size.width * 0.5 - 25.0,
          child: Material(
            color: Colors.transparent,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(overlayEntry);
      DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
      );
      if (_datePicker != null && DateFormat('yyyy-MM').format(_datePicker) != selectedDate) {
        String newSelectedDate = DateFormat('yyyy-MM').format(_datePicker);
        setState(() {
          selectedDate = newSelectedDate;

          List<String> dateParts = selectedDate!.split('-');
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          DateTime dateTime = DateTime(year, month);
          dateSelected = DateFormat('MMM yyyy').format(dateTime);
        });
        await fetchData();
      }
    } catch (e) {
    } finally {
      overlayEntry?.remove();
      setState(() {
        isFetchingData = false;
      });
    }
  }

  List<String>? regionList;
  Future<List<String>?> getRegionList() async {
    List<String>? _listOfRegions = await apiService.getRegionList();
    setState(() {
      regionList = _listOfRegions;
    });
    return regionList;
  }

  List<String>? areaList;
  Future<List<String>?> getAreaListByRegionId(String regionId) async {
    List<String>? _listOfAreas = await apiService.getAreaList(regionId);
    setState(() {
      areaList = _listOfAreas;
    });
    return areaList;
  }

  List<String>? branchList;
  Future<List<String>?> getBranchListByAreaCode(String areaCode) async {
    List<String>? _branchArea = await apiService.getBranchList(areaCode);
    setState(() {
      branchList = _branchArea;
    });
    return branchList;
  }

  List<String>? rmList;
  Future<List<String>?> getRmListByAreaCode(String branchCode) async {
    List<String>? _rmBranch = await apiService.getRmList(branchCode);
    setState(() {
      rmList = _rmBranch;
    });
    return rmList;
  }

  @override
  void initState() {
    super.initState();
    getRegionList();
    getAreaListByRegionId('SO001');
    getBranchListByAreaCode('IMO001');
    getRmListByAreaCode('604');

    selectedDate = DateFormat('yyyy-MM').format(DateTime.now());

    if (!dataLoaded) {
      fetchData();
    }
    startTimeout();
  }

  void startTimeout() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isInitialLoading) {
        setState(() {
          isInitialLoading = false;
        });
      }
    });
  }

  Future<void> fetchData() async {
    try {
      List<Future<List<MprResponse>>> futures = [
        apiService.getBankWideMprData(selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
        apiService.getMprGeoRegionData('SOUTH', 'SO001', '2023-01', selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
        apiService.getMprGeoAreaData('IMO', 'IMO001', '2023-01', selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
        apiService.getMprGeoBranchData('ORLU', '604', '2023-01', selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
        apiService.getRmMprData('Agwabumma Ohaegbulam', 'ICS101101', '2023-01', selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
        apiService.getSegmentMprData('RETAIL', '2023-01', selectedDate ?? initialDate).timeout(Duration(minutes: 10)),
      ];

      List<List<MprResponse>> results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          mprBankWide = results[0];
          regionGeoMpr = results[1];
          areaGeoMpr = results[2];
          branchGeoMpr = results[3];
          rmGeoMpr = results[4];
          mprSegment = results[5];

          dataLoaded = true;
          isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CallAppBar(),
        body: isInitialLoading ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<String>(
                        itemBuilder: regionType == null && areaType == null && branchType == null && rmType == null
                            ? (context) {
                          return regionList == null ? regionList!.map((item) {
                          // return regionList == null ? regionLis.map((item) {
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
                          return areaList == null ? [] : areaList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        } : regionType != null && areaType != null && branchType == null && rmType == null ?
                            (context) {
                          return branchList == null ? [] : branchList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        }
                        : regionType != null && areaType != null && branchType != null && rmType == null ? (context) {
                          return rmList == null ? [] : rmList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        } : (context) {
                          return rmList == null ? [] : rmList!.map((item) {
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
                        if (segmentType == null) {
                            setState(() {
                              regionType == null && areaType == null && branchType == null ? regionType = item
                                  : regionType != null && areaType == null && branchType == null ? areaType = item
                                  : regionType != null && areaType != null && branchType == null ? branchType = item
                                  : rmType = item;

                              regionItem = regionType;
                              areaItem = areaType;
                              branchItem = branchType;
                              rmItem = rmType;
                            });
                          }
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
                          // return regionLis.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        }
                            : areaType != null ?
                            (context) {
                          return areaList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        } : branchType != null ?
                            (context) {
                          return branchList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        } : rmType != null ?
                            (context) {
                          return rmList!.map((item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        }
                            : (context) {
                          return segmentList.map((item) {
                          // return segmentLis.map((item) {
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
                                  : regionType != null ? 'Other Regions'
                                  : areaType != null ? 'Other Areas'
                                  : branchType != null ? 'Other Branches'
                                  : rmType != null ? 'Other Rms'
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
                      measure: 'MPR',
                      subTitle: segmentType == null ?
                      regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : null
                          : regionType != null && areaType == null && branchType == null && rmType == null ? regionType : regionType != null && areaType != null && branchType == null && rmType == null ? areaType : regionType != null && areaType != null && branchType != null && rmType == null ? branchType : regionType != null && areaType != null && branchType != null && rmType != null ? rmType : segmentType,

                      subText: segmentType == null ?
                      regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Bank'
                          : regionType != null && areaType == null && branchType == null && rmType == null ? 'Region' : regionType != null && areaType != null && branchType == null && rmType == null ? 'Area' : regionType != null && areaType != null && branchType != null && rmType == null ? 'Branch' : regionType != null && areaType != null && branchType != null && rmType != null ? 'Rm' : 'Segment',

                      selectedDate: dateSelected ?? bankDate,
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
     bottomNavigationBar: SimpleBottomNavItem()),
    );
  }
}


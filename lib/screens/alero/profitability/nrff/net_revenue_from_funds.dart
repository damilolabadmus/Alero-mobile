import 'package:alero/models/performance/NrffReponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/call_app_bar.dart';
import 'package:alero/screens/alero/performance/performance_title_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';
import 'nfrr_table_container.dart';
import 'package:intl/intl.dart';

class NetRevenueFromFunds extends StatefulWidget {
  final String? userId;

  NetRevenueFromFunds({required this.userId});

  @override
  State<NetRevenueFromFunds> createState() => _NetRevenueFromFundsState();
}

class _NetRevenueFromFundsState extends State<NetRevenueFromFunds> {
  var apiService = AleroAPIService();
  String? segmentType;
  bool dataLoaded = false;
  bool isInitialLoading = true;
  bool isFetchingData = false;

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

  String? regionType;
  String? areaType;
  String? branchType;
  String? rmType;

  String? regionItem;
  String? areaItem;
  String? branchItem;
  String? rmItem;

  String? selectedDate;
  String? dateSelected;
  DateTime startDate = DateTime.now();
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

/*
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (_datePicker != null && DateFormat('yyyy-MM').format(_datePicker) != selectedDate) {
      String newSelectedDate = DateFormat('yyyy-MM').format(_datePicker);
      setState(() {
        selectedDate = newSelectedDate;
        print('THE NRFF DATE = $selectedDate');

        List<String> dateParts = selectedDate.split('-');
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        DateTime dateTime = DateTime(year, month);
        dateSelected = DateFormat('MMM yyyy').format(dateTime);

        fetchData();
      });
    }
  }
*/

  List<String>? regionList;
  Future<List<String>?> getRegionList() async {
    List<String>? _listOfRegions = await apiService.getRegionList();
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

  List<String> segmentLis = [
    'SME',
    'COMMERCIAL',
    'PUBLIC SECTOR',
    'CORPORATE',
    'UNTAGGED',
  ];

  List<String>? areaByRegion;
  getAreaListByRegionId(String regionId) async {
    List<String>? _areaList = await apiService.getAreaList(regionId);
    setState(() {
      areaByRegion = _areaList;
    });
    return areaByRegion;
  }

  List<String>? branchByArea;
  getBranchListByAreaCode(String areaCode) async {
    List<String>? _branchList = await apiService.getBranchList(areaCode);
    setState(() {
      branchByArea = _branchList;
    });
    return branchByArea;
  }

  List<String>? rmByBranch;
  getRmListByAreaCode(String branchCode) async {
    List<String>? _rmList = await apiService.getRmList(branchCode);
    setState(() {
      rmByBranch = _rmList;
    });
    return rmByBranch;
  }

  List<String> regionLis = ['HEAD OFFICE', 'SOUTH', 'NORTH 1', 'NORTH 2', 'LAGOS AND SOUTHWEST', 'CORPORATE BANKING GROUP', 'TREASURY'];

  @override
  void initState() {
    super.initState();
    getRegionList();
    getAreaListByRegionId('NO001');
    getBranchListByAreaCode('ABU002');
    getRmListByAreaCode('251');

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
      List<Future<List<NrffResponse>>> futures = [
        apiService.getNrffGeoBankWideData(selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getNrffGeoRegionData(selectedDate ?? initialDate, 'NO001').timeout(Duration(minutes: 3)),
        apiService.getNrffGeoAreaData('ABU002', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getNrffGeoBranchData('251', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getRmNrffData('251', 'ICS102276', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getSegmentBankWideNrffData(selectedDate ?? initialDate, 'SME').timeout(Duration(minutes: 3)),
        apiService.getSegmentRegionNrffData('SME', 'SO001', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getSegmentAreaNrffData('SO001', 'SME', 'IMO001', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getSegmentBranchNrffData('IMO001', 'SME', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
        apiService.getSegmentRmNrffData('010', 'RETAIL', '5428883', selectedDate ?? initialDate).timeout(Duration(minutes: 3)),
      ];

      List<List<NrffResponse>> results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          nrffGeoBankWide = results[0];
          regionGeoNrff = results[1];
          areaGeoNrff = results[2];
          branchGeoNrff = results[3];
          rmGeoNrff = results[4];
          nfffSegmentBankWide = results[5];
          segmentRegionNrff = results[6];
          segmentAreaNrff = results[7];
          segmentBranchNrff = results[8];
          segmentRmNrff = results[9];

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
      child: isInitialLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator for the initial load
          : Scaffold(
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
                          areaType != null && branchType == null && rmType == null
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Container(
                                    width: areaType != null
                                        ? areaType!.length > 7
                                            ? 110.0
                                            : null
                                        : null,
                                    padding: EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                    child: Text(areaType!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins-Regular',
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis),
                                  ))
                              : areaType != null && branchType != null && rmType == null
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Container(
                                        width: branchType != null
                                            ? branchType!.length > 7
                                                ? 110.0
                                                : null
                                            : null,
                                        padding: EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                        child: Text(branchType!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                  : areaType != null && branchType != null && rmType != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(left: 3.0),
                                          child: Container(
                                            width: rmType != null
                                                ? rmType!.length > 7
                                                    ? 110.0
                                                    : null
                                                : null,
                                            padding: EdgeInsets.all(7.0),
                                            decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                            child: Text(rmType!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis),
                                          ))
                                      : segmentType != null && rmType != null && branchType != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(left: 3.0),
                                              child: Container(
                                                width: segmentType != null
                                                    ? segmentType!.length > 7
                                                        ? 110.0
                                                        : null
                                                    : null,
                                                padding: EdgeInsets.all(7.0),
                                                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                                child: Text(segmentType!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Poppins-Regular',
                                                    ),
                                                    softWrap: false,
                                                    overflow: TextOverflow.ellipsis),
                                              ))
                                          : Padding(
                                              padding: const EdgeInsets.only(left: 3.0),
                                              child: Container(
                                                width: regionType != null
                                                    ? regionType!.length > 7
                                                        ? 110.0
                                                        : null
                                                    : null,
                                                padding: EdgeInsets.all(7.0),
                                                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                                child: Text(regionType == null ? 'Bank' : regionType!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Poppins-Regular',
                                                    ),
                                                    softWrap: false,
                                                    overflow: TextOverflow.ellipsis),
                                              ),
                                            )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            itemBuilder: regionType == null && areaType == null && branchType == null && rmType == null
                                ? (context) {
                                    return regionList == null
                                        ? regionLis.map((item) {
                                            return PopupMenuItem(
                                              value: item,
                                              child: Text(item),
                                            );
                                          }).toList()
                                        : regionList!.map((item) {
                                            return PopupMenuItem(
                                              value: item,
                                              child: Text(item),
                                            );
                                          }).toList();
                                  }
                                : regionType != null && areaType == null && branchType == null && rmType == null
                                    ? (context) {
                                        return areaByRegion == null
                                            ? []
                                            : areaByRegion!.map((item) {
                                                return PopupMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList();
                                      }
                                    : regionType != null && areaType != null && branchType == null && rmType == null
                                        ? (context) {
                                            return branchByArea == null
                                                ? []
                                                : branchByArea!.map((item) {
                                                    return PopupMenuItem(
                                                      value: item,
                                                      child: Text(item),
                                                    );
                                                  }).toList();
                                          }
                                        : regionType != null && areaType != null && branchType != null && rmType == null
                                            ? (context) {
                                                return rmByBranch == null
                                                    ? []
                                                    : rmByBranch!.map((item) {
                                                        return PopupMenuItem(
                                                          value: item,
                                                          child: Text(item),
                                                        );
                                                      }).toList();
                                              }
                                            : (context) {
                                                return rmByBranch == null
                                                    ? []
                                                    : rmByBranch!.map((item) {
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
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      regionType == null && areaType == null && branchType == null
                                          ? 'View by Region'
                                          : regionType != null && areaType == null && branchType == null
                                              ? 'View by Area'
                                              : regionType != null && areaType != null && branchType == null
                                                  ? 'View by Branch'
                                                  : 'View By Rm',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 23),
                                ],
                              ),
                            ),
                            onSelected: (item) {
                              if (segmentType == null) {
                                setState(() {
                                  regionType == null && areaType == null && branchType == null
                                      ? regionType = item
                                      : regionType != null && areaType == null && branchType == null
                                          ? areaType = item
                                          : regionType != null && areaType != null && branchType == null
                                              ? branchType = item
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
                                        return regionLis.map((item) {
                                          return PopupMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList();
                                      }
                                    : areaType != null
                                        ? (context) {
                                            return areaByRegion!.map((item) {
                                              return PopupMenuItem(
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList();
                                          }
                                        : branchType != null
                                            ? (context) {
                                                return branchByArea!.map((item) {
                                                  return PopupMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  );
                                                }).toList();
                                              }
                                            : rmType != null
                                                ? (context) {
                                                    return rmByBranch!.map((item) {
                                                      return PopupMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList();
                                                  }
                                                : (context) {
                                                    return segmentLis.map((item) {
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
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade200, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      segmentType == null
                                          ? 'View by Segment'
                                          : segmentType != null && regionType != null && areaType == null && branchType == null && rmType == null
                                              ? 'Other Regions'
                                              : segmentType != null && regionType != null && areaType != null && branchType == null && rmType == null
                                                  ? 'Other Areas'
                                                  : segmentType != null &&
                                                          regionType != null &&
                                                          areaType != null &&
                                                          branchType != null &&
                                                          rmType == null
                                                      ? 'Other Branches'
                                                      : segmentType != null &&
                                                              regionType != null &&
                                                              areaType != null &&
                                                              branchType != null &&
                                                              rmType != null
                                                          ? 'Other Rms'
                                                          : 'Other Segments',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 23),
                                ],
                              ),
                              // ),
                            ),
                            onSelected: (item) {
                              setState(() {
                                segmentType == null
                                    ? segmentType = item
                                    : regionType != null
                                        ? regionType = item
                                        : areaType != null
                                            ? areaType = item
                                            : branchType != null
                                                ? branchType = item
                                                : rmType != null
                                                    ? rmType = item
                                                    : segmentType != null
                                                        ? segmentType = item
                                                        : segmentType = item;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      PmTitleContainer(
                          measure: 'Net Revenue From Funds',
                          subTitle: segmentType == null
                              ? regionType != null && areaType == null && branchType == null && rmType == null
                                  ? regionType
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? areaType
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? branchType
                                          : regionType != null && areaType != null && branchType != null && rmType != null
                                              ? rmType
                                              : null
                              : regionType != null && areaType == null && branchType == null && rmType == null
                                  ? regionType
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? areaType
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? branchType
                                          : regionType != null && areaType != null && branchType != null && rmType != null
                                              ? rmType
                                              : segmentType,
                          subText: segmentType == null
                              ? regionType != null && areaType == null && branchType == null && rmType == null
                                  ? 'Region'
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? 'Area'
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? 'Branch'
                                          : regionType != null && areaType != null && branchType != null && rmType != null
                                              ? 'Rm'
                                              : 'Bank'
                              : regionType != null && areaType == null && branchType == null && rmType == null
                                  ? 'Region'
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? 'Area'
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? 'Branch'
                                          : regionType != null && areaType != null && branchType != null && rmType != null
                                              ? 'Rm'
                                              : 'Segment',
                          selectedDate: dateSelected ?? bankDate,
                          selectDate: () {
                            setState(() {
                              _selectDate(context);
                            });
                          }),
                      SizedBox(height: 10),
                      segmentType == null
                          ? regionType == null && areaType == null && branchType == null && rmType == null
                              ? NrffTableContainer(nrffData: regionGeoNrff)
                              // NrffTableContainer(nrffData: nrffGeoBankWide)
                              : regionType != null && areaType == null && branchType == null && rmType == null
                                  ? NrffTableContainer(nrffData: regionGeoNrff)
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? NrffTableContainer(nrffData: areaGeoNrff)
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? NrffTableContainer(nrffData: branchGeoNrff)
                                          : NrffTableContainer(nrffData: rmGeoNrff)
                          : regionType == null && areaType == null && branchType == null && rmType == null
                              ? NrffTableContainer(nrffData: nfffSegmentBankWide)
                              : regionType != null && areaType == null && branchType == null && rmType == null
                                  ? NrffTableContainer(nrffData: segmentRegionNrff)
                                  : regionType != null && areaType != null && branchType == null && rmType == null
                                      ? NrffTableContainer(nrffData: segmentAreaNrff)
                                      : regionType != null && areaType != null && branchType != null && rmType == null
                                          ? NrffTableContainer(nrffData: segmentBranchNrff)
                                          : NrffTableContainer(nrffData: segmentRmNrff),
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
              ))),
    );
  }

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }
}

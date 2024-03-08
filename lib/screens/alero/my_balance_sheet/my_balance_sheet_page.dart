import 'package:alero/models/performance/MyBalanceSheetReponse.dart';
import 'package:alero/models/performance/MyBalanceSheetTypeResponse.dart';
import 'package:alero/screens/alero/my_balance_sheet/bloc/balance_sheet_bloc/balance_sheet_bloc.dart';
import 'package:alero/screens/alero/my_balance_sheet/bloc/log_out_bloc/log_out_bloc.dart';
import 'package:alero/screens/alero/performance/performance_title_container.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'balance_sheet_side_menu.dart';
import 'balance_sheet_table_container.dart';
import 'package:alero/style/theme.dart' as Style;
import 'bloc/balance_sheet_nav_bloc/balance_sheet_nav_bloc.dart';
import 'my_balance_sheet_rm_container.dart';
import 'my_balance_sheet_type_container.dart';

class MyBalanceSheetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BalanceSheetNavBloc>(create: (context) => BalanceSheetNavBloc()),
        BlocProvider<BalanceSheetBloc>(create: (context) => BalanceSheetBloc()),
        BlocProvider<LogoutBloc>(create: (context) => LogoutBloc()),
      ],
      child: _MyBalanceSheetPage(),
    );
  }
}

class _MyBalanceSheetPage extends StatefulWidget {

  @override
  State<_MyBalanceSheetPage> createState() => _MyBalanceSheetPageState();
}

class _MyBalanceSheetPageState extends State<_MyBalanceSheetPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation1;
  late Animation animation2;

  String bankDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<Null> _selectDate(BuildContext context, String? selectedDate) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (_datePicker != null && DateFormat('dd-MM-yyyy').format(_datePicker) != selectedDate) {
      final newSelectedDate = _datePicker.toIso8601String();
      updateSelectedDate(newSelectedDate);
      context.read<BalanceSheetBloc>().add(BalanceSheetBlocEvent.updateDate(newSelectedDate));
    }
  }

  void updateSelectedDate(String newSelectedDate) {
    context.read<BalanceSheetBloc>().add(BalanceSheetBlocEvent.updateDate(newSelectedDate));
  }

  List<String> regionLis = ['HEAD OFFICE', 'SOUTH', 'NORTH 1', 'NORTH 2', 'NORTH 3', 'LAGOS AND SOUTHWEST', 'CORPORATE BANKING GROUP', 'TREASURY'];

  List<String> segmentList = [
    'SME',
    'RETAIL',
    'COMMERCIAL',
    'PUBLIC SECTOR',
    'CORPORATE',
    'UNTAGGED',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BalanceSheetBloc>().add(BalanceSheetBlocEvent.loadData());
    context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.activeChanged(false));
    context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.isActiveChanged(true));

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceSheetNavBloc, BalanceSheetNavState>(builder: (context, state) {
      return Scaffold(
        extendBody: true,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.lightBlue.shade50,
          ),
          child: BalanceSheetSideMenu(
            isActive: state.isActive,
            active: state.active,
            tap: () {
              context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.activeChanged(true));
              context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.isActiveChanged(false));
            },
            ontap: () {
              context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.activeChanged(false));
              context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.isActiveChanged(true));
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<BalanceSheetBloc, BalanceSheetBlocState>(
          builder: (context, sheetState) {
            return SafeArea(
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
                                Builder(builder: (context) {
                                  return GestureDetector(
                                    onTap: () => Scaffold.of(context).openDrawer(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 13.0, left: 10),
                                      child: Icon(
                                        EvaIcons.menu2Outline,
                                        color: Colors.black38.withOpacity(0.5),
                                        size: 28,
                                      ),
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right_alt, size: 30, color: animation2.value),
                                      Text('slide', style: TextStyle(fontSize: 13, color: animation2.value, fontFamily: 'Poppins-Regular'))
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
                                  Navigator.of(context).pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'My Balance Sheet',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            state.isActive == true ? '(ACTUAL)' : '(AVERAGE)',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                          Builder(
                            builder: (BuildContext context) {
                              var types = [
                                sheetState.areaType,
                                sheetState.branchType,
                                sheetState.rmType,
                                sheetState.segmentType,
                                sheetState.regionType,
                                'Bank'
                              ];
                              String text = types.firstWhere((type) => type != null)!;

                              return Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Container(
                                  width: text.length > 12 ? 100.0 : null,
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(text,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              List<String>? determineItems() {
                                if (sheetState.regionType == null) {
                                  return sheetState.regionList ?? regionLis;
                                } else if (sheetState.areaType == null) {
                                  return sheetState.areaByRegion;
                                } else if (sheetState.branchType == null) {
                                  return sheetState.branchByArea;
                                } else {
                                  return sheetState.rmByBranch;
                                }
                              }

                              var items = determineItems();

                              return items?.map((item) {
                                    return PopupMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList() ??
                                  [];
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      sheetState.regionType == null
                                          ? 'View by Region'
                                          : sheetState.areaType == null
                                              ? 'View by Area'
                                              : sheetState.branchType == null
                                                  ? 'View by Branch'
                                                  : 'View By Rm',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 23),
                                ],
                              ),
                            ),
                            onSelected: (item) {
                              context.read<BalanceSheetBloc>().add(BalanceSheetBlocEvent.assignAndSaveItemTypes(item));
                            },
                          ),
                          SizedBox(width: 7),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              List<String>? items;
                              if (sheetState.segmentType == null) {
                                items = segmentList;
                              } else if (sheetState.regionType != null) {
                                items = sheetState.regionList;
                              } else if (sheetState.areaType != null) {
                                items = sheetState.areaByRegion;
                              } else if (sheetState.branchType != null) {
                                items = sheetState.branchByArea;
                              } else if (sheetState.rmType != null) {
                                items = sheetState.rmByBranch;
                              } else {
                                items = segmentList;
                              }

                              if (items == null) {
                                return [];
                              } else {
                                return items.map((item) {
                                  return PopupMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 35,
                              width: 152,
                              decoration: BoxDecoration(color: Colors.lightBlueAccent.shade200, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      sheetState.segmentType == null
                                          ? 'View by Segment'
                                          : sheetState.segmentType != null &&
                                                  sheetState.regionType != null &&
                                                  sheetState.areaType == null &&
                                                  sheetState.branchType == null &&
                                                  sheetState.rmType == null
                                              ? 'Other Regions'
                                              : sheetState.segmentType != null &&
                                                      sheetState.regionType != null &&
                                                      sheetState.areaType != null &&
                                                      sheetState.branchType == null &&
                                                      sheetState.rmType == null
                                                  ? 'Other Areas'
                                                  : sheetState.segmentType != null &&
                                                          sheetState.regionType != null &&
                                                          sheetState.areaType != null &&
                                                          sheetState.branchType != null &&
                                                          sheetState.rmType == null
                                                      ? 'Other Branches'
                                                      : sheetState.segmentType != null &&
                                                              sheetState.regionType != null &&
                                                              sheetState.areaType != null &&
                                                              sheetState.branchType != null &&
                                                              sheetState.rmType != null
                                                          ? 'Other Rms'
                                                          : 'Other Segments',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 23),
                                ],
                              ),
                              // ),
                            ),
                            onSelected: (item) {
                              context.read<BalanceSheetBloc>().add(BalanceSheetBlocEvent.updateTypes(item));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      PmTitleContainer(
                        measure: state.isActive == true ? 'Actual Balance Sheet' : 'AVG Balance Sheet',
                        subTitle: sheetState.rmType ??
                            sheetState.branchType ??
                            sheetState.areaType ??
                            sheetState.regionType ??
                            sheetState.segmentType ??
                            null,
                        subText: sheetState.segmentType == null
                            ? sheetState.regionType != null
                                ? sheetState.areaType != null
                                    ? sheetState.branchType != null
                                        ? sheetState.rmType != null
                                            ? 'Rm'
                                            : 'Branch'
                                        : 'Area'
                                    : 'Region'
                                : 'Bank'
                            : 'Segment',
                        selectedDate: sheetState.selectedDate == null
                            ? sheetState.yesterdayDateString
                            : DateFormat('yyyy-MM-dd').format(DateTime.parse(sheetState.selectedDate!)),
                        selectDate: () {
                          _selectDate(context, sheetState.selectedDate);
                        },
                        updateSelectedDate: updateSelectedDate,
                      ),
                      SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                        elevation: 5,
                        child: Builder(
                          builder: (BuildContext context) {
                            String? selectedStartDate = sheetState.selectedDate == null
                                ? sheetState.yesterDayDateString
                                : DateFormat('yyyy-MMM-dd').format(DateTime.parse(sheetState.selectedDate!));
                            String? previousDateTemp = sheetState.selectedDate == null
                                ? sheetState.previousDate
                                : sheetState.previousSelectedDate ??
                                    DateFormat('yyyy-MMM-dd').format(DateTime.parse(sheetState.selectedDate!).subtract(Duration(days: 1)));
                            String? monthEndDate =
                                sheetState.selectedDate == null ? sheetState.lastDayOfLastMonthString : sheetState.selectedLastDayOfLastMonthString;

                            Widget tableContainerBuilder(
                                List<MyBalanceSheetResponse>? balanceSheetDepData, List<MyBalanceSheetResponse>? balanceSheetLoanData) {
                              return MyBalanceSheetTableContainer(
                                balanceSheetDepData: balanceSheetDepData,
                                balanceSheetLoanData: balanceSheetLoanData,
                                selectedStartDate: selectedStartDate,
                                previousDate: previousDateTemp,
                                monthEndDate: monthEndDate,
                              );
                            }

                            Widget typeContainerBuilder(List<MyBalanceSheetTypeResponse>? balanceSheetData) {
                              return MyBalanceSheetTypeContainer(
                                balanceSheetData: balanceSheetData,
                                selectedStartDate: selectedStartDate,
                                previousDate: previousDateTemp,
                                monthEndDate: monthEndDate,
                              );
                            }

                            Widget rmContainerBuilder(dynamic balanceSheetData) {
                              return MyBalanceSheetRmContainer(
                                balanceSheetData: balanceSheetData,
                                selectedStartDate: selectedStartDate,
                                previousDate: previousDateTemp,
                                monthEndDate: monthEndDate,
                              );
                            }

                            if (sheetState.regionActual.isNotEmpty) {
                              if (state.active == false) {
                                if (sheetState.segmentType == null) {
                                  if (sheetState.regionType == null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return tableContainerBuilder(sheetState.bankDepActual, sheetState.bankLoanActual);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.regionActual);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.areaActual);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType != null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.branchActual);
                                  } else {
                                    return rmContainerBuilder(sheetState.rmData);
                                  }
                                } else {
                                  if (sheetState.regionType == null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.segmentBankWide);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.actualSegmentRegion);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.actualSegmentArea);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType != null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.actualSegmentBranch);
                                  } else {
                                    return rmContainerBuilder(sheetState.rmData);
                                  }
                                }
                              } else {
                                if (sheetState.segmentType == null) {
                                  if (sheetState.regionType == null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return tableContainerBuilder(sheetState.bankWideDepAvg, sheetState.bankWideLoanAvg);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.regionAvg);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.areaAvg);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType != null &&
                                      sheetState.rmType == null) {
                                    return typeContainerBuilder(sheetState.branchAvg);
                                  } else {
                                    return rmContainerBuilder(sheetState.rmData);
                                  }
                                } else {
                                  if (sheetState.regionType == null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.avgSegmentBankWide);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType == null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.avgSegmentRegion);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType == null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.avgSegmentArea);
                                  } else if (sheetState.regionType != null &&
                                      sheetState.areaType != null &&
                                      sheetState.branchType != null &&
                                      sheetState.rmType == null) {
                                    return rmContainerBuilder(sheetState.avgSegmentBranch);
                                  } else {
                                    return rmContainerBuilder(sheetState.rmData);
                                  }
                                }
                              }
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      PipelineDealsHeader(title: 'Category'),
                                      PipelineDealsHeader(title: selectedStartDate ?? '(₦\'m)'),
                                      PipelineDealsHeader(title: bankDate + '(₦\'m)'),
                                      PipelineDealsHeader(title: 'Variance (₦\'m)'),
                                      PipelineDealsHeader(
                                          title: sheetState.selectedDate != null
                                              ? sheetState.selectedLastDayOfLastMonthString ?? '(₦\'m)'
                                              : sheetState.lastDayOfLastMonthString ?? '(₦\'m)'),
                                      PipelineDealsHeader(title: 'MTD Variance (₦\'m)'),
                                      PipelineDealsHeader(title: 'Category Code (₦\'m)'),
                                      PipelineDealsHeader(title: 'Budget (₦\'m)'),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            child: BlocBuilder<BalanceSheetNavBloc, BalanceSheetNavState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.positionChanged(0));
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
                                  width: state.position == 0 ? 26 : 0,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent.shade400.withOpacity(0.8), borderRadius: BorderRadius.all(Radius.circular(15))),
                                )),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<BalanceSheetNavBloc>().add(BalanceSheetNavEvent.positionChanged(1));
                      },
                      child: Stack(
                        children: [
                          BlocListener<LogoutBloc, LogoutState>(
                            listener: (context, state) {
                              state.when(
                                initial: () {},
                                loading: () => OneContext().showProgressIndicator(),
                                success: () {
                                  OneContext().hideProgressIndicator();
                                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                },
                                failure: (message) {
                                  OneContext().hideProgressIndicator();
                                },
                              );
                            },
                            child: InkWell(
                              child: SvgPicture.asset(
                                'assets/customer/profile_logout.svg',
                              ),
                              onTap: () {
                                context.read<LogoutBloc>().add(LogoutEvent.logout());
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                child: Container(
                                  height: 3,
                                  width: state.position == 1 ? 25 : 0,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent.shade400.withOpacity(0.8), borderRadius: BorderRadius.all(Radius.circular(12))),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

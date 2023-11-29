import 'package:alero/models/customer/ComplaintCategoryFlow.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';

import 'indicator.dart';

class ComplaintsCartegoriesCard extends StatefulWidget {
  final String customerId, groupId;

  const ComplaintsCartegoriesCard({Key key, this.customerId, this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ComplaintsCartegoriesCardState();
}

class ComplaintsCartegoriesCardState extends State<ComplaintsCartegoriesCard> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<ComplaintCategory> cfData = [];
  int complaintsTotal = 0;
  int touchedIndex;
  List<Color> randomColors = [];
  List<Widget> indicators = [];
  bool hasdata;

  @override
  void initState() {
    super.initState();
    getComplaintCategories(widget.groupId);
  }

  Future getComplaintCategories(String groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      var flow = await apiService.getComplaintCategories(groupId);
      cfData = [];
      List<Widget> _indicators = [];

      if (flow.length == 0) {
        if (mounted) {
          setState(() {
            hasdata = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            hasdata = true;
          });
        }
        flow.forEach((complaint) {
          cfData.add(ComplaintCategory(
            customerGroupId: complaint["customerGroupId"],
            customerId: complaint["customerId"],
            accountNumber: complaint["accountNumber"],
            ytdComplaintCount: complaint["ytdComplaintCount"],
            mtdComplaintCount: complaint["mtdComplaintCount"],
            complaintCategory: complaint["complaintCategory"],
            complaintDescription: complaint["complaintDescription"],
            complaintCreatedDate: complaint["complaintCreatedDate"],
            complaintReslvedDate: complaint["complaintReslvedDate"],
            complaintStatus: complaint["complaintStatus"],
            complaintCategoryCount: complaint["complaintCategoryCount"],
          ));
        });
        generateColors(cfData.length);

        for (var i = 0; i < cfData.length; i++) {
          _indicators.add(Indicator(
            color: randomColors[i],
            text: cfData[i].complaintCategory,
            isSquare: false,
          ));
        }
        if (mounted) {
          setState(() {
            indicators = _indicators;
          });
        }
      }

      for (int i = 0; i < cfData.length; i++) {
        complaintsTotal = complaintsTotal + cfData[i].complaintCategoryCount;
      }
      return flow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting ||
            hasdata == false) {
          return Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/customer/trends/trends_empty_pie.svg',
            ),
          );
        }
        return Card(
            color: Colors.white,
            elevation: 1,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Categories",
                                    style: TextStyle(
                                      color: Style.Colors.trendsTextBlue,
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins-Regular',
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(complaintsTotal.toString(),
                                  style: TextStyle(
                                    color: Style.Colors.trendsTextBlack,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins-Bold',
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: SvgPicture.asset(
                          'assets/customer/trends/trends_arrow_down.svg',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                              if (mounted) {
                                setState(() {
                                  if (pieTouchResponse.touchInput
                                  is FlLongPressEnd ||
                                      pieTouchResponse.touchInput is FlPanEnd) {
                                    touchedIndex = -1;
                                  } else {
                                    touchedIndex =
                                        pieTouchResponse.touchedSectionIndex;
                                  }
                                });
                              }
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 35,
                            sections: showingTouchPointSections()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: indicators,
                    ),
                  ),
                ],
              ),
            ));
      },
      future: getComplaintCategories(widget.groupId),
    );
  }

  List<PieChartSectionData> showingTouchPointSections() {
    if (cfData.isNotEmpty)
      return List.generate(cfData.length, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 35 : 30;
        return PieChartSectionData(
            color: randomColors[i],
            value: cfData[i].complaintCategoryCount.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: randomColors[i],
            ));
      });
  }

  void generateColors(int length) {
    var list = [
      0xFF99C9D9,
      0xFF555555,
      0xFF008EC4,
      0xFFBBBBBB,
      0xFFFFDAA6,
      0xFFB3A369,
      0xFFF4B459,
      0xFF7AC369
    ];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}

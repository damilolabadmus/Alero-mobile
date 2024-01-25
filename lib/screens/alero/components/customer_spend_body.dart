import 'package:alero/models/customer/LifeStyleCount.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

import 'indicator.dart';

class CustomerSpendBody extends StatefulWidget {
  final String customerId, groupId, customerAccountNo;

  const CustomerSpendBody({Key key, @required this.customerId, @required this.groupId, this.customerAccountNo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerSpendBodyState();
  }
}

class _CustomerSpendBodyState extends State<CustomerSpendBody> {
  bool isSpendValue = false;
  var apiService = AleroAPIService();
  int touchedIndex;
  bool hadLoaded = false;
  bool hasdata;

  List<LifestyleCount> count = [];
  List<Color> randomColors = [];
  List<Widget> indicators = [];

  @override
  void initState() {
    super.initState();
    getLifeStyleCount(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text('Spend',
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/customer/dialog_close_button.svg',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Volume',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
              Switch(
                value: isSpendValue,
                onChanged: toggleSpendData,
                activeColor: Style.Colors.overviewActiveBg,
                activeTrackColor: Style.Colors.blackTextColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
              Text('Value',
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  )),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          loadCountData()
        ],
      ),
    );
  }

  void toggleSpendData(bool value) {
    if (mounted) {
      setState(() {
        isSpendValue = value;
        hadLoaded = false;
        getLifeStyleCount(widget.customerId);
      });
    }
  }

  Future getLifeStyleCount(String customerId) async {
    if (!hadLoaded) {
      List<dynamic> lifeStyle;
      if (!isSpendValue) {
        lifeStyle = await apiService.getLifeStyleCountData(customerId);
      } else {
        lifeStyle = await apiService.getLifeStyleValueData(customerId);
      }
      count = [];
      List<Widget> _indicators = [];
      if (lifeStyle.isEmpty) {
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
        lifeStyle.forEach((counter) {
          count.add(LifestyleCount(
              groupId: counter["groupId"],
              customerId: counter["customerId"],
              lifestyleType: counter["lifestyleType"],
              lifestyleCount: counter["lifestyleCount"],
              lifestyleValue: counter["lifestyleValue"]));
        });
      }
      generateColors(count.length);
      for (var i = 0; i < count.length; i++) {
        _indicators.add(Indicator(
          color: randomColors[i],
          text: count[i].lifestyleType,
          isSquare: false,
        ));
      }
      if (mounted) {
        setState(() {
          indicators = _indicators;
          hadLoaded = true;
        });
      }
      return lifeStyle;
    }
  }

  Widget loadCountData() {
    return FutureBuilder(
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null || snapshot.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        if (hasdata) {
          return Expanded(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback: (touchEvent, pieTouchResponse) {
                                  if (mounted) {
                                    setState(() {
                                      if (touchEvent is FlLongPressEnd || touchEvent is FlPanEndEvent) {
                                        touchedIndex = -1;
                                      } else {
                                        touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                                      }
                                    });
                                  }
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 50,
                                sections: showingCountSections()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 4.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          children: indicators,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                )),
          );
        } else {
          return EmptyListItem(
            message: 'No Customer Spend',
          );
        }
      },
      future: getLifeStyleCount(widget.customerId),
    );
  }

  List<PieChartSectionData> showingCountSections() {
    print(count.length);
    if (count.isNotEmpty)
      return List.generate(count.length, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        return PieChartSectionData(
            color: randomColors[i],
            value: (!isSpendValue) ? count[i].lifestyleCount : count[i].lifestyleValue,
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
    var list = [0xFF99C9D9, 0xFF555555, 0xFF008EC4, 0xFFBBBBBB, 0xFFFFDAA6, 0xFFB3A369, 0xFFF4B459, 0xFF7AC369];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}

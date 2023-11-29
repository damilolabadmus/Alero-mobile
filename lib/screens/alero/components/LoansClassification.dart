import 'package:alero/screens/alero/dashboard/loans_classification_value_chart.dart';
import 'package:alero/screens/alero/dashboard/loans_classification_volume_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class LoansClassificationChart extends StatefulWidget {

  @override
  State<LoansClassificationChart> createState() => _LoansClassificationChartState();
}

class _LoansClassificationChartState extends State<LoansClassificationChart> {
  bool isLoansClassification = false;

  void toggleLoansClassification(bool value) {
    if (mounted) {
      setState(() {
        isLoansClassification = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text('Loans Classification - 6 Months',
                style: kTrendTextStyle.copyWith(
                    fontSize: 16)),
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
                  value: isLoansClassification,
                  onChanged: toggleLoansClassification,
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
            isLoansClassification == true
                ? loansValueChart()
                : loansVolumeChart()
          ],
        ),
      ),
    );
  }

  Widget loansVolumeChart() {
    return LoansClassificationVolumeChart();
  }

  Widget loansValueChart() {
    return LoansClassificationValueChart();
  }
}

import 'package:alero/screens/alero/dashboard/loans_overdue_value_chart.dart';
import 'package:alero/screens/alero/dashboard/loans_overdue_volume_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class LoansOverdue extends StatefulWidget {

  @override
  State<LoansOverdue> createState() => _LoansOverdueState();
}

class _LoansOverdueState extends State<LoansOverdue> {
  bool isLoansOverdue = false;

  void toggleLoansOverdue(bool value) {
    if (mounted) {
      setState(() {
        isLoansOverdue = value;
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
            Text('Loans Overdue(Days)', style: kTrendTextStyle.copyWith(
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
                  value: isLoansOverdue,
                  onChanged: toggleLoansOverdue,
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
            isLoansOverdue == true
                ? loansValueChart()
                : loansVolumeChart()
          ],
        ),
      ),
    );
  }

  Widget loansVolumeChart() {
    return LoansOverdueVolumeChart();
  }

  Widget loansValueChart() {
    return LoansOverdueValueChart();
  }
}

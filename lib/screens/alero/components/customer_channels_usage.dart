import 'package:alero/screens/alero/dashboard/customer_channels_value_chart.dart';
import 'package:alero/screens/alero/dashboard/customer_channels_volume_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;

class CustomerChannelsUsage extends StatefulWidget {
  @override
  State<CustomerChannelsUsage> createState() => _CustomerChannelsUsageState();
}

class _CustomerChannelsUsageState extends State<CustomerChannelsUsage> {
  bool isChannelsUsage = false;

  void toggleChannelsUsage(bool value) {
    if (mounted) {
      setState(() {
        isChannelsUsage = value;
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
            Text('Customer Channels Usage - 6 Months', style: kTrendTextStyle.copyWith(
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
                  value: isChannelsUsage,
                  onChanged: toggleChannelsUsage,
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
            isChannelsUsage == true ? channelsValueChart() : channelsVolumeChart()
          ],
        ),
      ),
    );
  }

  Widget channelsVolumeChart() {
    return CustomerChannelsUsageVolumeChart();
  }

  Widget channelsValueChart() {
    return CustomerChannelsUsageValueChart();
  }
}

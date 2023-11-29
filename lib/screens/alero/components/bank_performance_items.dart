import 'package:alero/models/customer/BankPerformanceData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class BankPerformanceItems extends StatefulWidget {

  final String groupId;

  const BankPerformanceItems({Key key, this.groupId})
      : super(key: key);

  @override
  _BankPerformanceItemsState createState() => _BankPerformanceItemsState();
}

class _BankPerformanceItemsState extends State<BankPerformanceItems> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankPerformanceData> bData = [];
  double totalCustomers = 0.0;
  double ytdCustomers = 0.0;
  double totalAccounts = 0.0;
  double ytdAccounts = 0.0;


  @override
  void initState() {
    super.initState();
    getBankPerformanceData();
  }

  Future getBankPerformanceData() async {
    return this._asyncMemoizer.runOnce(() async {
      var bankPerformance = await apiService.getBankingPerformance();

      if (bankPerformance.length == 0) {
        bData.add(BankPerformanceData(
            customerCount: 0.0,
            ytdCustomerCount: 0.0,
            accountCount: 0.0,
            ytdAccountCount: 0.0));
      } else {
        bankPerformance.forEach((performance) {
          bData.add(BankPerformanceData(
              customerCount: performance["customerCount"],
              ytdCustomerCount: performance["ytdCustomerCount"],
              accountCount: performance["accountCount"],
              ytdAccountCount: performance["ytdAccountCount"]));
        });
      }

      setState(() {
        for (int i = 0; i < bData.length; i++) {
          totalCustomers = totalCustomers + bData[i].customerCount;
          ytdCustomers = ytdCustomers + bData[i].ytdCustomerCount;
          totalAccounts = totalAccounts + bData[i].accountCount;
          ytdAccounts = ytdAccounts + bData[i].ytdAccountCount;
        }
      });
      return bankPerformance;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 90,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              totalCustomers.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              style: kBankItemValue,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Total Customers',
                              style: kBankItemTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ytdCustomers.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              style: kBankItemValue,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'YTD Customers',
                              style: kBankItemTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              totalAccounts.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              style: kBankItemValue,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Total Accounts',
                              style: kBankItemTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10, 0.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ytdAccounts.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                              style: kBankItemValue,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'YTD Accounts',
                              style: kBankItemTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

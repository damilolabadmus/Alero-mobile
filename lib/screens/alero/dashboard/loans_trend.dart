

import 'package:alero/models/customer/BankLoanData.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/loans_trend_chart.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class LoansTrend extends StatefulWidget {

  @override
  _LoansTrendState createState() => _LoansTrendState();
}

class _LoansTrendState extends State<LoansTrend> {

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List<BankLoanData> ltData = [];
  int divisor = 100000000000;
  double actualLoans = 0.0;
  double actualLoansChange = 0.0;
  double averageLoans = 0.0;
  double averageLoansChange = 0.0;

  @override
  void initState() {
    getBankLoansData();
    super.initState();
  }

  Future getBankLoansData() async {
    return this._asyncMemoizer.runOnce(() async {
      var loans = await apiService.getBankLoans();
      ltData = [];
      if (loans.length == 0) {
        ltData.add(BankLoanData(
          actualLoans: 0.0,
          actualLoansChange: 0.0,
          averageLoans: 0.0,
          averageLoansChange: 0.0,
        ));
      } else {
        loans.forEach((loan) {
          ltData.add(BankLoanData(
            actualLoans: loan["actualLoans"],
            actualLoansChange: loan["actualLoansChange"],
            averageLoans: loan["averageLoans"],
            averageLoansChange: loan["averageLoansChange"],
          ));
        });
      }

      setState(() {
        for (int i = 0; i < ltData.length; i++) {
          actualLoans = actualLoans + ltData[i].actualLoans!;
          actualLoansChange = actualLoansChange + ltData[i].actualLoansChange!;
          averageLoans = averageLoans + ltData[i].averageLoans!;
          averageLoansChange = averageLoansChange + ltData[i].averageLoansChange!;
        }
        // return loans;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Loans Trend (N\'M) - YOY/12 Months',
                style: kTrendTextStyle.copyWith(
                    fontSize: 16),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoansItem(loansLine1: 'Actual', loansLine2: 'Loans',
                      value: "${double. parse((actualLoans/divisor).toStringAsFixed(2))}b"),
                  LoansItem(loansLine1: ' ', loansLine2: 'DoD',
                      value: actualLoansChange.toString()),
                  LoansItem(loansLine1: 'Average', loansLine2: 'Loans',
                      value: "${double. parse((averageLoans/divisor).toStringAsFixed(2))}b"),
                  LoansItem(loansLine1: ' ', loansLine2: 'DoD',
                      value: averageLoansChange.toString()),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                child: LoansTrendChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoansItem extends StatelessWidget {
  LoansItem({this.loansLine1, this.loansLine2, this.value});

  final String? loansLine1;
  final String? loansLine2;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(loansLine1!,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontFamily: 'Poppins-Regular',
            ),),
          Text(loansLine2!,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontFamily: 'Poppins-Regular',
            ),),
          SizedBox(height: 5.0),
          Text(value!, style: TextStyle(
              color: Colors.blueGrey.shade700
          ),),
        ]
    );
  }
}

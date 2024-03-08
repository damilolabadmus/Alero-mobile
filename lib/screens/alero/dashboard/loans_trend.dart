import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/dashboard/loans_trend_chart.dart';
import 'package:alero/screens/alero/dashboard/repository/loans_trend_repository.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/loans_trend_bloc/loans_trend_bloc.dart';

class LoansTrend extends StatefulWidget {
  @override
  _LoansTrendState createState() => _LoansTrendState();
}

class _LoansTrendState extends State<LoansTrend> {
  final int divisor = 100000000000;
  late final LoansTrendBloc bloc;

  @override
  void initState() {
    bloc = LoansTrendBloc(repository: LoansTrendRepository(apiService: AleroAPIService()))..getLoansTrendData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoansTrendBloc, LoansTrendState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => CircularProgressIndicator(),
          loaded: (data) {
            if (data.isEmpty) {
              return Container(); //TODO no UI if empty
            }
            return _buildLoansTrend(data);
          },
          error: (message) => Text(message),
        );
      },
    );
  }

  Widget _buildLoansTrend(AggregatedLoansTrendData data) {
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
              Text(
                'Loans Trend (N\'M) - YOY/12 Months',
                style: kTrendTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoansItem(loansLine1: 'Actual', loansLine2: 'Loans', value: "${double.parse((data.actualLoans / divisor).toStringAsFixed(2))}b"),
                  LoansItem(loansLine1: ' ', loansLine2: 'DoD', value: data.actualLoansChange.toString()),
                  LoansItem(loansLine1: 'Average', loansLine2: 'Loans', value: "${double.parse((data.averageLoans / divisor).toStringAsFixed(2))}b"),
                  LoansItem(loansLine1: ' ', loansLine2: 'DoD', value: data.averageLoansChange.toString()),
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
    return Column(children: [
      Text(
        loansLine1!,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 12.0,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      Text(
        loansLine2!,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 12.0,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      SizedBox(height: 5.0),
      Text(
        value!,
        style: TextStyle(color: Colors.blueGrey.shade700),
      ),
    ]);
  }
}

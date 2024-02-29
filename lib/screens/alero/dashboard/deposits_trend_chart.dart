import 'package:alero/screens/alero/dashboard/bloc/deposits_trend_bloc/deposits_trend_bloc.dart';
import 'package:alero/screens/alero/dashboard/deposits_chart.dart';
import 'package:alero/screens/alero/dashboard/repository/deposits_repository.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../style/theme.dart' as Style;
import '../../../network/AleroAPIService.dart';

class DepositsTrendChart extends StatefulWidget {
  @override
  _DepositsTrendChartState createState() => _DepositsTrendChartState();
}

class _DepositsTrendChartState extends State<DepositsTrendChart> {
  late final DepositsTrendBloc bloc;
  @override
  void initState() {
    bloc = DepositsTrendBloc(repository: DepositsTrendRepository(apiService: AleroAPIService()))..getDepositsTrendData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  final List<Color> gradientColors = [
    Style.Colors.fourthColor,
    Style.Colors.fourthColor,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepositsTrendBloc, DepositsTrendState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: _buildEmptyOrLoading,
          loaded: (data) {
            if (data.isEmpty) {
              return _buildEmptyOrLoading();
            }
            return _buildDepositsTrendChart(data);
          },
          error: (message) => Text(message),
        );
      },
    );
  }

  Widget _buildEmptyOrLoading() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/customer/trends/trends_empty_pie.svg',
      ),
    );
  }

  Widget _buildDepositsTrendChart(AggregatedDepositsTrendData data) {
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
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Deposits Trend (N\'M) - YOY/12 Months',
                  style: kTrendTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DepositsItem(
                        depositLine1: 'Actual',
                        depositLine2: 'Deposit',
                        value: "${double.parse((data.actualDeposits / kDepositsDivisor).toStringAsFixed(2))}tr"),
                    DepositsItem(depositLine1: ' ', depositLine2: 'DoD', value: data.actualDepositsChange.toString()),
                    DepositsItem(
                        depositLine1: 'Average',
                        depositLine2: 'Deposit',
                        value: "${double.parse((data.averageDeposits / kDepositsDivisor).toStringAsFixed(2))}tr"),
                    DepositsItem(depositLine1: ' ', depositLine2: 'DoD', value: data.averageDepositsChange.toString()),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                  child: DepositsChart(),
                ),
              ]),
            )));
  }
}

class DepositsItem extends StatelessWidget {
  DepositsItem({this.depositLine1, this.depositLine2, this.value});

  final String? depositLine1;
  final String? depositLine2;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        depositLine1!,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 12.0,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      Text(
        depositLine2!,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.blueGrey,
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

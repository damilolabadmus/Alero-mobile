

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bank_performance_bloc/bank_performance_bloc.dart';
import '../bloc/bank_performance_bloc/bank_performance_state.dart';
import '../repository/bank_performance_repository.dart';

class BankPerformanceItems extends StatefulWidget {
  final String? groupId;

  const BankPerformanceItems({Key? key, this.groupId}) : super(key: key);

  @override
  _BankPerformanceItemsState createState() => _BankPerformanceItemsState();
}

class _BankPerformanceItemsState extends State<BankPerformanceItems> {
  late final BankPerformanceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BankPerformanceBloc(repository: BankPerformanceRepository(apiService: AleroAPIService()));
    bloc.getBankPerformanceData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankPerformanceBloc, BankPerformanceState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => CircularProgressIndicator(),
          loaded: (data) => _buildCards(data),
          error: (message) => Text('Error: $message'),
        );
      },
    );
  }

  Widget _buildCards(BankPerformanceTotals data) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCard(data.totalCustomers, 'Total Customers'),
          _buildCard(data.ytdCustomers, 'YTD Customers'),
          _buildCard(data.totalAccounts, 'Total Accounts'),
          _buildCard(data.ytdAccounts, 'YTD Accounts'),
        ],
      ),
    );
  }

  Widget _buildCard(double value, String title) {
    return Container(
      height: 90,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Card(
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: kBankItemValue,
                ),
                SizedBox(height: 6),
                Text(title, style: kBankItemTitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

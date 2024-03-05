

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/trends_transactions_list_item.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';

class RecentTransactionsList extends StatefulWidget {
  final String? customerId, groupId, customerAccountNo;

  const RecentTransactionsList(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecentTransactionsListState();
  }
}

class _RecentTransactionsListState extends State<RecentTransactionsList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> recentTransactions = [];

  @override
  void initState() {
    super.initState();
    getRecentTransactions(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentTransactions.length,
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: recentTransactions[index]);
              }),
        );
      },
      future: getRecentTransactions(widget.groupId),
    );
  }

  Future getRecentTransactions(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final recentTrans = widget.customerAccountNo == null ? await apiService.getRecentTransactions(groupId!)
          : await apiService.getRecentTransactionsWithAccountNo(widget.customerAccountNo!);
      List<Widget> _recentTransactionsItem = [];
      if (recentTrans.length == 0) {
        _recentTransactionsItem
            .add(EmptyListItem(message: 'No Recent Transaction'));
      } else {
        recentTrans.forEach((transaction) {
          _recentTransactionsItem.add(TrendsTransactionListItem(
            transactionDescription: transaction["narration"],
            transactionDate: transaction["transactionDate"],
            inflow: (transaction["debitCreditStatus"] == "C") ? true : false,
            amount: transaction["lcyAmount"],
          ));
        });
      }
      if (mounted) {
        setState(() {
          recentTransactions = _recentTransactionsItem;
        });
      }
      return recentTrans;
    });
  }
}

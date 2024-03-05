

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:alero/screens/alero/components/overview_trade_transactions_list_item.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';

class TradeTransactionsBodyList extends StatefulWidget {
  final String? customerId, groupId;
  final String? customerAccountNo;

  const TradeTransactionsBodyList({Key? key, this.customerId, this.groupId, this.customerAccountNo}) : super(key: key);

  @override
  State<TradeTransactionsBodyList> createState() => _TradeTransactionsBodyListState();
}

class _TradeTransactionsBodyListState extends State<TradeTransactionsBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> tradeTransactions = [];

  @override
  void initState() {
    super.initState();
    getTradeTransactionsDetails(widget.groupId);
  }


  Future getTradeTransactionsDetails(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final tradeTransactionsData = widget.customerAccountNo == null
          ? await apiService.getCustomerTradeTransactionsData(groupId!)
          : await apiService.getCustomerTradeTransactionsDataWithAccountNo(widget.customerAccountNo!);
      List<Widget> tradeTransactionItem = [];
      if (tradeTransactionsData.length == 0) {
        tradeTransactionItem.add(
            EmptyListItem(message: 'No Trade Transactions Found'));
      } else {
        tradeTransactionsData.forEach((transaction) {
          tradeTransactionItem.add(
            OverviewTradeTransactionsListItem(
              tradeAmount: transaction['trade_Amount'],
              status: (transaction['status'] == "LIV") ? true : false,
              tradeDate: transaction['trade_Date'],
              tradeDesc: transaction['trade_Desc'],
              tradeExpiryDate: transaction['trade_Expiry_Date'],
            ),
          );
        });
      }
      if (mounted) {
        setState(() {
          tradeTransactions = tradeTransactionItem;
        });
      }
      return tradeTransactionsData;
    });}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot){
      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null ||
          snapshot.connectionState == ConnectionState.waiting) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          ),);
      }
      return Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: tradeTransactions.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter, child: tradeTransactions[index]);
              }));
      },
      future: getTradeTransactionsDetails(widget.groupId),
    );
  }
}

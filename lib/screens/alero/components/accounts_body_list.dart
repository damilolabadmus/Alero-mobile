

import 'package:alero/network/AleroAPIService.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';
import 'overview_accounts_list_item.dart';

class AccountsBodyList extends StatefulWidget {
  final String? customerId, groupId;

  const AccountsBodyList(
      {Key? key, required this.customerId, required this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccountsBodyListState();
  }
}

class _AccountsBodyListState extends State<AccountsBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> accountsItem = [];

  @override
  void initState() {
    super.initState();
    getBankingData(widget.groupId);
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
        return Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: accountsItem.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: accountsItem[index]);
              }));
      },
      future: getBankingData(widget.groupId),
    );
  }

  Future getBankingData(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final accountData = await apiService.getBankingData(groupId!);
      List<Widget> _accountsItem = [];
      if (accountData.length == 0) {
        _accountsItem.add(EmptyListItem(message: 'No Customer Accounts'));
      } else {
        accountData.forEach((account) {
          _accountsItem.add(OverviewAccountsListItem(
            accountType: account["accountClassName"],
            accountNumber: account["accountNumber"],
            createdAddress: account["branchName"],
            createdDate: account["acctOpeningDate"],
            balance: account["ccyBalance"],
            active: (account["activeStatus"] == 'ACTIVE') ? true : false,
            currency: account["currency"],
          ));
        });
      }
      if (mounted) {
        setState(() {
          accountsItem = _accountsItem;
        });
      }
      return accountData;
    });
  }
}

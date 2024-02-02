

import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';
import 'overview_loans_list_item.dart';

class LoansBodyList extends StatefulWidget {
  final String? customerId, groupId;
  final String? customerAccountNo;

  const LoansBodyList(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoansBodyListState();
  }
}

class _LoansBodyListState extends State<LoansBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> loans = [];

  @override
  void initState() {
    super.initState();
    getLoanDetails(widget.groupId);
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
                itemCount: loans.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Align(
                      alignment: Alignment.topCenter, child: loans[index]);
                }));
      },
      future: getLoanDetails(widget.groupId),
    );
  }

  Future getLoanDetails(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final loansData = widget.customerAccountNo == null
          ? await apiService.getCustomerLoansData(groupId!)
          : (await apiService.getCustomerLoansDataWithAccountNo(widget.customerAccountNo!))!;
      List<Widget> loanItem = [];
      if (loansData.length == 0) {
        loanItem.add(EmptyListItem(message: 'No Loans Found'));
      } else {
        loansData.forEach((loan) {
          loanItem.add(
            OverviewLoansListItem(
              loanReceiver: loan["productName"],
              loanAccountNumber: loan["loanAccountNumber"],
              disbursedDate: loan["disbursedDate"],
              loanTenor: loan["loanTenor"],
              nextRepaymentDate: loan["nextRepaymentDate"],
              balance: loan["outstandingPrincipalAmount"],
              nextRepaymentAmount: loan["nextRepaymentAmount"],
              performing: (loan["loanStatus"] == 'PERFORMING') ? true : false,
              expiryDate: loan["expiryDate"],
            ),
          );
        });
      }
      if (mounted) {
        setState(() {
          loans = loanItem;
        });
      }
      return loansData;
    });
  }
}

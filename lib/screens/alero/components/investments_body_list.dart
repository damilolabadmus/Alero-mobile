

import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';
import 'overview_investments_list_item.dart';

class InvestmentsBodyList extends StatefulWidget {
  final String? customerId, groupId;
  final String? customerAccountNo;

  const InvestmentsBodyList(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InvestmentsBodyListState();
  }
}

class _InvestmentsBodyListState extends State<InvestmentsBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> investments = [];

  @override
  void initState() {
    super.initState();
    getCustomerInvestmentsData(widget.groupId);
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
                  itemCount: investments.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                        alignment: Alignment.topCenter,
                        child: investments[index]);
                  }));
        },
        future: getCustomerInvestmentsData(widget.groupId)
    );
  }

  Future getCustomerInvestmentsData(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final investmentData =
      widget.customerAccountNo == null ? await apiService.getCustomerInvestmentData(groupId!) : await apiService.getCustomerInvestmentDataWithAccountNo(widget.customerAccountNo!);
      List<Widget> investmentItem = [];
      if (investmentData.length == 0) {
        investmentItem.add(EmptyListItem(message: 'No Investments'));
      } else {
        investmentData.forEach((investment) {
          investmentItem.add(OverviewInvestmentsListItem(
            bookedDate: investment["bookingDate"],
            investmentType: investment["productName"],
            investmentDuration: (investment["investmentDuration"] == null)
                ? ''
                : "For ${investment["investmentDuration"]}",
            maturityDate: investment["expiryDate"],
            balance: investment["ccyAmount"],
            active: (investment["investmentStatus"] == 'ACTIVE') ? true : false,
          ));
        });
      }
      if (mounted) {
        setState(() {
          investments = investmentItem;
        });
      }
      return investmentData;
    });
  }
}

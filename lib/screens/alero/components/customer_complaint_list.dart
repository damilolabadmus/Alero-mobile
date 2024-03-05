

import 'package:alero/network/AleroAPIService.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'customer_complaints_list_item.dart';
import 'empty_list_item.dart';

class CustomerComplaintsList extends StatefulWidget {
  final String? customerId, groupId;

  const CustomerComplaintsList(
      {Key? key, required this.customerId, required this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerComplaintsListState();
  }
}

class _CustomerComplaintsListState extends State<CustomerComplaintsList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> customerComplaints = [];

  @override
  void initState() {
    super.initState();
    getcustomerComplaints(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: customerComplaints.length,
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: customerComplaints[index]);
              }),
        );
      },
      future: getcustomerComplaints(widget.groupId),
    );
  }

  Future getcustomerComplaints(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final signatories = await apiService.getCustomerComplaints(groupId!);
      List<Widget> _customerComplaintsItem = [];
      if (signatories.length == 0) {
        _customerComplaintsItem
            .add(EmptyListItem(message: 'No Customer Complaints'));
      } else {
        signatories.forEach((complaint) {
          _customerComplaintsItem.add(CustomerComplaintsListItem(
              category: complaint["complaintCategory"],
              description: complaint["complaintDescription"],
              resolvedDate: complaint["complaintReslvedDate"],
              loggedDate: complaint["complaintCreatedDate"],
              status: (complaint["complaintStatus"].toString().toUpperCase() ==
                  "CLOSED")
                  ? true
                  : false));
        });
      }
      if (mounted) {
        setState(() {
          customerComplaints = _customerComplaintsItem;
        });
      }
      return signatories;
    });
  }
}

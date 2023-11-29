import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/signatories_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';

class CustomerSignatoriesList extends StatefulWidget {
  final String customerId, groupId;

  const CustomerSignatoriesList(
      {Key key, @required this.customerId, @required this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerSignatoriesListState();
  }
}

class _CustomerSignatoriesListState extends State<CustomerSignatoriesList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> customerSignatories = [];

  @override
  void initState() {
    super.initState();
    getcustomerSignatories(widget.groupId);
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
              itemCount: customerSignatories.length,
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: customerSignatories[index]);
              }),
        );
      },
      future: getcustomerSignatories(widget.groupId),
    );
  }

  Future getcustomerSignatories(String groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final signatories = await apiService.getCustomerSignatories(groupId);
      List<Widget> _customerSignatoriesItem = [];
      if (signatories.length == 0) {
        _customerSignatoriesItem
            .add(EmptyListItem(message: 'No Customer Signatories'));
      } else {
        signatories.forEach((signatory) {
          _customerSignatoriesItem.add(SignatoriesListItem(
            name: signatory["sigCustomerName"],
            phoneNumber: signatory["sigMobileNumber"],
          ));
        });
      }
      if (mounted) {
        setState(() {
          customerSignatories = _customerSignatoriesItem;
        });
      }
      return signatories;
    });
  }
}

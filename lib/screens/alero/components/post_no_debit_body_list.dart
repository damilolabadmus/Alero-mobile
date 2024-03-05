

import 'package:alero/network/AleroAPIService.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';
import 'overview_pnd_list_item.dart';

class PostNoDebitBodyList extends StatefulWidget {
  final String? customerId, groupId;
  final String? customerAccountNo;

  const PostNoDebitBodyList(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostNoDebitBodyListState();
  }
}

class _PostNoDebitBodyListState extends State<PostNoDebitBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget>  postNoDebit = [];

  @override
  void initState() {
    super.initState();
    getPostNoDebitData(widget.groupId);
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
                  itemCount: postNoDebit.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                        alignment: Alignment.topCenter,
                        child: postNoDebit[index]);
                  }));
        },
        future: getPostNoDebitData(widget.groupId)
    );
  }


  Future getPostNoDebitData(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final pndDataWithAccountNo = widget.customerAccountNo == null
          ? await apiService.getPNDData(groupId!)
          : await apiService.getPNDWithAccountNo(widget.customerAccountNo!);
      List<Widget> pndItemWithAccountNo = [];
      if (pndDataWithAccountNo.length == 0) {
        pndItemWithAccountNo.add(EmptyListItem(message: 'No PND Data Found'));
      } else {
        pndDataWithAccountNo.forEach((pndWithAccountNo) {
          pndItemWithAccountNo.add(OverviewPNDListItem(
            accountNumber: pndWithAccountNo['accountNumber'],
            addedDate: pndWithAccountNo['pndDate'],
            reason: pndWithAccountNo['pndReason'],
          ));
        });
      }
      if (mounted) {
        setState(() {
          postNoDebit = pndItemWithAccountNo;
        });
      }
      return pndDataWithAccountNo;
    });
  }
}




import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/directors_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';

class CustomerDirectorsList extends StatefulWidget {
  final String? customerId, groupId;

  const CustomerDirectorsList(
      {Key? key, required this.customerId, required this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerDirectorsListState();
  }
}

class _CustomerDirectorsListState extends State<CustomerDirectorsList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> customerDirectors = [];

  @override
  void initState() {
    super.initState();
    getcustomerDirectors(widget.groupId);
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
              itemCount: customerDirectors.length,
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: customerDirectors[index]);
              }),
        );
      },
      future: getcustomerDirectors(widget.groupId),
    );
  }

  Future getcustomerDirectors(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final directors = await apiService.getCustomerDirectors(groupId!);
      List<Widget> _customerDirectorsItem = [];
      if (directors.length == 0) {
        _customerDirectorsItem
            .add(EmptyListItem(message: 'No Customer Directors'));
      } else {
        directors.forEach((director) {
          _customerDirectorsItem.add(DirectorsListItem(
            name: director["directorName"],
            phoneNumber: director["directorPhoneNumber"],
            gender: director["directorGender"],
          ));
        });
      }
      if (mounted) {
        setState(() {
          customerDirectors = _customerDirectorsItem;
        });
      }
      return directors;
    });
  }
}

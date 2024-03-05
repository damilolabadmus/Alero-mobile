

import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/nbo_item.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';

class NextBestOfferingBodyList extends StatefulWidget {
  final String? customerId, groupId;

  const NextBestOfferingBodyList(
      {Key? key, required this.customerId, required this.groupId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NextBestOfferingBodyListState();
  }
}

class _NextBestOfferingBodyListState extends State<NextBestOfferingBodyList> {
  bool loading = true;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  List<Widget> nboItem = [];
  List<Color> randomColors = [];

  @override
  void initState() {
    super.initState();
    getNextBestOffering(widget.groupId);
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
              itemCount: nboItem.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Align(
                    alignment: Alignment.topCenter, child: nboItem[index]);
              }),
        );
      },
      future: getNextBestOffering(widget.groupId),
    );
  }

  Future getNextBestOffering(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      final nboData = await apiService.getNBOData(groupId!);
      List<Widget> _nboItem = [];
      if (nboData.length == 0) {
        _nboItem.add(
            EmptyListItem(message: 'An offer would be made available soon'));
      } else {
        generateColors(nboData.length);
        for (int i = 0; i < nboData.length; i++) {
          _nboItem.add(NBOItem(
            value: nboData[i],
            backgroundColor: randomColors[i].withOpacity(0.5),
          ));
        }
      }
      if (mounted) {
        setState(() {
          nboItem = _nboItem;
        });
      }
      return nboData;
    });
  }

  void generateColors(int length) {
    var list = [
      0xFF99C9D9,
      0xFF555555,
      0xFF008EC4,
      0xFFBBBBBB,
      0xFFFFDAA6,
      0xFFB3A369,
      0xFFF4B459,
      0xFF7AC369
    ];
    for (int i = 0; i < length; i++) {
      if (!randomColors.contains(list[i])) {
        randomColors.add(Color(list[i]));
      }
    }
  }
}

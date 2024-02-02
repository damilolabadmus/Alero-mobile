

import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CardPlaceHolderWithImage(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CardPlaceHolderWithImage(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CardPlaceHolderWithImage(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CardPlaceHolderWithImage(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          ),
        ],
      ),
    ));
  }
}

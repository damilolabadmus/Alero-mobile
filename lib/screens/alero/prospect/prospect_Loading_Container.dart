import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import '../../../style/theme.dart' as Style;

class ProspectLoadingContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.Colors.tabBackGround,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Container(
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
                          SimpleTextPlaceholder(),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

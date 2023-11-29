import 'package:alero/models/call/DealsByProductsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/pipeline/pipeline_deals_header.dart';
import 'package:alero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class PendingDealsByProduct extends StatefulWidget {
  const PendingDealsByProduct({Key key}) : super(key: key);

  @override
  _PendingDealsByProductState createState() => _PendingDealsByProductState();
}

class _PendingDealsByProductState extends State<PendingDealsByProduct> {
  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List dealsByProducts = [];
  DealsByProductsResponse productItems;

  @override
  void initState() {
    super.initState();
    getPendingDealsByProductsList();
  }

  Future<dynamic> getPendingDealsByProductsList() async {
    return this._asyncMemoizer.runOnce(() async {
      var _productItem = await apiService.getPendingDealsByProduct();
      setState(() {
        productItems = _productItem;
        dealsByProducts = productItems.result.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Text('Pending Deals by Products', style: kTrendTextStyle),
              ),
              Container(
                color: Colors.grey.shade300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PipelineDealsHeader(title: 'PRODUCT TYPE'),
                    PipelineDealsHeader(title: 'CURRENCY'),
                    PipelineDealsHeader(title: 'COUNT'),
                    PipelineDealsHeader(title: 'VALUE'),
                  ],),),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dealsByProducts.length,
                  itemBuilder: (context, index) {
                    var pendingProducts = dealsByProducts[index];
                    return Container(
                      padding: EdgeInsets.only(left: 3.0, right: 3.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.black45,
                            width: 1.0,
                          ),),),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PipelineDealsHeader(title: pendingProducts.product),
                            PipelineDealsHeader(title: pendingProducts.currency),
                            PipelineDealsHeader(title: pendingProducts.count.toString()),
                            PipelineDealsHeader(title: pendingProducts.value.toString()),
                          ],),
                      ),);
                  },),),
              SizedBox(height: 20.0, child: Divider(thickness: 1.0, color: Colors.black45,),),
            ],)
      ),
    );
  }
}

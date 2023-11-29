import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/value_chain_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'empty_list_item.dart';

class ValueChainBodyList extends StatefulWidget {
   final String customerId, groupId;

   const ValueChainBodyList(
       {Key key, @required this.customerId, @required this.groupId})
       : super(key: key);

   @override
   State<StatefulWidget> createState() {return _ValueChainBodyListState();
   }
}

class _ValueChainBodyListState extends State<ValueChainBodyList> {
bool loading = true;
final AsyncMemoizer _valueChain = AsyncMemoizer();
var apiService = AleroAPIService();
List<Widget> valueChain = [];

@override
void initState() {
        super.initState();
        getValueChainData(widget.customerId);
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
        );}
        return Flexible(
           child: ListView.builder(
                shrinkWrap: true,
                itemCount: valueChain.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                        return Align(
                            alignment: Alignment.topCenter, child: valueChain[index]);
                }));},
 future: getValueChainData(widget.customerId),);}

// No specificity for value chain
Future getValueChainData(String customerId) async {
    return this._valueChain.runOnce(() async {
        final valueChainData = await apiService.getValueChainData(customerId);
        print(valueChainData);
        List<Widget> valueChainItem = [];
        if (valueChainData.length == 0) {
            valueChainItem.add(EmptyListItem(
               message: 'No value chain available for this customer'));
        } else {
            valueChainData.forEach((valueChain) {
               valueChainItem.add(
                    ValueChainListItem(
                        valueChain: valueChain["valueChain"],
                        valueChainCustomerId: valueChain["customerId"],
                        valueChainGroup: valueChain["valueChainGroup"],
                        valueChainSector: valueChain["valueChainSector"],
               ),
     ); });}
   if (mounted) {
     setState(() {
       valueChain = valueChainItem;
     });}
    return valueChainData;
    });}}

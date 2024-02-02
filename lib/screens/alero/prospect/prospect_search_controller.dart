

import 'dart:async';
import 'package:alero/models/call/ProspectDetailsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/prospect/view_prospect_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:one_context/one_context.dart';
import '../../../style/theme.dart' as Style;

class ProspectSearchController extends StatefulWidget {

  @override
  _ProspectSearchControllerState createState() => _ProspectSearchControllerState();
}

class _ProspectSearchControllerState extends State<ProspectSearchController> {
  TextEditingController textController = new TextEditingController();

  var apiService = AleroAPIService();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  List prospectOnSearch = [];
  ProspectDetailsResponse? prospects;

  @override
  void initState() {
    super.initState();
    getProspectList();
  }

  Future<dynamic> getProspectList() async {
    return this._asyncMemoizer.runOnce(() async {
      OneContext().showProgressIndicator();
      var _prospects = await apiService.getProspects();
      setState(() {
        prospects = _prospects;
        prospectOnSearch = prospects!.result!.userProspects!.toList();
      });
      OneContext().hideProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey.shade200,
                    filled: true,
                    hintText: "Search Prospect",
                    prefixIcon: Icon(
                      EvaIcons.searchOutline,
                      color: Style.Colors.buttonColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        prospectOnSearch =
                            prospects!.result!.userProspects!.where((element) =>
                                element.prospectName!.toLowerCase().contains(value.toLowerCase())).toList();
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              prospectOnSearch.isEmpty ?
              Center(
                child: Text("No results found",
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ) :
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: prospectOnSearch.length,
                  itemBuilder: (context, index) {
                    var prospect = prospectOnSearch[index];
                    return Card(
                      elevation: 5.0,
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/user.png'),
                                    ),),
                                  SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(textController.text.isNotEmpty
                                          ? prospectOnSearch[index]
                                          : prospect.prospectName,
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0),),
                                      Text(textController.text.isNotEmpty
                                          ? prospectOnSearch[index]
                                          : prospect.businessSegment,
                                        style: TextStyle(color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),),
                                    ],
                                  ),
                                ],
                              ),
                              ViewProspectButton(
                                prospect.prospectId,
                                prospect.keyPromoterName,
                                prospect.prospectName,
                                prospect.prospectAddress,
                                prospect.prospectType,
                                prospect.businessSegment,
                                prospect.productOffered,
                                prospect.customerWalletSize,
                                prospect.contactPersonName,
                                prospect.contactPersonEmail,
                                prospect.contactPersonPhoneNo,
                                prospect.contactPersonAddress,
                                prospect.prospectConverted,
                                prospect.accountNo,
                                prospect.introducerStaffCode,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5.0),
            ],
          );
        },
        future: getProspectList()
    );
  }
}


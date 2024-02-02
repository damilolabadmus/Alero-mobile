

/*import 'dart:ui';
import 'dart:io' show Platform;
import 'package:alero/network/AleroAPIService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessSegmentDropDown extends StatefulWidget {
  String businessSegment;
  String prospectType;

  BusinessSegmentDropDown({Key key, this.businessSegment, this.prospectType}) : super(key: key);

  @override
  _BusinessSegmentDropDownState createState() =>
      _BusinessSegmentDropDownState();
}

class _BusinessSegmentDropDownState extends State<BusinessSegmentDropDown> {
  var apiService = AleroAPIService();

  List<String> businessSegments;
  getBusinessSegment() async {
    List<String> _businessSegments = await apiService.getProspectBusinessSegments();
    setState(() {
      businessSegments = _businessSegments;
    });
  }

  List<String> prospectTypes = [
    'Individual',
    'Non individual',
  ];


  Text getValue(String value) {
    if (value == null || value.isEmpty) {
      return Text('Select One',
          style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(
          value, style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    }
  }

  ButtonTheme androidDropDown(List<String> dropDownList, bool isBuissnessSeg) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.white,
        hint: getValue(isBuissnessSeg ? widget.businessSegment : widget.prospectType),
        items: dropDownList.map(buildBusinessSegmentItem).toList(),
        onChanged: (value) {
          setState(() {
            if(isBuissnessSeg) {
              widget.businessSegment = value;
            }else{
              widget.prospectType = value;
            }
          });
        },
      ),
    );
  }

  CupertinoPicker iOSPicker(List<String> dropDownList, bool isBuissnessSeg) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildBusinessSegmentItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          if(isBuissnessSeg) {
            widget.businessSegment = businessSegments[value];
          } else{
            widget.prospectType = prospectTypes[value];
          }
        });
        final item = businessSegments[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBuissnessSeg ?'Business Segment' : 'Prospect Type',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ?
          iOSPicker(dropDownList,isBuissnessSeg):
          androidDropDown(dropDownList,isBuissnessSeg),
        ],
      ),
    );
  }


  DropdownMenuItem<String> buildBusinessSegmentItem(String item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 5,
                  fontFamily: 'Poppins-Regular',
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid){
      return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(height: 0.2,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'Poppins-Regular',
              fontStyle: FontStyle.italic),
        ),
      );
    }
  }
}
*/
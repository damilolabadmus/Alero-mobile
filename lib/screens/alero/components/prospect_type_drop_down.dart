import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ProspectTypeDropDown extends StatefulWidget {
  @override
  _ProspectTypeDropDownState createState() => _ProspectTypeDropDownState();
}

class _ProspectTypeDropDownState extends State<ProspectTypeDropDown> {
  var prospectTypes = [
    'Individual',
    'Non individual',
  ];

  int selectedValue = 0;
  String value = '';

  Text getValue(String value) {
    if (value == '') {
      return Text('Select One',
          style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(
          value, style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    }
  }


  ButtonTheme androidDropDown() {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.grey.shade100,
        hint: getValue(value),
        items:  prospectTypes.map(buildProspectTypeItem).toList(),
        onChanged: (value) {
          setState(() {
            this.value = value;
          });
        },
      ),
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children:  prospectTypes.map(buildProspectTypeItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        final item = prospectTypes[value];
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
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prospect Type',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          SizedBox(height: 5,),
          Platform.isIOS ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prospectTypes[selectedValue],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold, fontFamily: 'Poppins-Regular',
                ),
              ),
              iOSPicker(),
            ],) :
          androidDropDown(),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildProspectTypeItem(String item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        onTap: () {

        },
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
        onTap: () {},
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

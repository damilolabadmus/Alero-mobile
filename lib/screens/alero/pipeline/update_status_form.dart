import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/models/call/UpdateStatusDetailsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/call/pipeline_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class UpdateStatusForm extends StatefulWidget {
  final DealsForDisbursement disbursedStatus;

  const UpdateStatusForm({Key key, @required this.disbursedStatus}) : super(key: key);

  @override
  _UpdateStatusFormState createState() => _UpdateStatusFormState();
}

class _UpdateStatusFormState extends State<UpdateStatusForm> {
  DealsStatusUpdate selectedStatus;
  DealsListOfSubstatus subStatus;
  StatusResult statusResult;
  String pipelineId;
  String statusId;
  String subStatusId;
  String comment;

  TextEditingController commentController;
  DealsStatusUpdate statusIdController;
  DealsListOfSubstatus subStatusIdController;

  final _formKey = GlobalKey<FormState>();
  var apiService = AleroAPIService();

  getStatusList() async {
    StatusResult _statusOptions = await apiService.getListOfStatusOptions();
    print('The status = $_statusOptions');
    setState(() {
      statusResult = _statusOptions;
    });
  }

  List<DealsStatusUpdate> getStatusUpdateCategory(int category) {
    if (category == 1) {
      return statusResult.statusUpdate1;
    } else {
      return statusResult.statusUpdate2;
    }
  }

  @override
  void initState() {
    getStatusList();
    commentController = TextEditingController(text: comment);
  }

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
        child: Text(
          'Cancel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });

    Map getDealStatusDetails() {
      return {
        'pipelineId': widget.disbursedStatus.pipelineId,
        'dealStatus': statusIdController.statusId,
        'subStatus': subStatusIdController?.statusId,
        'comment': commentController.text.toString(),
      };
    }

    Widget updateStatusButton = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: ElevatedButton(
            child: Text(
              'Update Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),
            ),
            onPressed: () async {
              var info = getDealStatusDetails();
              await apiService.updateDealStatus(info);
              showAlert(context);
            }
        ));
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 60.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          reverse: true,
          child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You are updating the deal status for ' + widget.disbursedStatus.customerName.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Select the appropriate status to update the deal.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    statusResult == null ? Text('') :
                    statusDropDownComponent(context, getStatusUpdateCategory(
                        widget.disbursedStatus.category)),
                    selectedStatus == null ? Text('') : selectedStatus
                        .listOfSubstatus.isEmpty ? Text('') :
                    subStatusDropDownComponent(
                        context, selectedStatus.listOfSubstatus),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Comment',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 14
                            ),),
                          TextFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Pls, fill out this field.';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              comment = value;
                            },
                            controller: commentController,
                            toolbarOptions: ToolbarOptions(copy: true,
                                cut: true,
                                paste: true,
                                selectAll: true),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),),
                        ],),),
                  ],);
              }),),),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 37, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cancelButton,
              updateStatusButton
            ],
          ),),
      ],);
  }

  CupertinoPicker statusIOSPicker(List<DealsStatusUpdate> dropDownList) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildStatusItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedStatus = dropDownList[value];
        });
        final item = dropDownList[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }

  ButtonTheme statusAndroidDropDown(List<DealsStatusUpdate> dropDownList) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<DealsStatusUpdate>(
        value: selectedStatus,
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 30,
        dropdownColor: Colors.white,
        hint: getValue(selectedStatus?.status),
        items: dropDownList.map(buildStatusItem).toList(),
        onChanged: (value) {
          setState(() {
            selectedStatus = value;
            statusIdController = selectedStatus;
          },);
        },),);
  }

  Widget statusDropDownComponent(BuildContext context,
      List<DealsStatusUpdate> dropDownList) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ?
          statusIOSPicker(dropDownList) :
          Container(color: Colors.grey.shade300,
              child: statusAndroidDropDown(dropDownList)),
        ],),);
  }

  DropdownMenuItem<DealsStatusUpdate> buildStatusItem(DealsStatusUpdate item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.status,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 5,
                  fontFamily: 'Poppins-Regular',
                  fontStyle: FontStyle.italic),
            ),
          ],),
      );
    }
    if (Platform.isAndroid) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.status,
          style: TextStyle(height: 0.2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54,
              fontFamily: 'Poppins-Regular',
              fontStyle: FontStyle.italic),
        ),);
    }
  }

  // SubStatus
  ButtonTheme subStatusAndroidDropDown(
      List<DealsListOfSubstatus> dropDownList) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<DealsListOfSubstatus>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 30,
        dropdownColor: Colors.white,
        hint: getValue(subStatus?.status),
        items: dropDownList.map(buildSubStatus).toList(),
        onChanged: (value) {
          setState(() {
            subStatus = value;
            subStatusIdController = subStatus;
          },);
        },),);
  }

  CupertinoPicker subStatusIOSPicker(List<DealsListOfSubstatus> dropDownList) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildSubStatus).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          subStatus = dropDownList[value];
        });
        final item = dropDownList[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }

  Widget subStatusDropDownComponent(BuildContext context, List<DealsListOfSubstatus> dropDownList) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sub-Status',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ?
          subStatusIOSPicker(dropDownList) :
          Container(color: Colors.grey.shade300,
              child: subStatusAndroidDropDown(dropDownList)),
        ],),);
  }

  DropdownMenuItem<DealsListOfSubstatus> buildSubStatus(
      DealsListOfSubstatus item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.status,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 5,
                  fontFamily: 'Poppins-Regular',
                  fontStyle: FontStyle.italic),
            ),
          ],),);
    }
    if (Platform.isAndroid) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.status,
          style: TextStyle(height: 0.2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54,
              fontFamily: 'Poppins-Regular',
              fontStyle: FontStyle.italic),
        ),);
    }
  }

  Text getValue(String value) {
    if (value == null || value.isEmpty) {
      return Text('Select One',
          style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(
          value, style: TextStyle(
          height: 0.4, fontFamily: 'Poppins-Regular', color: Colors.black54));
    }
  }

  showAlert(BuildContext context) {
    Widget closeButton = TextButton(
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => PipelinePage(groupId: ''),),
          );
        });

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 190.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Center(child: Icon(Icons.thumb_up_alt_sharp, size: 35,
                color: Colors.lightBlueAccent)),
          ),
          Text(
            'You have successfully updated the deal status for ' +
                widget.disbursedStatus.customerName.toString(),
            style: TextStyle(
              fontSize: 15,
              height: 2,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ],),
      actions: [
        closeButton,
      ],);
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },);
  }
}

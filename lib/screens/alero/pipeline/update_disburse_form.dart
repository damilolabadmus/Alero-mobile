

import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/call/pipeline_page.dart';
import 'package:flutter/material.dart';

class UpdateDisburseForm extends StatefulWidget {
  final DealsForDisbursement disbursedStatus;

  const UpdateDisburseForm({Key? key, required this.disbursedStatus}) : super(key: key);

  @override
  _UpdateDisburseFormState createState() => _UpdateDisburseFormState();
}

class _UpdateDisburseFormState extends State<UpdateDisburseForm> {
  String? disbursedAmount;
  TextEditingController? disbursedAmountController;

  var apiService = AleroAPIService();

  @override
  void initState() {
    super.initState();
    disbursedAmountController = TextEditingController(text: disbursedAmount);
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
          Navigator.pop(context);
        }
    );
    Map getDisburseDetails() {
      return {
        'pipelineId': widget.disbursedStatus.pipelineId,
        'disbursedAmount': disbursedAmountController!.text.toString(),
      };
    }
    Widget updateDisburseButton = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: ElevatedButton(
            child: Text(
              'Update Disbursement',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),
            ),
            onPressed: () async {
              var info = getDisburseDetails();
              await apiService.updateDisbursementDisburse(info);
              showAlertForDisburse(context);
            }
        ));
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 120.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      content: Form(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You are updating the deal disbursement for' + widget.disbursedStatus.customerName.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Please enter an amount to complete.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 14
                      ),),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Pls, enter amount.';
                        } else if (num.tryParse(value) == null) {
                          return 'Please enter a valid amount.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        disbursedAmount = value;
                      },
                      controller: disbursedAmountController,
                      toolbarOptions: ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                    ),],),),
            ],),),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 37, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cancelButton,
              updateDisburseButton
            ],),),],);
  }

  showAlertForDisburse(BuildContext context) {
    Widget closeButton = TextButton(
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => PipelinePage(groupId: ''),),
          );
        }
    );

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 180.0,
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
            child: Center(child: Icon(Icons.thumb_up_alt_sharp, size: 35, color: Colors.lightBlueAccent)),
          ),
          Text(
            'You have successfully updated the deal disbursement for ' + widget.disbursedStatus.customerName.toString(),
            style: TextStyle(
              fontSize: 15,
              height: 2,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),],),
      actions: [
        closeButton,
      ],
    );
    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },);}
}

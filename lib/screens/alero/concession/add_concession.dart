import 'package:flutter/material.dart';
import '../prospect/call_bio_data_text_field.dart';

class AddConcession extends StatefulWidget {

  @override
  State<AddConcession> createState() => _AddConcessionState();
}

class _AddConcessionState extends State<AddConcession> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Row(
            children: [
              Text('Account\nNumber'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter account number';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: '3045678499',
                textInputAction: TextInputAction.next,
                readOnly: false,
                keyboardType: TextInputType.number,
              )
            ],
          ),
          Row(
            children: [
              Text('Account\nName'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter account name';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: 'Franklin Eze',
                textInputAction: TextInputAction.next,
                readOnly: false,
                keyboardType: TextInputType.text,
              )
            ],
          ),
          Row(
            children: [
              Text('Customer\nNumber'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter customer number';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: '0101010101',
                textInputAction: TextInputAction.next,
                readOnly: false,
                keyboardType: TextInputType.number,
              )
            ],
          ),
          Row(
            children: [
              Text('Business\nSegment'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter business segment';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: 'Retail',
                textInputAction: TextInputAction.next,
                readOnly: false,
                keyboardType: TextInputType.text,
              )
            ],
          ),
          Row(
            children: [
              Text('Region'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter region';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: 'South',
                textInputAction: TextInputAction.next,
                readOnly: false,
              )
            ],
          ),
          Row(
            children: [
              Text('Area'),
              CallTextField(
                fillColor: Colors.white,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Pls, enter area';
                  }
                  return null;
                },
                onChanged: (value) {},
                hintText: 'IMO',
                textInputAction: TextInputAction.next,
                readOnly: false,
              )
            ],
          ),
      ],),
    );
  }
}

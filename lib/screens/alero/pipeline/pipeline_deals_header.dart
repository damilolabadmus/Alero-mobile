import 'package:flutter/material.dart';

class PipelineDealsHeader extends StatelessWidget {

  final String title;

  PipelineDealsHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 2.0, 15.0, 2.0),
        child: Container(
          padding: EdgeInsets.all(4.0),
          // constraints: BoxConstraints(minWidth: 20, maxWidth:70),
          child: Text(title,style: TextStyle(
            color: Colors.black54,
            fontSize: 9.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins-Regular',
          ),),
        ),
      ),
    );
  }
}

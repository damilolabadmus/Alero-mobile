

import 'package:flutter/material.dart';

class PipelineTabViewIcon extends StatelessWidget {
  Function? onPressed;

  PipelineTabViewIcon({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 2.0, 15.0, 2.0),
          child: Container(
            height: 35,
            width: 50,
            decoration: BoxDecoration(color: Colors.white70,
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                iconSize: 22.0,
                color: Colors.lightBlueAccent,
                onPressed: onPressed as void Function()?,
                icon: Icon(Icons.drive_file_rename_outline_sharp),
              ),
            ),
          )
      ),
    );
  }
}

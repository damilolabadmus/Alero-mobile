import 'package:flutter/material.dart';

class ProspectEditContainer extends StatelessWidget {

  const ProspectEditContainer({Key key,
    this.titleText,
    this.icon,
    this.keyboardType,
    @required this.value,
    @required this.textFormFieldController

  }) : super(key: key);

  final String titleText;
  final String value;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController textFormFieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        color: Colors.grey.shade600,
                        size: 20.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Flexible(
                        child: Container(
                          height: 10,
                          child: TextField(
                            keyboardType: keyboardType,
                            controller: textFormFieldController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

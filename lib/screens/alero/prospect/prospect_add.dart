

import 'package:alero/screens/alero/prospect/prospect_bio_data_input.dart';
import 'package:flutter/material.dart';
import 'package:alero/style/theme.dart' as Style;

class ProspectAdd extends StatefulWidget {

  @override
  _ProspectAddState createState() => _ProspectAddState();
}

class _ProspectAddState extends State<ProspectAdd> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation1;
  late Animation animation2;


  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation2 = ColorTween(begin: Colors.white12, end: Colors.lightBlue).animate(controller);
    controller.forward();


    animation1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Prospects",
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        SizedBox(height: 5.0),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Add new prospect or view existing prospects.',
            style: TextStyle(
              color: Style.Colors.blackTextColor.withOpacity(controller.value),
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),),),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Existing Prospects",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
              ),
            ),
            Container(
              height: 35,
              width: 70,
              decoration: BoxDecoration(color: animation2.value, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 15.0),
                        child: Align(
                            child: Icon(Icons.person_add_alt_rounded, color: Colors.white, size: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text('Add', style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProspectBioDataInput(),),
                    );
                  }
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
      ],
    );
  }
}


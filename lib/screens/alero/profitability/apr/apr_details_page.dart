

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../style/theme.dart' as Style;
import '../../../../utils/Pandora.dart';
import 'apr_bottom_nav_bar.dart';
import 'apr_details_table_container.dart';

class AprDetailsPage extends StatefulWidget {
 final aprDetails;

 AprDetailsPage({this.aprDetails});

  @override
  State<AprDetailsPage> createState() => _AprDetailsPageState();
}

class _AprDetailsPageState extends State<AprDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Apr Details Page',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),),
                    Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Container(
                          width: widget.aprDetails != null ? widget.aprDetails[0].accountName.length > 10 ? 120.0 : null : 0,
                          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text(widget.aprDetails == null ? '' : widget.aprDetails[0].accountName.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins-Regular',
                              ),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis),
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Below shows the details page for the report.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Style.Colors.subBlackTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular',
                    ),),
                ),
                SizedBox(height: 15),
                AprDetailsTableContainer(
                  aprDetails: widget.aprDetails,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      bottomNavigationBar: AprBottomNavigationBar());
  }

  AppBar appBar() => AppBar(
    elevation: 0,
    toolbarHeight: 40,
    backgroundColor: Style.Colors.searchActiveBg,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Icon(
          EvaIcons.arrowBack,
          color: Colors.black,
        ),),
    ),
    actions: [
      Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: GestureDetector(
            onTap: () {
              Pandora.logoutUser(context);
            },
            child: SvgPicture.asset('assets/customer/profile_logout.svg', width: 17),
          )),],
  );
}

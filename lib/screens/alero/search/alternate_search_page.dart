

import 'package:alero/screens/alero/landing/landing_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class AlternateSearchPage extends StatefulWidget {
  AlternateSearchPage({Key? key}) : super(key: key);

  @override
  _AlternateSearchPageState createState() => _AlternateSearchPageState();
}

class _AlternateSearchPageState extends State<AlternateSearchPage> {
  TextEditingController _filterFieldController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
                    child: SvgPicture.asset(
                      'assets/search/alt_search_close.svg',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Find a customer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Poppins-Regular',
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldContainer(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: 23.0,
                ),
                child: TextField(
                  autocorrect: false,
                  controller: _filterFieldController,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Style.Colors.greyTextColor,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    searchAction(value, context);
                  },
                  style: TextStyle(
                      color: Style.Colors.blackTextColor,
                      fontSize: 15.0,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter customer information",
                      hintStyle: TextStyle(
                          fontSize: 10.0,
                          color: Style.Colors.greyTextColor,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w600),
                      suffixIcon: InkWell(
                          onTap: () {
                            searchAction(_filterFieldController.text.toString(),
                                context);
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                  'assets/search/alt_search_button.svg',
                                ),
                              )
                            ],
                          ))),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void searchAction(String searchQuery, BuildContext context) async {
    Navigator.of(context).pushNamed('/search', arguments: searchQuery);
  }
}

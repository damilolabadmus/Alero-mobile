

import 'package:alero/models/performance/CprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/profitability/cpr/search_cpr_page.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class CprSearchField extends StatefulWidget {
  CprSearchField();

  @override
  State<CprSearchField> createState() => _CprSearchFieldState();
}

class _CprSearchFieldState extends State<CprSearchField> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  List<CprResponse> searchedCprData = [];
  bool isSearched = false;

  @override
  void initState() {
    super.initState();
    getCprByCustomerNumber('0168077703');
  }

  Future<List<CprResponse>> getCprByCustomerNumber(
      String customerNumber) async {
    List<CprResponse> _cprData = await apiService.getCprByCustomer(
        customerNumber);
    setState(() {
      searchedCprData = _cprData;
      print('The search cpr = $searchedCprData');
    });
    return searchedCprData;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _filterFieldController = new TextEditingController();
    Size size = MediaQuery
        .of(context)
        .size;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(
              horizontal: Style.Constants.Padding20,
            ),
            width: size.width * 0.5,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                color: Style.Colors.greyForm,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.transparent)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                autocorrect: false,
                controller: _filterFieldController,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Style.Colors.greyTextColor,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                },
                style: TextStyle(
                    color: Style.Colors.subBlackTextColor,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search customer",
                    hintStyle: TextStyle(
                        fontSize: 10.0,
                        color: Style.Colors.greyTextColor,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isSearched = true;
                        });

                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            SearchCprPage(searchedCprData: searchedCprData)));
                        },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0),
                        child: Icon(
                          EvaIcons.searchOutline,
                          color: Style.Colors.buttonColor,
                          size: 18,
                        ),
                      ),
                    )),
              ),
            )),
      ),
    );
  }
}



import 'package:alero/models/performance/AprResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/profitability/apr/search_apr_page.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../style/theme.dart' as Style;

class AprSearchField extends StatefulWidget {
  final Function(bool query) searchAprCallback;

  AprSearchField({required this.searchAprCallback});

  @override
  State<AprSearchField> createState() => _AprSearchFieldState();
}

class _AprSearchFieldState extends State<AprSearchField> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  bool isSearched = false;
  bool dataLoaded = false;
  bool isInitialLoading = true;

  List<AprResponse> aprByAcctNoData = [];
  List<AprResponse> aprByCustomerData = [];

  @override
  void initState() {
    super.initState();
    if (!dataLoaded) {
      fetchData();
    }
    startTimeout();
  }

  void startTimeout() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isInitialLoading) {
        setState(() {
          isInitialLoading = false;
        });
      }
    });
  }

  void fetchData() async {
    try {
      List<Future<List<AprResponse>>> futures = [
        apiService.getAprDataByAccNo('0168077703').timeout(Duration(minutes: 15)),
        apiService.searchAprByCustomer('0168077703').timeout(Duration(minutes: 15)),
      ];

      List<List<AprResponse>> results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          aprByAcctNoData = results[0];
          aprByCustomerData = results[1];

          dataLoaded = true;
          isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isInitialLoading = false;
        });
      }
    }
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
                          widget.searchAprCallback(isSearched);
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            SearchAprPage(searchedAprData: aprByAcctNoData)));
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
              ),)),
      ),
    );
  }
}

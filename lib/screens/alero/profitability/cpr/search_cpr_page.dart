

import 'package:flutter/material.dart';
import '../profitability_app_bar.dart';
import 'cpr_bottom_navigation_bar.dart';
import 'cpr_dashboard_table_container.dart';
import 'cpr_search_field.dart';
import 'package:alero/style/theme.dart' as Style;

class SearchCprPage extends StatefulWidget {
  final searchedCprData;
  bool? isSearched;

  SearchCprPage({Key? key, this.searchedCprData, this.isSearched}) : super(key: key);

  @override
  State<SearchCprPage> createState() => _SearchCprPageState();
}

class _SearchCprPageState extends State<SearchCprPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ProfitabilityAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Searched Customer',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Regular',
                      ),),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Container(
                        width: widget.searchedCprData == null || widget.searchedCprData.isEmpty ? 0 : widget.searchedCprData[0].customerName.length > 12 ? 100.0 : null,
                        padding: EdgeInsets.symmetric(horizontal: 7.0,
                          vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(4.0)),
                        child: Text(widget.searchedCprData == null || widget.searchedCprData.isEmpty ? '' : widget.searchedCprData[0].customerName.toString(),
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
                    'This section shows the customer that matches your search.',
                    style: TextStyle(
                      color: Style.Colors.subBlackTextColor,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular',
                    ),),
                ),
                SizedBox(height: 12),
                CprSearchField(
                    searchCprCallback: (query) {
                      setState(() {
                        widget.isSearched = query;
                      });
                    }
                ),
                SizedBox(height: 12),
                CprDashboardTableContainer(
                  cprData: widget.searchedCprData,
                ),
              ],
            ),
          ),
        ),
      ),
    bottomNavigationBar: CprBottomNavigationBar());
  }
}



/*
class SearchCprPage extends StatefulWidget {
  final searchQuery;
  bool isCustomer;

  SearchCprPage({Key key, @required this.searchQuery, this.isCustomer}) : super(key: key);

  @override
  State<SearchCprPage> createState() => _SearchCprPageState();
}

class _SearchCprPageState extends State<SearchCprPage> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  final AsyncMemoizer _searchMem = AsyncMemoizer();
  List<CustomerList> customerList = [];
  List<Widget> customers = [];

  List<CprResponse> allCprData = [];

  bool foundUser;

  List<Widget> reportData = [];
  List<CprResponse> cprList = [];

  void searchCustomers(List<dynamic> searchResponse) {
    List<dynamic> responseList = searchResponse;
    List<Widget> searchItem = [];
    if (responseList.isEmpty) {
      searchItem.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: EmptyListItem(message: 'No reports Found.'),
      ));
      setState(() {
        foundUser = false;
      });
    } else {
      setState(() {
        foundUser = true;
      });
      responseList.forEach((customer) {
        searchItem.add(
          CprProfitAndLossPage()
        );
        */
/*cprList.add(CustomerList(
          customerId: customer["groupId"],
        ));*//*

      });
    }
    if (mounted) {
      setState(() {
        reportData = searchItem;
      });
    }
  }

  Future searchForCustomer(String searchQuery) async {
    return this._searchMem.runOnce(() async {
      final foundUsers = await apiService.searchForUser(searchQuery);
      searchCustomers(foundUsers);
      return foundUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    // searchForCustomer(widget.searchQuery);
    getAllCprData('012337432');
  }

  Future<List<CprResponse>> getAllCprData(String customerName) async {
    List<CprResponse> _cprData = await apiService.getCprByCustomer(customerName);
    setState(() {
      allCprData = _cprData;
      print('The search cpr = $allCprData');
    });
    return allCprData;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _filterFieldController = new TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
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
                    // searchFilterBy(value);
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
                          // searchFilterBy(_filterFieldController.text.toString());
                          if (_filterFieldController != null) {
                            widget.isCustomer = true;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
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
        ),
        // loadSearchResults()
      ],
    );
  }

  Widget loadSearchResults() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return Expanded(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: CprDashboardTableContainer(
                cprData: allCprData,
                // cprTopData: widget.searchQuery,
              ),
          ),
        );
      },
      // future: getAllCprData('012337432'),
      // future: searchForCustomer(widget.searchQuery),
    );
  }

  void searchFilterBy(String searchedName) {
    List<Widget> searchItem = [];

    for (var customer in customerList) {
      if (customer.customerName
          .toLowerCase()
          .trim()
          .contains(searchedName.toLowerCase().trim())) {
        print(customer.customerId);
        searchItem.add(
          CprDashboardTableContainer(
            cprData: allCprData,
          )
          // SearchItemCard(
          //   press: () {
          //     Navigator.of(context).pushNamed('/customer-profile',
          //         arguments: customer.customerId);
          //   },
          //   customerName: customer.customerName,
          //   customerYears: customer.activeYear,
          //   businessSegment: customer.businessSegment,
          //   active: customer.active,
          // ),
        );
      }
    }

    for (int i = 0; i < customerList.length; i++) {
      if (searchItem.isEmpty && i == 0) {
        setState(() {
          foundUser = false;
        });
        searchItem.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: EmptyListItem(message: 'User not Found'),
        ));
      }
    }
    if (searchItem.length > 0 && foundUser) {
      if (mounted) {
        setState(() {
          customers = searchItem;
        });
      }
    } else {
      print('Nothing picked yet');
    }
  }
}
*/

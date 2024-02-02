

import '../../../models/response/CustomerList.dart';
import '../../../network/AleroAPIService.dart';
import '../../../style/theme.dart' as Style;
import '../../../utils/Pandora.dart';
import 'package:async/async.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/empty_list_item.dart';
import 'search_item.dart';
import 'search_search_field.dart';
import 'shimmer_loading_widget.dart';

class SearchBody extends StatefulWidget {
  final String? searchQuery;
  SearchBody({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBodyState();
  }
}

class _SearchBodyState extends State<SearchBody> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  final AsyncMemoizer _searchMem = AsyncMemoizer();
  late bool foundUser;

  List<Widget> customers = [];
  List<CustomerList> customerList = [];
  int customerCount = 0;

  void searchCustomers(List<dynamic> searchResponse) {
    List<dynamic> responseList = searchResponse;
    List<Widget> searchItem = [];
    if (responseList.isEmpty) {
      searchItem.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: EmptyListItem(message: 'No Users Found'),
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
          SearchItemCard(
            press: () {
              Navigator.of(context).pushNamed('/customer-profile',
                  arguments: customer["groupId"]);
            },
            customerName: customer["customerName"],
            businessSegment: customer["businessSegment"],
            customerYears: customer["customerRelationshipAge"],
            active: (customer["activeStat"] == "Active") ? true : false,
          ),
        );
        customerList.add(CustomerList(
          customerId: customer["groupId"],
          customerName: customer["customerName"],
          activeYear: customer["customerRelationshipAge"],
          businessSegment: customer["businessSegment"],
          active: (customer["activeStat"] == "Active") ? true : false,
        ));
      });
    }
    if (mounted) {
      setState(() {
        customers = searchItem;
        customerCount = customerList.length;
      });
    }
  }

  Future searchForCustomer(String? searchQuery) async {
    return this._searchMem.runOnce(() async {
      final foundUsers = (await apiService.searchForUser(searchQuery!))!;
      searchCustomers(foundUsers);
      return foundUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    searchForCustomer(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _filterFieldController = new TextEditingController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 13.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              (customerCount < 1)
                  ? "Please wait ..."
                  : customerCount.toString() + " matches found",
              style: TextStyle(
                color: Style.Colors.blackTextColor,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
        ),
        TextFieldContainer(
            child: Padding(
              padding: EdgeInsets.only(left: 23.0, right: 15.0),
              child: TextField(
                autocorrect: false,
                controller: _filterFieldController,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Style.Colors.greyTextColor,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  searchFilterBy(value);
                },
                style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 15.0,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Filter with customer’s name or branch",
                    hintStyle: TextStyle(
                        fontSize: 10.0,
                        color: Style.Colors.greyTextColor,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600),
                    suffixIcon: InkWell(
                      onTap: () {
                        searchFilterBy(_filterFieldController.text.toString());
                      },
                      child: Icon(
                        EvaIcons.searchOutline,
                        color: Style.Colors.buttonColor,
                      ),
                    )),
              ),
            )),
        loadSearchResults()
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
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: customers.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            alignment: Alignment.topCenter,
                            child: customers[index]);
                      }),
                ],
              )),
        );
      },
      future: searchForCustomer(widget.searchQuery),
    );
  }

  void searchFilterBy(String searchedName) {
    List<Widget> searchItem = [];

    for (var customer in customerList) {
      if (customer.customerName!
          .toLowerCase()
          .trim()
          .contains(searchedName.toLowerCase().trim())) {
        print(customer.customerId);
        searchItem.add(
          SearchItemCard(
            press: () {
              Navigator.of(context).pushNamed('/customer-profile',
                  arguments: customer.customerId);
            },
            customerName: customer.customerName,
            customerYears: customer.activeYear,
            businessSegment: customer.businessSegment,
            active: customer.active,
          ),
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

/*    if (mounted) {
      setState(() {
        customers = searchItem;
        customerCount = searchItem.length;
      });
    }*/

    if (searchItem.length > 0 && foundUser) {
      if (mounted) {
        setState(() {
          customers = searchItem;
          customerCount = searchItem.length;
        });
      }
    } else {
      Navigator.of(context).pushNamed('/search', arguments: searchedName);
    }
  }
}

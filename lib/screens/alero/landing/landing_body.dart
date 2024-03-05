import 'package:alero/screens/alero/landing/components/bank_performance_items.dart';
import 'package:alero/screens/alero/components/view_customer_dashboard_graphs.dart';
import '../../../network/AleroAPIService.dart';
import '../../../utils/Pandora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../style/theme.dart' as Style;
import '../../../utils/Strings.dart' as Strings;
import 'landing_search_field.dart';

class LandingBody extends StatefulWidget {
  final String rmName;

  const LandingBody({Key? key, required this.rmName}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LandingBodyState();
  }
}

class _LandingBodyState extends State<LandingBody> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  late String firstName;
  TextEditingController searchFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        firstName = widget.rmName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        _buildHeader(screenHeight),
        _bankItems(screenHeight),
      ],
    );
  }


  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Style.Colors.searchActiveBg,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Column(
            children: [
              Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: new Text(
                        "Hello $firstName!",
                        style: TextStyle(
                          color: Style.Colors.blackTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextFieldContainer(
                child: TextField(
                  expands: false,
                  autocorrect: false,
                  textAlign: TextAlign.start,
                  controller: searchFieldController,
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
                      fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Customer',
                    hintStyle: TextStyle(color: Style.Colors.grey,
                      fontFamily: 'Poppins-Regular'),
                    prefixIcon: Icon(
                      EvaIcons.searchOutline,
                      color: Style.Colors.buttonColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (searchFieldController.text.trim().isNotEmpty) {
                        searchAction(searchFieldController.text, context);
                      } else {
                        pandora.showToast(Strings.Errors.searchFieldError, context,
                            MessageTypes.WARNING.toString().split('.').last);
                      }},
                    style: ElevatedButton.styleFrom(
                      primary: Style.Colors.buttonColor,
                      fixedSize: Size(80.0, 30),
                    ),
                    child: Text("Find", style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  SliverToBoxAdapter _bankItems(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        color: Style.Colors.chartBackground,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Dashboard',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),),
                ),
              ),
              BankPerformanceItems(),
              SizedBox(height: 10),
              ViewCustomerDashboardGraphs(),
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

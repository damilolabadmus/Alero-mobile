

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/back_app_bar.dart';
import 'search_body.dart';

class SearchPage extends StatelessWidget {
  final String? searchQuery;

  SearchPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
          header: "Search Result",
          press: () {
            Navigator.pop(context, false);
            return Future.value(false);
            /*Navigator.of(context).pushNamedAndRemoveUntil(
                '/landing', (Route<dynamic> route) => false);*/
          }),
      backgroundColor: Colors.white,
      body: SearchBody(
        searchQuery: searchQuery,
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      onTap: (int index) {
        moreSearchResults(index);
      },
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/search/search_list_back_new.svg',
              ),
            ),
          ),
          //label: "",
        ),
        BottomNavigationBarItem(
          icon: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/search/search_list_forward_new.svg',
              ),
            ),
          ),
          //label: "",
        )
      ],
    );
  }

  void moreSearchResults(int index) {
    switch (index) {
      case 0:
        print('previous');
        break;
      case 1:
        print('next');
        break;
    }
  }
}

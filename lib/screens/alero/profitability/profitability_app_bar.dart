import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/profitability/profitability_reports_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';
import '../../../style/theme.dart' as Style;

class ProfitabilityAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Style.Colors.searchActiveBg,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfitabilityReportsPage(userId: '')));
        },
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Icon(
            EvaIcons.arrowBack,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: GestureDetector(
              onTap: () {
                logoutUser(context);
              },
              child: SvgPicture.asset(
                'assets/customer/profile_logout.svg',
                width: 17,
              ),
            )
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  void logoutUser(BuildContext context) async {
    var apiService = AleroAPIService();
    var response;
    OneContext().showProgressIndicator();
    try {
      OneContext().hideProgressIndicator();
      response = await apiService.logoutUser();
      if (response != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        OneContext().hideProgressIndicator();
      }
    } catch (error) {
      print(error);
      OneContext().hideProgressIndicator();
    }
  }
}

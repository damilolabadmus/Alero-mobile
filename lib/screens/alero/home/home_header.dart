

import 'package:alero/network/AleroAPIService.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_context/one_context.dart';

class ItemModel {
  String title;
  IconData icon;
  ItemModel(this.title, this.icon);
}

class HomeHeader extends StatelessWidget {
  List<ItemModel> menuItems = [
    ItemModel('Logout', EvaIcons.lockOutline),
  ];

  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(),
        // ,
        CustomPopupMenu(
          child: Container(
            child: SvgPicture.asset('assets/icons/profile-user.svg',width: 30,height: 30,),
          ),
          menuBuilder: () => ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: const Color(0xFFE74C3C),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: menuItems
                      .map(
                        (item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            var apiService = AleroAPIService();
                            var response;
                            OneContext().showProgressIndicator();
                            try {
                              OneContext().hideProgressIndicator();
                              response = await apiService.logoutUser();
                              if (response != null) {
                                _controller.hideMenu;
                                Phoenix.rebirth(context);
                                OneContext().hideProgressIndicator();
                              }
                            } catch (error) {
                              print(error);
                              OneContext().hideProgressIndicator();
                            }
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  item.icon,
                                  size: 15,
                                  color: Colors.blue,
                                  // color: Colors.white,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        // color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          pressType: PressType.singleClick,
          verticalMargin: -9,
          controller: _controller,
        ),
      ],
    );
  }
}

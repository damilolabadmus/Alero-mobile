import '../../../style/theme.dart' as Style;
import 'package:flutter/material.dart';

class SearchItemCard extends StatelessWidget {
  const SearchItemCard(
      {Key key,
        this.customerName,
        this.businessSegment,
        this.customerYears,
        this.active,
        this.press})
      : super(key: key);

  final String customerName;
  final int customerYears;
  final String businessSegment;
  final bool active;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        color: Style.Colors.overviewCardBg,
        elevation: 0,
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: active
                        ? Style.Colors.overviewActiveBg
                        : Style.Colors.searchInActiveBgLeading,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                    border: Border.all(
                        color: active
                            ? Style.Colors.overviewActiveBg
                            : Style.Colors.searchInActiveBgLeading)),
                child: SizedBox(
                  width: 8,
                  height: 8,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(
                          customerName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Style.Colors.blackTextColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Bold',
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          businessSegment,

                          /// "Customer for $customerYears year's",
                          style: TextStyle(
                            color: Style.Colors.subBlackTextColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: active
                                  ? Style.Colors.searchActiveBg
                                  : Style.Colors.searchInActiveBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: active
                                      ? Style.Colors.searchActiveBg
                                      : Style.Colors.searchInActiveBg)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 6, top: 2, right: 6, bottom: 2),
                            child: Text(
                              active ? 'active' : 'inactive',
                              style: TextStyle(
                                color: active
                                    ? Style.Colors.searchActiveBgText
                                    : Style.Colors.searchInActiveBgText,
                                fontSize: 9.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

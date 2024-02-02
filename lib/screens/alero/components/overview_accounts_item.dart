

import 'package:alero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import '../../../style/theme.dart' as Style;
import 'package:intl/intl.dart';

class AccountsCardItem extends StatelessWidget {
  final String? accountNumber, accountType, currency;
  final double? amount;

  const AccountsCardItem(
      {Key? key,
        this.accountNumber,
        this.accountType,
        this.amount,
        this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: "");

    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/customer/overview/overview_card.png'),
                )),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(accountNumber!,
                            style: TextStyle(
                              color: Style.Colors.overviewTextGrey,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Bold',
                            )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(accountType!.toUpperCase(),
                            softWrap: true,
                            style: TextStyle(
                              color: Style.Colors.overviewTextDarkGrey,
                              fontSize: 8.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins-Regular',
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: currency!.toUpperCase() == 'NGN'
                          ? Text("₦ " + formatCurrency.format(amount),
                          style: kCurrencyStyle)
                          : currency!.toUpperCase() == 'USD'
                          ? Text("\$ " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'CAD'
                          ? Text("\$ " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'EUR'
                          ? Text("\€ " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'CNY'
                          ? Text("\¥ " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'CHF'
                          ? Text("CHF " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'GBP'
                          ? Text("\£ " + formatCurrency.format(amount),
                          style: kCurrencyStyle) : currency!.toUpperCase() == 'ZAR'
                          ? Text("R " + formatCurrency.format(amount),
                          style: kCurrencyStyle)
                          : Text(/*"\₦ "*/ "\$ "+ formatCurrency.format(amount),
                          style: kCurrencyStyle))
                ],
              ),
            )));
  }
}

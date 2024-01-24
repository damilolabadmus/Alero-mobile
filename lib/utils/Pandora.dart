import 'dart:io';

import 'package:date_time_format/date_time_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Global.dart';

class Pandora {
  //Snackbar Conditions
  void showToast(String message, BuildContext context, String messageType) {
    print(messageType);
    switch (messageType) {
      case "SUCCESS":
        displayToast(message, context, Colors.green);
        break;
      case "FAILED":
        displayToast(message, context, Colors.red);
        break;
      case "WARNING":
        displayToast(message, context, Colors.orangeAccent);
        break;
      case "INFO":
        displayToast(message, context, Colors.black54);
        break;
    }
  }

  //Snackbar Renderer
  void displayToast(String message, BuildContext context, Color color) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                EvaIcons.alertCircleOutline,
                color: Colors.white,
              ),
              Text(message,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Regular',
                  )),
            ],
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  //Internet Connection manager
  Future<bool> hasInternet() async {
    bool hasInternet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
      }
    } on SocketException catch (_) {
      hasInternet = false;
    }
    return hasInternet;
  }

  /*static String moneyFormat1(double price) {
    String currency;
    final formatCurrency = new NumberFormat.currency(
        decimalDigits: 2, name: "", locale: "en_ZA");
    if (price > 1000) return currency = formatCurrency.format(price).toString();
    return currency = price.toString();
  }*/


/*
static String moneyFormat2(double price) {
  String currency;
    // final formatCurrency = new NumberFormat('##,###,###.0#', 'en_ZA');
    final formatCurrency = new NumberFormat('#,##0.00', 'en_ZA');
    if (price > 1000) return currency = formatCurrency.format(price).toString();
    return currency = price.toString();
}
*/


  /*static String moneyFormat3(double price) {
    String thousandsSeparator = ',';
    String decimalSeparator = '.';
    String formatString = '#,##0.00';

    formatString = formatString.replaceAll(',', thousandsSeparator);
    formatString = formatString.replaceAll('.', decimalSeparator);

    NumberFormat formatter = NumberFormat(formatString);
    return formatter.format(price);
  }*/

  static String dynamicMoneyFormat(dynamic value) {
    if (value is num) {
      String thousandsSeparator = ',';
      String decimalSeparator = '.';
      String formatString = '#,##0.00';

      bool isNegative = false;
      if (value < 0) {
        isNegative = true;
        value = -value;
      }

      formatString = formatString.replaceAll(',', thousandsSeparator);
      formatString = formatString.replaceAll('.', decimalSeparator);

      NumberFormat formatter = NumberFormat(formatString);
      String formattedValue = formatter.format(value);

      if (isNegative) {
        formattedValue = '-$formattedValue';
      }

      return formattedValue;
    } else {
      return value;
      // return 'Invalid Input;
    }
  }

  static String moneyFormat(double price) {
    String thousandsSeparator = ',';
    String decimalSeparator = '.';
    String formatString = '#,##0.00';

    bool isNegative = false;
    if (price < 0) {
      isNegative = true;
      price = -price;
    }

    formatString = formatString.replaceAll(',', thousandsSeparator);
    formatString = formatString.replaceAll('.', decimalSeparator);

    NumberFormat formatter = NumberFormat(formatString);
    String formattedPrice = formatter.format(price);

    if (isNegative) {
      formattedPrice = '-$formattedPrice';
    }
    return formattedPrice;
  }


  static String dateFormat(DateTime date) {
    var processedDate =
    DateTimeFormat.format(date, format: DateTimeFormats.americanAbbr);
    return processedDate = processedDate.substring(0, processedDate.length - 8);
  }

  static String keyItemFormat(String value) {
    String modifiedString;
    int firstSpaceIndex = value.indexOf(' ');
    int secondSpaceIndex = value.indexOf(' ', firstSpaceIndex + 1);
    if (secondSpaceIndex != -1) {
      modifiedString = value.replaceRange(secondSpaceIndex, secondSpaceIndex + 1, '\n');
      print('The modifiedString = $modifiedString');
    } else {
      print("String doesn't contain a second space.");
    }
}

  static String replaceUnderscoreFormat(String value) {
    String combinedValue;
    combinedValue = value.replaceAll('_', ' ');
    return combinedValue;
  }

  static String replaceHyphenFormat(String input) {
    String modifiedString;
    if (input != null) {
      modifiedString = input.replaceAll('-', '');
      return modifiedString;
    } else {
      return input;
    }
  }

  Future<void> saveToSharedPreferences(String key, String value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<String> getFromSharedPreferences(String key) async {
    var pref = await SharedPreferences.getInstance();
    var value = pref.getString(key) ?? '';
    return value;
  }

  static String reverse(String s) {
    if (s.isNotEmpty) {
      return s.split('').reversed.join('');
    }
    return s;
  }

  static String getStringsAfter(String s, int subString) {
    if (s.isNotEmpty) {
      return s.substring(subString);
    }
    return s;
  }

  logFirebaseEvent(String action, String endpoint, String event) {
    GetIt.I<FirebaseAnalytics>().logEvent(
      name: Global.USER_NAME,
      parameters: <String, dynamic>{
        // 'device_name': Global.DeviceName,
        'action': action,
        'endpoint': endpoint,
        'event': event,
      },
    );
  }
}

enum MessageTypes { SUCCESS, FAILED, WARNING, INFO }
enum ExceptionTypes { NODATAEXCEPTION, UNKNOWN, WARNING, INFO }


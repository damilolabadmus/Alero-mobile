import 'dart:io';
import 'package:date_time_format/date_time_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/AleroAPIService.dart';
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
    final scaffold = ScaffoldMessenger.of(context);
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
      return value ?? "";
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
  static String itemsFormat(double input) {
    int inputValue = input.toInt();
    if (inputValue >= 1000000000 && inputValue < 10000000000) {
      return '₦ ${(inputValue / 1000000000).toStringAsFixed(1)} b';
    } else if (inputValue >= 10000000000 && inputValue < 1000000000000) {
      return '₦ ${(inputValue / 1000000000).toStringAsFixed(0)} b';
    } else if (inputValue >= 1000000000000 && inputValue < 10000000000000) {
      return '₦ ${(inputValue / 1000000000000).toStringAsFixed(1)} t';
    } else if (inputValue >= 10000000000000) {
      return '₦ ${(inputValue / 1000000000000).toStringAsFixed(0)} t';
    } else if (inputValue >= 1000000 && inputValue < 10000000) {
      return '₦ ${(inputValue / 1000000).toStringAsFixed(1)} m';
    } else if (inputValue >= 10000000 && inputValue < 1000000000) {
      return '₦ ${(inputValue / 1000000).toStringAsFixed(0)} m';
    } else if (inputValue >= 1000 && inputValue < 1000000) {
      return '₦ ${(inputValue).toStringAsFixed(0)}';
    } else if (inputValue >= 1000000000000000) {
      return '₦ ${(inputValue / 1000000000000000).toStringAsFixed(1)} q';
    } else {
      return '₦ $inputValue';
    }
  }
  static String chartValueFormat(double input) {
    double inputValue = input.toDouble();
    if (inputValue >= 1000000000 && inputValue < 10000000000) {
      return '${(inputValue / 1000000000).toStringAsFixed(2)} b';
    } else if (inputValue >= 10000000000 && inputValue < 1000000000000) {
      return '${(inputValue / 1000000000).toStringAsFixed(2)} b';
    } else if (inputValue >= 1000000000000 && inputValue < 10000000000000) {
      return '${(inputValue / 1000000000000).toStringAsFixed(2)} t';
    } else if (inputValue >= 10000000000000) {
      return '${(inputValue / 1000000000000).toStringAsFixed(2)} t';
    } else if (inputValue >= 1000000 && inputValue < 10000000) {
      return '${(inputValue / 1000000).toStringAsFixed(2)} m';
    } else if (inputValue >= 10000000 && inputValue < 1000000000) {
      return '${(inputValue / 1000000).toStringAsFixed(2)} m';
    } else if (inputValue >= 1000 && inputValue < 1000000) {
      return '${(inputValue).toStringAsFixed(2)}';
    } else if (inputValue >= 1000000000000000) {
      return '${(inputValue / 1000000000000000).toStringAsFixed(2)} q';
    } else {
      return '$inputValue';
    }
  }
  static double chartItemFormat(double input) {
    double inputValue = input.toDouble();
    return (inputValue / 1000000000000) * 5;
  }
  static double chartItemFormat2(double input) {
    double inputValue = input.toDouble();
    return (inputValue / 10000000000000) * 10;
  }
  static double chartItemFormat3(double input) {
    double inputValue = input.toDouble();
    return (inputValue / 1000000000000) * 10;
  }
  static String dateFormat(DateTime date) {
    var processedDate =
    DateTimeFormat.format(date, format: DateTimeFormats.americanAbbr);
    return processedDate = processedDate.substring(0, processedDate.length - 8);
  }
  static String? keyItemFormat(String value) {
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
  static String? replaceHyphenFormat(String? input) {
    String modifiedString;
    if (input != null) {
      modifiedString = input.replaceAll('-', '');
      return modifiedString;
    } else {
      return input;
    }
  }
  /// Format month
  static String formatMonthKey(String monthKey) {
    DateTime date = DateTime.parse(monthKey.substring(0, 4) +
        '-' +
        monthKey.substring(4, 6) +
        '-01');
    return '\n${DateFormat.MMM().format(date)} ${DateFormat('y').format(date)}';
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
  static logoutUser(BuildContext context) async {
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
  logFirebaseEvent(String action, String endpoint, String event) {
    GetIt.I<FirebaseAnalytics>().logEvent(
      name: Global.USER_NAME!,
      parameters: <String, dynamic>{
        'device_name': Global.DeviceName,
        'action': action,
        'endpoint': endpoint,
        'event': event,
      },
    );
  }
}
enum MessageTypes { SUCCESS, FAILED, WARNING, INFO }
enum ExceptionTypes { NODATAEXCEPTION, UNKNOWN, WARNING, INFO }
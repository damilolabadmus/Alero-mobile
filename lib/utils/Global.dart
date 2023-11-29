import 'dart:async';

class Global {
  static String InitialBaseUrl = 'https://utrack.unionbankng.com/api';
  static String PresentBaseUrl = 'https://172.16.11.179:8300/api';
  // static String BaseUrl = 'https://172.16.11.179:4443/api'; /// Alero test
  static String BaseUrlTest = 'http://172.16.11.179/AleroTest/api';
  static String API_TOKEN = '';
  static String API_TOKEN2 = '';

  static String PREF_TOKEN = '';
  static String PREF_TOKEN2 = '';
  static bool isLoggedIn = false;
  static String USER_NAME;
  static bool isRM = false;
  static var STAFF_INFORMATION = null;
  static String AppId;
  static String DeviceIp;
  static String DeviceManufacturer;
  static String DeviceName;
  static String DeviceType;
  static String DeviceModel;
  static int APP_TIMEOUT = 10;
  static Timer timer;
}

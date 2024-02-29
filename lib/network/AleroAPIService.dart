import 'dart:convert';
import 'dart:io';
import 'package:alero/models/call/BankSegmentDetailsResponse.dart';
import 'package:alero/models/call/CurrencyDetailsResponse.dart';
import 'package:alero/models/call/DealHistoryResponse.dart';
import 'package:alero/models/call/DealsByCurrencyResponse.dart';
import 'package:alero/models/call/DealsByProductTypeResponse.dart';
import 'package:alero/models/call/DealsByProductsResponse.dart';
import 'package:alero/models/call/DealsItemsResponse.dart';
import 'package:alero/models/call/DealsStatusResponse.dart';
import 'package:alero/models/call/ProductTypeDetailsResponse.dart';
import 'package:alero/models/call/RevenueDetailsResponse.dart';
import 'package:alero/models/call/TurnaroundTimeCompletedResponse.dart';
import 'package:alero/models/call/UpdateStatusDetailsResponse.dart';
import 'package:alero/models/call/ProspectDetailsResponse.dart';
import 'package:alero/models/customer/BankDepositsData.dart';
import 'package:alero/models/customer/BankLoanData.dart';
import 'package:alero/models/customer/BankRevenueData.dart';
import 'package:alero/models/customer/CompletenessAndValidityData.dart';
import 'package:alero/models/customer/LoanClassificationStatus.dart';
import 'package:alero/models/customer/TouchPointData.dart';
import 'package:alero/models/landing/view_modules_response.dart';
import 'package:alero/models/response/ExpenseList.dart';
import 'package:alero/models/response/login_response.dart';
import 'package:alero/utils/Pandora.dart';
import 'package:http/io_client.dart';
import '../models/customer/CustomerDetailsResponse.dart';
import '../models/customer/DataExceptionResponse.dart';
import '../models/customer/RevenueDataResponse.dart';
import '../models/landing/GetStaffInformation.dart';
import '../models/landing/view_status_response.dart';
import '../models/search/SearchUserResponse.dart';
import '../utils/Global.dart';

class AleroAPIService {
  final ioc = new HttpClient();
  final Pandora pandora = new Pandora();
  Map<String, dynamic>? responseMap;
  String? tokenValue;

  var preAuthHeaders = {
    "content-type": "application/json",
    "accept": "application/json",
    "AppId": Global.AppId!,
    "DeviceIp": Global.DeviceIp!,
    "DeviceManufacturer": Global.DeviceManufacturer!,
    "DeviceName": Global.DeviceName!,
    "DeviceModel": Global.DeviceModel!,
    "DeviceType": Global.DeviceType!
  };

  Map<String, String> postAuthHeaders(String token) {
    final headers = <String, String>{
      "content-type": "application/json",
      "accept": "application/json",
      // "Authorization": "Bearer " + Global.API_TOKEN,
      'Authorization': 'Bearer $token',
      "AppId": Global.AppId!,
      "DeviceIp": Global.DeviceIp!,
      "DeviceManufacturer": Global.DeviceManufacturer!,
      "DeviceModel": Global.DeviceModel!,
      "DeviceName": Global.DeviceName!,
      "DeviceType": Global.DeviceType!
      // Add other headers if needed
    };
    return headers;
  }


  /// Login user with email and password
  Future<LoginResponse?> loginUser(String email, String password) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.post(Uri.parse(Global.InitialBaseUrl + '/token'),
          headers: preAuthHeaders,
          body: json.encode({"username": email, "password": password}));
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        print('failed to reach server');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('LOGIN', '/token', exception.toString());
    } catch (error) {
      pandora.logFirebaseEvent('LOGIN', '/token', error.toString());
      throw Exception(error);
    }
    return null;
  }

  /// Present login User with email and password
  Future<LoginResponseForPm?> presentLoginUser(String email, String password) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.post(Uri.parse(Global.PresentBaseUrl + '/token'),
          headers: preAuthHeaders,
          body: json.encode({"username": email, "password": password}));
      responseMap = json.decode(response.body);
      tokenValue = responseMap!['token'];
      print('ARE YOU SURE THERES PANDORA PM TOKEN $tokenValue');
      pandora.saveToSharedPreferences('token', tokenValue!);
      if (response.statusCode == 200) {
        return LoginResponseForPm.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        print('failed to reach pm server');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('LOGIN', '/token', exception.toString());
    } catch (error) {
      pandora.logFirebaseEvent('LOGIN', '/token', error.toString());
      throw Exception(error);
    }
    return null;
  }

/// Login user to generate token for Performance management
 Future<LoginResponseForPm?> loginUserForPm(String email, String password) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.post(Uri.parse(Global.BaseUrlTest + '/token'),
          headers: preAuthHeaders,
          body: json.encode({"username": email, "password": password}));
      responseMap = json.decode(response.body);
      tokenValue = responseMap!['token'];
      pandora.saveToSharedPreferences('token', tokenValue!);
      if (response.statusCode == 200) {
        return LoginResponseForPm.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent('LOGIN', '/token', response.body);
        print('failed to reach pm server');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('LOGIN', '/token', exception.toString());
    } catch (error) {
      pandora.logFirebaseEvent('LOGIN', '/token', error.toString());
      throw Exception(error);
    }
    return null;
  }

  Future<dynamic> logoutUser() async {
    print('Logging out User ');
    print(Global.PREF_TOKEN);
    var logOutHeaders = {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": 'Bearer ' + Global.PREF_TOKEN!,
      "AppId": Global.AppId!,
      "DeviceIp": Global.DeviceIp!,
      "DeviceManufacturer": Global.DeviceManufacturer!,
      "DeviceName": Global.DeviceName!,
      "DeviceModel": Global.DeviceModel!,
      "DeviceType": Global.DeviceType!
    };
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/aleroUserMgt/logout'),
        headers: logOutHeaders,
      );
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent(
            'LOGOUT', '/aleroUserMgt/logout', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent(
            'LOGOUT', '/aleroUserMgt/logout', response.body);
        print('failed to reach server');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent(
          'LOGOUT', '/aleroUserMgt/logout', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'LOGOUT', '/aleroUserMgt/logout', error.toString());
      throw Exception(error);
    }
  }

  /// Check if user is RM
  Future<ViewStatusResponse> getUserStatus() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/view-status-val'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        return ViewStatusResponse.fromJson(jsonDecode(response.body));
      } else {
        pandora.logFirebaseEvent(
            'GET_USER_STATUS', '/view-status-val', response.body);
        throw Exception('Failed to load RM Status');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent(
          'GET_USER_STATUS', '/view-status-val', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_USER_STATUS', '/view-status-val', error.toString());
      throw Exception(error);
    }
  }

  /// Check if user is can view each of the modules
  Future<ViewModulesResponse> getUserAuthorization() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/aleroUserMgt/getUserPlatformRights'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        return ViewModulesResponse.fromJson(jsonDecode(response.body));
      } else {
        pandora.logFirebaseEvent(
            'GET_USER_MODULE_AUTHORIZATION', '/aleroUserMgt/getUserPlatformRights', response.body);
        throw Exception('Failed to load RM Authorization for Modules.');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent(
          'GET_USER_MODULE_AUTHORIZATION', '/aleroUserMgt/getUserPlatformRights', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_USER_MODULE_AUTHORIZATION', '/aleroUserMgt/getUserPlatformRights', error.toString());
      throw Exception(error);
    }
  }

  /// Get staff details
  Future<GetStaffInformation> getStaffInformation() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/userName'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        return GetStaffInformation.fromJson(jsonDecode(response.body));
      } else {
        pandora.logFirebaseEvent(
            'GET_STAFF_INFORMATION', '/userName', response.body);
        throw Exception('Failed to load staff details');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent(
          'GET_STAFF_INFORMATION', '/userName', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_STAFF_INFORMATION', '/userName', error.toString());
      throw Exception(error);
    }
  }

  /// Search for Customer
  Future<List<dynamic>?> searchForUser(String searchQuery) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    print(Global.API_TOKEN!);
    final http = new IOClient(ioc);
    try {
      var response = await http.get(
          Uri.parse(Global.InitialBaseUrl + '/customer-details/$searchQuery'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        if (jsonDecode(response.body) is List) {
          return jsonDecode(response.body);
        } else {
          List<dynamic> myResponse = [];
          var staffInfo =
          SearchUserResponse.fromJson(jsonDecode(response.body));
          Map<String, dynamic> item = {
            'groupId': staffInfo.groupId,
            'customerId': staffInfo.customerId,
            'customerName': staffInfo.customerName,
            'depositBalance': staffInfo.depositBalance,
            'loanBalance': staffInfo.loanBalance,
            'ytdRevenue': staffInfo.ytdRevenue,
            'prevMonthRevenue': staffInfo.prevMonthRevenue,
            'customerRelationshipAge': staffInfo.customerRelationshipAge,
            'businessSegment': staffInfo.businessSegment,
            'subBusinessSegment': staffInfo.subBusinessSegment,
            'rmCode': staffInfo.rmCode,
            'rmName': staffInfo.rmName,
            'activeStat': staffInfo.activeStat,
          };
          myResponse.add(item);
          return (myResponse);
        }
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'SEARCH_FOR_USER', '/customer-details/$searchQuery', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('SEARCH_FOR_USER',
          '/customer-details/$searchQuery', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent('SEARCH_FOR_USER',
          '/customer-details/$searchQuery', error.toString());
      return [];
    }
    return null;
  }

  /// Get customer details
  Future<CustomerDetailsResponse> getCustomerDetails(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/customer-data/$groupId'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        return CustomerDetailsResponse.fromJson(jsonDecode(response.body));
      } else {
        pandora.logFirebaseEvent(
            'GET_CUSTOMER_DETAILS', '/customer-data/$groupId', response.body);
        throw Exception('Failed to load customer details');
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_CUSTOMER_DETAILS',
          '/customer-data/$groupId', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_CUSTOMER_DETAILS', '/customer-data/$groupId', error.toString());
      throw Exception(error);
    }
  }


  /// Search (filter) and Get prospect
  getProspects() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getProspects/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        ProspectDetailsResponse prospect = ProspectDetailsResponse.fromJson(jsonDecode(response.body));
        print("The prospect =  $prospect");
        return prospect;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PROSPECTS', '/callManagement/getProspects/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PROSPECTS',
          '/callManagement/getProspects/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PROSPECTS', '/callManagement/getProspects/', error.toString());
      throw Exception(error);
    }
  }

  /// Get prospect business SegmentS
  getProspectBusinessSegments() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getBankSegments/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        print("Bank Segments");
        BankSegmentDetailsResponse bankSegments = BankSegmentDetailsResponse.fromJson(jsonDecode(response.body));
        print('The bank segments =  ${bankSegments.result}');
        List<String> result = [];
        for(var item in bankSegments.result!){
          result.add(item.segment!);
        }
        return result;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PROSPECT_BUSINESS_SEGMENTS', '/callManagement/getBankSegments/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PROSPECT_BUSINESS_SEGMENTS',
          '/callManagement/getBankSegments/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PROSPECT_BUSINESS_SEGMENTS', '/callManagement/getBankSegments/', error.toString());
      throw Exception(error);
    }
  }

  /// Add a Prospect
  Future<ProspectDetailsResponse?> addProspect(dynamic prospectData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.post(Uri.parse(Global.InitialBaseUrl + '/callManagement/addProspect'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(prospectData));
      if (response.statusCode == 200) {
        return ProspectDetailsResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('ADD_PROSPECT', '/callManagement/addProspect', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent('ADD_PROSPECT', '/callManagement/addProspect', response.body);
        print('failed to reach server1 ${response.statusCode}${response.body}');
      }
    }  catch (error) {
      pandora.logFirebaseEvent('ADD_PROSPECT', '/callManagement/addProspect', error.toString());
      throw error;
    }
    return null;
  }

  /// Edit prospect
  Future<ProspectDetailsResponse?> updateProspect(Map prospectData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.put(Uri.parse(Global.InitialBaseUrl + '/callManagement/editProspect/'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(prospectData));
      if (response.statusCode == 200) {
        return ProspectDetailsResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        print('failed to reach server1 ${response.statusCode}${response.body}');
        pandora.logFirebaseEvent('EDIT_PROSPECT',
            '/callManagement/editProspect/', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent(
            'EDIT_PROSPECT', '/callManagement/editProspect/', response.body);
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('EDIT_PROSPECT', '/callManagement/editProspect', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent('EDIT_PROSPECT', '/callManagement/editProspect', error.toString());
      throw Exception(error);
    }
    return null;
  }


  /// Delete prospect
  deleteProspect(dynamic prospectData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.put(
          Uri.parse(Global.InitialBaseUrl + '/callManagement/editProspect/'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(prospectData));
      if (response.statusCode == 200) {
        return ProspectDetailsResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('DELETE_PROSPECT',
            '/callManagement/editProspect/', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent(
            'DELETE_PROSPECT', '/callManagement/editProspect/', response.body);
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('DELETE_PROSPECT', '/callManagement/editProspect', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent('DELETE_PROSPECT', '/callManagement/editProspect', error.toString());
      throw Exception(error);
    }
  }


  /// Get customer data exceptions
  Future<DataExceptionResponse> getCustomerDataExceptions(
      String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(
          Uri.parse(Global.InitialBaseUrl + '/customer-data-exceptions/$groupId'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        return DataExceptionResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_CUSTOMER_DETAILS', '/customer-data/$groupId', response.body);
        throw Exception(ExceptionTypes.NODATAEXCEPTION);
      } else {
        pandora.logFirebaseEvent(
            'GET_CUSTOMER_DETAILS', '/customer-data/$groupId', response.body);
        throw Exception(ExceptionTypes.UNKNOWN);
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_CUSTOMER_DATA_EXCEPTION',
          '/customer-data-exceptions/$groupId', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent('GET_CUSTOMER_DATA_EXCEPTION',
          '/customer-data-exceptions/$groupId', error.toString());
      throw Exception(error);
    }
  }

  /// Get customer banking data
  Future<List<dynamic>> getBankingData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-banking-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        print('Error 1');
        pandora.logFirebaseEvent('GET_CUSTOMER_BANKING_DATA',
            '/customer-banking-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      print('Error 2');
      pandora.logFirebaseEvent('GET_CUSTOMER_BANKING_DATA',
          '/customer-banking-data/$groupId', response.body);
      return [];
    } else {
      print('Error 3');
      pandora.logFirebaseEvent('GET_CUSTOMER_BANKING_DATA',
          '/customer-banking-data/$groupId', response.body);
      return [];
    }
  }

  /// Get revenue data
  Future<RevenueDataResponse> getRevenueData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-revenue-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      return RevenueDataResponse.fromJson(jsonDecode(response.body));
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_REVENUE_DATA',
          '/customer-revenue-data/$groupId', response.body);
      throw Exception('Failed to load customer revenue data');
    }
  }

  /// Get revenue data for each customer account
  Future<RevenueDataResponse> getRevenueAccountData(String accountNo) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/account-revenue-data-with-accno/$accountNo'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      return RevenueDataResponse.fromJson(jsonDecode(response.body));
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_ACCOUNT_REVENUE_DATA',
          '/account-revenue-data-with-accno/$accountNo', response.body);
      throw Exception('Failed to load customer revenue data');
    }
  }

  /// Get investment data
  Future<List<dynamic>> getCustomerInvestmentData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-investment-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
            '/customer-investment-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
          '/customer-investment-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
          '/customer-investment-data/$groupId', response.body);
      return [];
    }
  }

  /// Get investment data with account number
  Future<List<dynamic>> getCustomerInvestmentDataWithAccountNo(String customerAccountNo) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-investment-data-with-accno/$customerAccountNo'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
            '/customer-investment-data-with-accno/$customerAccountNo', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
          '/customer-investment-data-with-accno/$customerAccountNo', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_INVESTMENT_DATA',
          '/customer-investment-data-with-accno/$customerAccountNo', response.body);
      return [];
    }
  }

  /// Get PND data
  Future<List<dynamic>> getPNDData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-pnd-details/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent(
            'GET_PND_DATA', '/customer-pnd-details/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent(
          'GET_PND_DATA', '/customer-pnd-details/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent(
          'GET_PND_DATA', '/customer-pnd-details/$groupId', response.body);
      return [];
    }
  }

  /// Get PND data with account number
Future<List<dynamic>> getPNDWithAccountNo(String accountNumber) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-pnd-details-with-accno/$accountNumber'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent(
            'GET_PND_DATA_WITH_ACCOUNT_NO', '/customer-pnd-details-with-accno/$accountNumber', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent(
          'GET_PND_DATA_WITH_ACCOUNT_NO', '/customer-pnd-details-with-accno/$accountNumber', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent(
          'GET_PND_DATA_WITH_ACCOUNT_NO', '/customer-pnd-details-with-accno/$accountNumber', response.body);
      return [];
    }
  }

  /// Get debit card data
  Future<List<dynamic>> getDebitCardData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-debitcard-details/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_DEBIT_CARD_DATA',
            '/customer-debitcard-details/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_DEBIT_CARD_DATA',
          '/customer-debitcard-details/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_DEBIT_CARD_DATA',
          '/customer-debitcard-details/$groupId', response.body);
      return [];
    }
  }

  /// Get Channels Data
  Future<List<dynamic>> getChannelsData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-channel-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CHANNEL_DATA',
            '/customer-channel-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CHANNEL_DATA',
          '/customer-channel-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CHANNEL_DATA',
          '/customer-channel-data/$groupId', response.body);
      return [];
    }
  }

 /// Get Channels Data With Account Number
  Future<List<dynamic>> getChannelsDataWithAccountNo(String accountNo) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-channel-enrolments-with-accno/$accountNo'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CHANNEL_DATA_WITH_ACCOUNT_NUMBER',
            '/customer-channel-enrolments-with-accno/$accountNo', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CHANNEL_DATA_WITH_ACCOUNT_NUMBER',
          '/customer-channel-enrolments-with-accno/$accountNo', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CHANNEL_DATA_WITH_ACCOUNT_NUMBER',
          '/customer-channel-enrolments-with-accno/$accountNo', response.body);
      return [];
    }
  }

  /// Get value chain data
  Future<List<dynamic>> getValueChainData(String customerId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-value-chain/$customerId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_VALUE_CHAIN_DATA',
            '/customer-value-chain/$customerId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_VALUE_CHAIN_DATA',
          '/customer-value-chain/$customerId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_VALUE_CHAIN_DATA',
          '/customer-value-chain/$customerId', response.body);
      return [];
    }
  }

  /// Get customer loans data
  Future<List<dynamic>> getCustomerLoansData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-loan-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_LOANS',
            '/customer-loan-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_LOANS',
          '/customer-loan-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_LOANS',
          '/customer-loan-data/$groupId', response.body);
      return [];
    }
  }

  Future<List<dynamic>?> getCustomerLoansDataWithAccountNo(String accountNumber) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
      Uri.parse(Global.InitialBaseUrl + '/customer-loan-data-with-accno/$accountNumber'),
      headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_LOANS_WITH_ACCOUNTNO', '/customer-loan-data-with-accno/$accountNumber', response.body);
       return [];
    }
   } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_LOANS_WITH_ACCOUNTNO', '/customer-loan-data-with-accno/$accountNumber', response.body);
       return [];
    }
    return null;
  }

  /// Get customer trade transactions data
  Future<List<dynamic>> getCustomerTradeTransactionsData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/foreign-transaction-history/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
            '/foreign-transaction-history/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
          '/foreign-transaction-history/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
          '/foreign-transaction-history/$groupId', response.body);
      return [];
    }
  }

  /// Get customer trade transactions data with account number
  Future<List<dynamic>> getCustomerTradeTransactionsDataWithAccountNo(String accountNumber) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/foreign-transaction-history-with-acc/$accountNumber'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
            '/foreign-transaction-history-with-acc/$accountNumber', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
          '/foreign-transaction-history-with-acc/$accountNumber', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_TRADE_TRANSACTIONS',
          '/foreign-transaction-history-with-acc/$accountNumber', response.body);
      return [];
    }
  }

  /// Volume:  Get lifestyle count data
  Future<List<dynamic>> getLifeStyleCountData(String customerId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-lifestyle-count-data/$customerId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_LIFESTYLE_DATA',
            '/customer-lifestyle-count-data/$customerId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_LIFESTYLE_DATA',
          '/customer-lifestyle-count-data/$customerId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_LIFESTYLE_DATA',
          '/customer-lifestyle-count-data/$customerId', response.body);
      return [];
    }
  }

  /// Volume:  Get lifestyle value data
  Future<List<dynamic>> getLifeStyleValueData(String customerId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-lifestyle-value-data/$customerId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_LIFESTYLE_VALUE_DATA',
            '/customer-lifestyle-value-data/$customerId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_LIFESTYLE_VALUE_DATA',
          '/customer-lifestyle-value-data/$customerId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_LIFESTYLE_VALUE_DATA',
          '/customer-lifestyle-value-data/$customerId', response.body);
      return [];
    }
  }

  /// Get customer touch point data
  Future<List<dynamic>> getTouchPointData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/get-customerGrp-touch-point/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_TOUCH_POINT_DATA',
            '/get-customerGrp-touch-point/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_TOUCH_POINT_DATA',
          '/get-customerGrp-touch-point/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_TOUCH_POINT_DATA',
           '/get-customerGrp-touch-point/$groupId', response.body);
      return [];
    }
  }

 /// Get account touch point data
  Future<List<dynamic>> getAccountTouchPointData(String customerAccountNo) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/get-account-touch-point/$customerAccountNo'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_ACCOUNT_TOUCH_POINT_DATA',
            '/get-account-touch-point/$customerAccountNo', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_ACCOUNT_TOUCH_POINT_DATA',
          '/get-account-touch-point/$customerAccountNo', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_ACCOUNT_TOUCH_POINT_DATA',
          '/get-account-touch-point/$customerAccountNo', response.body);
      return [];
    }
  }

  /// Get NBO Data
  Future<List<dynamic>> getNBOData(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-nbo-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent(
            'GET_NBO_DATA', '/customer-nbo-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent(
          'GET_NBO_DATA', '/customer-nbo-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent(
          'GET_NBO_DATA', '/customer-nbo-data/$groupId', response.body);
      return [];
    }
  }

  /// Get total inflow
  Future<List<dynamic>> getTransactionInflow(
      String groupId, String startDate, String endDate) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl +
            '/cust-grp-chan-credit-trend/$groupId/$startDate/$endDate'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent(
            'GET_TRANSACTION_INFLOW', '/cust-grp-chan-credit-trend/$groupId/$startDate/$endDate',
            response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent(
          'GET_TRANSACTION_INFLOW', '/cust-grp-chan-credit-trend/$groupId/$startDate/$endDate',
          response.body);
      return [];
    } else {
      pandora.logFirebaseEvent(
          'GET_TRANSACTION_INFLOW', '/cust-grp-chan-credit-trend/$groupId/$startDate/$endDate',
          response.body);
      return [];
    }
  }

/// Get total inflow with account number
  Future<List<dynamic>> getTransactionInflowWithAccountNo(
      String accountNo, String startDate, String endDate) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl +
            '/account-credit-trend/$accountNo/$startDate/$endDate'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent(
            'GET_TRANSACTION_INFLOW_WITH_ACCOUNT_NO',
            '/account-credit-trend/$accountNo/$startDate/$endDate',
            response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent(
          'GET_TRANSACTION_INFLOW_WITH_ACCOUNT_NO',
          '/account-credit-trend/$accountNo/$startDate/$endDate',
          response.body);
      return [];
    } else {
      pandora.logFirebaseEvent(
          'GET_TRANSACTION_INFLOW_WITH_ACCOUNT_NO',
          '/account-credit-trend/$accountNo/$startDate/$endDate',
          response.body);
      return [];
    }
  }

  /// Get outflow
  Future<List<dynamic>> getTransactionOutflow(
      String groupId, String startDate, String endDate) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/cust-grp-chan-debit-trend/$groupId/$startDate/$endDate'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW',
            '/cust-grp-chan-debit-trend/$groupId/$startDate/$endDate', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW',
          '/cust-grp-chan-debit-trend/$groupId/$startDate/$endDate', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW',
          '/cust-grp-chan-debit-trend/$groupId/$startDate/$endDate', response.body);
      return [];
    }
  }


/// Get customer outflow
  Future<List<dynamic>> getTransactionOutflowWithAccountNo(
      String accountNo, String startDate, String endDate) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/account-chan-debit-trend/$accountNo/$startDate/$endDate'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW_WITH_ACCOUNT_NO',
            '/account-chan-debit-trend/$accountNo/$startDate/$endDate', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW_WITH_ACCOUNT_NO',
          '/account-chan-debit-trend/$accountNo/$startDate/$endDate', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_TRANSACTION_OUTFLOW_WITH_ACCOUNT_NO',
          '/account-chan-debit-trend/$accountNo/$startDate/$endDate', response.body);
      return [];
    }
  }

  /// Get recent transactions
  Future<List<dynamic>> getRecentTransactions(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-recent-transactions/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_RECENT_TRANSACTION',
            '/customer-recent-transactions/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_RECENT_TRANSACTION',
          '/customer-recent-transactions/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_RECENT_TRANSACTION',
          '/customer-recent-transactions/$groupId', response.body);
      return [];
    }
  }

  /// Get recent transactions with account number
  Future<List<dynamic>> getRecentTransactionsWithAccountNo(String accountNo) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-recent-transactions-with-accno/$accountNo'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_RECENT_TRANSACTION_WITH_ACCOUNT_NO',
            '/customer-recent-transactions-with-accno/$accountNo', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_RECENT_TRANSACTION_WITH_ACCOUNT_NO',
          '/customer-recent-transactions-with-accno/$accountNo', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_RECENT_TRANSACTION_WITH_ACCOUNT_NO',
          '/customer-recent-transactions-with-accno/$accountNo', response.body);
      return [];
    }
  }


  /// Get bank performance data
  Future<List<dynamic>> getBankingPerformance() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(
          Uri.parse(Global.InitialBaseUrl + '/rm-performance-data/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        List<dynamic> myResponse = [];
        Map<String, dynamic> item = {
          'customerCount': test['customerCount'],
          "ytdCustomerCount": test['ytdCustomerCount'],
          "accountCount": test['accountCount'],
          "ytdAccountCount": test['ytdAccountCount'],
        };
        myResponse.add(item);
        return myResponse;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent('GET_BANK_PERFORMANCE_DATA',
            '/rm-performance-data/', response.body);
        return [];
      }
      else {
        pandora.logFirebaseEvent('GET_BANK_PERFORMANCE_DATA',
            '/rm-performance-data/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_BANK_PERFORMANCE_DATA',
          '/rm-performance-data/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent('GET_BANK_PERFORMANCE_DATA',
          '/rm-performance-data/', error.toString());
      return [];
    }
  }


  /// Get bank deposits
  Future<List<dynamic>> getBankDeposits() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-performance-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      var test = jsonDecode(response.body);
      List<dynamic> myResponse = [];
      Map<String, dynamic> item = {
        'actualDeposits': test['actualDeposits'],
        "actualDepositsChange": test['actualDepositsChange'],
        "averageDeposits": test['averageDeposits'],
        "averageDepositsChange": test['averageDepositsChange'],
      };
      myResponse.add(item);
      return myResponse;
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_DEPOSITS',
          '/rm-performance-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_DEPOSITS',
          '/rm-performance-data/', response.body);
      return [];
    }
  }

  /// Get Bank Deposits Chart
  var returnDeposit = <BankDepositsData>[];
  Future<List<dynamic>> getBankDepositsChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-deposits-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnDeposit =
            List.from(returnData).map((e) => BankDepositsData.fromMap(e)).toList();
        return returnDeposit;
      } else {
        pandora.logFirebaseEvent('GET_BANK_DEPOSITS_CHART',
            '/rm-deposits-data/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_DEPOSITS_CHART',
          '/rm-deposits-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_DEPOSITS_CHART',
          '/rm-deposits-data/', response.body);
      return [];
    }
  }


  /// Get Bank Revenue Chart
  var returnRevenue = <BankRevenueData>[];
  Future<List<dynamic>> getBankRevenueChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-revenue-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnRevenue = List.from(returnData).map((e) => BankRevenueData.fromMap(e)).toList();
        return returnRevenue;
      } else {
        pandora.logFirebaseEvent('GET_BANK_REVENUE_CHART',
            '/rm-revenue-data/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_REVENUE_CHART',
          '/rm-revenue-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_REVENUE_CHART',
          '/rm-revenue-data/', response.body);
      return [];
    }
  }

  /// Get bank loan chart
  var returnLoan = <BankLoanData>[];
  Future<List<dynamic>> getBankLoanChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-loans-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnLoan = List.from(returnData).map((e) => BankLoanData.fromMap(e)).toList();
        return returnLoan;
      } else {
        pandora.logFirebaseEvent('GET_BANK_LOAN_CHART',
            '/rm-loans-data/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_LOAN_CHART',
          '/rm-loans-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_LOAN_CHART',
          '/rm-loans-data/', response.body);
      return [];
    }
  }


  /// Get bank revenue
  Future<List<dynamic>> getBankRevenue() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-performance-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      var test = jsonDecode(response.body);
      List<dynamic> myResponse = [];
      Map<String, dynamic> item = {
        'ytdRevenue': test['ytdRevenue'],
        "loansRevenue": test['loansRevenue'],
        "depositsRevenue": test['depositsRevenue'],
        "commFeesRevenue": test['commFeesRevenue'],
      };
      myResponse.add(item);
      return myResponse;
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_REVENUE',
          '/rm-performance-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_REVENUE',
          '/rm-performance-data/', response.body);
      return [];
    }
  }

  /// Get bank touch point
  var returnList = <TouchPointData>[];
  Future<List<dynamic>> getBankTouchPoint() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-touch-point/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnList =
            List.from(returnData).map((e) => TouchPointData.fromMap(e)).toList();
        return returnList;
      } else {
        pandora.logFirebaseEvent('GET_BANK_TOUCH_POINT',
            '/rm-touch-point/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_TOUCH_POINT',
          '/rm-touch-point/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_TOUCH_POINT',
          '/rm-touch-point/', response.body);
      return [];
    }
  }

  /// Get bank loans
  Future<List<dynamic>> getBankLoans() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-performance-data/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      var test = jsonDecode(response.body);
      List<dynamic> myResponse = [];
      Map<String, dynamic> item = {
        'actualLoans': test['actualLoans'],
        "actualLoansChange": test['actualLoansChange'],
        "averageLoans": test['averageLoans'],
        "averageLoansChange": test['averageLoansChange'],
      };
      myResponse.add(item);
      return myResponse;
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_BANK_LOANS',
          '/rm-loans-data/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_BANK_LOANS',
          '/rm-performance-data/', response.body);
      return [];
    }
  }


  /// Get loan classification status
  var returnPoint = <LoanClassificationStatus>[];
  Future<List<dynamic>> getLoanClassificationStatus() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-loan-classification-status/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnPoint = List.from(returnData).map((e) => LoanClassificationStatus.fromMap(e)).toList();
        return returnPoint;
      } else {
        pandora.logFirebaseEvent('GET_LOAN_CLASSIFICATION_STATUS',
            '/rm-loan-classification-status/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_LOAN_CLASSIFICATION_STATUS',
          '/rm-loan-classification-status/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_LOAN_CLASSIFICATION_STATUS',
          '/rm-loan-classification-status/', response.body);
      return [];
    }
  }


  /// Get loan overdue
  var returnOverdue = <LoanClassificationStatus>[];
  Future<List<dynamic>> getLoanOverdue() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-loan-dpd-status/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnOverdue = List.from(returnData).map((e) => LoanClassificationStatus.fromMap(e)).toList();
        return returnOverdue;
      } else {
        pandora.logFirebaseEvent('GET_LOAN_OVERDUE',
            '/rm-loan-dpd-status/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_LOAN_OVERDUE',
          '/rm-loan-dpd-status/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_LOAN_OVERDUE',
          '/rm-loan-dpd-status/', response.body);
      return [];
    }
  }


  /// Get data completeness and validity
  var returnComplete = <CompletenessAndValidityData>[];
  Future<List<dynamic>> getDataCompletenessAndValidity() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/rm-data-exceptions-chart/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        var returnData = jsonDecode(response.body);
        returnComplete = List.from(returnData).map((e) => CompletenessAndValidityData.fromMap(e)).toList();
        return returnComplete;
      } else {
        pandora.logFirebaseEvent('GET_DATA_COMPLETENESS_VALIDITY',
            '/rm-data-exceptions-chart/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_DATA_COMPLETENESS_VALIDITY',
          '/rm-data-exceptions-chart/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_DATA_COMPLETENESS_VALIDITY',
          '/rm-data-exceptions-chart/', response.body);
      return [];
    }
  }


  /// Get customer signatories
  Future<List<dynamic>> getCustomerSignatories(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-signatories-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_SIGNATORIES',
            '/customer-signatories-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_SIGNATORIES',
          '/customer-signatories-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_SIGNATORIES',
          '/customer-signatories-data/$groupId', response.body);
      return [];
    }
  }

  /// Get customer directors
  Future<List<dynamic>> getCustomerDirectors(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-directors-data/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_DIRECTORS',
            '/customer-directors-data/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_DIRECTORS',
          '/customer-directors-data/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_DIRECTORS',
          '/customer-directors-data/$groupId', response.body);
      return [];
    }
  }

  /// Get customer complaints
  Future<List<dynamic>> getCustomerComplaints(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-complaints/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINTS',
            '/customer-complaints/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINTS',
          '/customer-complaints/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINTS',
          '/customer-complaints/$groupId', response.body);
      return [];
    }
  }

  /// Get customer complaint categories
  Future<List<dynamic>> getComplaintCategories(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-complaint-categories/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_COMPLAINT_CATEGORIES',
            '/customer-complaint-categories/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_COMPLAINT_CATEGORIES',
          '/customer-complaint-categories/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_COMPLAINT_CATEGORIES',
          '/customer-complaint-categories/$groupId', response.body);
      return [];
    }
  }

  /// Get customer complaint trend
  Future<List<dynamic>> getCustomerComplaintTrend(String groupId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/customer-complaint-trend/$groupId'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is List) {
        return jsonDecode(response.body);
      } else {
        pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINT_TREND',
            '/customer-complaint-trend/$groupId', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINT_TREND',
          '/customer-complaint-trend/$groupId', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_CUSTOMER_COMPLAINT_TREND',
          '/customer-complaint-trend/$groupId', response.body);
      return [];
    }
  }

  /// Get pipeline deals items
  Future<dynamic> getPipelineDealsItems() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmDealsSummary/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      DealsItemsResponse deals = DealsItemsResponse.fromJson(jsonDecode(response.body));
      return deals;
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_PIPELINE_DEALS_ITEMS',
          '/callManagement/getRmDealsSummary/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_PIPELINE_DEALS_ITEMS',
          '/callManagement/getRmDealsSummary/', response.body);
      return [];
    }
  }


  /// Get Pending Deal Status, Disbursement and Completed.
  Future<dynamic> getAllDeals() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmDeals/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        DealsStatusResponse deals = DealsStatusResponse.fromJson(jsonDecode(response.body));
        return deals;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PENDING_STATUS_UPDATE', '/callManagement/getRmDeals/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PENDING_STATUS_UPDATE',
          '/callManagement/getRmDeals/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PENDING_STATUS_UPDATE', '/callManagement/getRmDeals/', error.toString());
      throw Exception(error);
    }
  }

  /// Get Deal Status History.
  Future<dynamic> getDealStatusHistory(String pipelineId) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getDealDetails/$pipelineId'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        DealHistoryResponse timeline = DealHistoryResponse.fromJson(jsonDecode(response.body));
        return timeline;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PENDING_STATUS_UPDATE', '/callManagement/getDealDetails/$pipelineId', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PENDING_STATUS_UPDATE',
          '/callManagement/getDealDetails/$pipelineId', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PENDING_STATUS_UPDATE', '/callManagement/getDealDetails/$pipelineId', error.toString());
      throw Exception(error);
    }
  }

  /// Get feesRevenue, grossRevenue, totalRevenue, and nrff.
  getRevenueValues(String amount, String feesRate, String interestRate, String netInterestMargin) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/calculateDealRevenue/$amount/$feesRate/$interestRate/$netInterestMargin/'),
        headers: postAuthHeaders(Global.API_TOKEN!),
      );
      if (response.statusCode == 200) {
        return RevenueDetailsResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_REVENUE_VALUES', '/callManagement/calculateDealRevenue/$amount/$feesRate/$interestRate/$netInterestMargin/',
            response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_REVENUE_VALUES',
          '/callManagement/calculateDealRevenue/$amount/$feesRate/$interestRate/$netInterestMargin/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_REVENUE_VALUES', '/callManagement/calculateDealRevenue/$amount/$feesRate/$interestRate/$netInterestMargin/',
          error.toString());
      throw Exception(error);
    }
  }

  /// Add a Pipeline Deal
  Future<DealsStatusResponse?> addNewPipelineDeal(dynamic dealData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.post(Uri.parse(Global.InitialBaseUrl + '/callManagement/AddPipelineDeal'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(dealData));
      if (response.statusCode == 200) {
        DealsStatusResponse deals = DealsStatusResponse.fromJson(jsonDecode(response.body));
        return deals;
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('ADD_PIPELINE_DEAL', '/callManagement/AddPipelineDeal', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent('ADD_PIPELINE_DEAL', '/callManagement/AddPipelineDeal', response.body);
      }
    }  catch (error) {
      pandora.logFirebaseEvent('ADD_PIPELINE_DEAL', '/callManagement/AddPipelineDeal', error.toString());
      throw error;
    }
    return null;
  }

  /// Get pipeline deal Product Type
  Future<dynamic> getPipelineProductType() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getProductTypes/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        ProductTypeDetailsResponse productTypes = ProductTypeDetailsResponse.fromJson(jsonDecode(response.body));
        return productTypes.result;
        /*List<String> result = [];
        for(var item in productTypes.result){
          result.add(item.product);
        }
        return result;*/
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PIPELINE_PRODUCT_TYPES', '/callManagement/getProductTypes/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PIPELINE_PRODUCT_TYPES',
          '/callManagement/getProductTypes/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PIPELINE_PRODUCT_TYPES', '/callManagement/getProductTypes/', error.toString());
      throw Exception(error);
    }
  }

  /// Get Pipeline Deals Currencies
  Future<dynamic> getPipelineCurrencies() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getCurrencies/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        CurrencyDetailsResponse currencies = CurrencyDetailsResponse.fromJson(jsonDecode(response.body));
        List<String> result = [];
        for(var item in currencies.result!){
          result.add(item.currencyCode!);
        }
        return result;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PIPELINE_CURRENCIES', '/callManagement/getCurrencies/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PIPELINE_CURRENCIES',
          '/callManagement/getCurrencies/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PIPELINE_CURRENCIES', '/callManagement/getCurrencies/', error.toString());
      throw Exception(error);
    }
  }

  /// Get Status Update Status
  Future<dynamic> getListOfStatusOptions() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getListOfStatus/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        UpdateStatusDetailsResponse status = UpdateStatusDetailsResponse.fromJson(jsonDecode(response.body));
        return status.result;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PIPELINE_CURRENCIES', '/callManagement/getListOfStatus/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PIPELINE_CURRENCIES',
          '/callManagement/getListOfStatus/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PIPELINE_CURRENCIES', '/callManagement/getListOfStatus/', error.toString());
      throw Exception(error);
    }
  }

  /// Update Pending Deal Status
  updateDealStatus(Map dealStatusData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.put(Uri.parse(Global.InitialBaseUrl + '/callManagement/updatePipelineDealStatus/'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(dealStatusData));
      if (response.statusCode == 200) {
        return DealsStatusResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('UPDATE_PENDING_DEALS_STATUS',
            '/callManagement/updatePipelineDealStatus/', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent(
            'UPDATE_PENDING_DEALS_STATUS', '/callManagement/updatePipelineDealStatus/', response.body);
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('UPDATE_PENDING_DEALS_STATUS', '/callManagement/updatePipelineDealStatus/', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent('UPDATE_PENDING_DEALS_STATUS', '/callManagement/updatePipelineDealStatus/', error.toString());
      throw Exception(error);
    }
  }

  /// Update Pipeline Disbursement Disburse
  Future<DealsStatusResponse?> updateDisbursementDisburse(Map disburseData) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.put(Uri.parse(Global.InitialBaseUrl + '/callManagement/updatePipelineDisbursement/'),
          headers: postAuthHeaders(Global.API_TOKEN!),
          body: jsonEncode(disburseData));
      if (response.statusCode == 200) {
        return DealsStatusResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        pandora.logFirebaseEvent('UPDATE_DISBURSEMENT_DISBURSE',
            '/callManagement/updatePipelineDisbursement/', response.body);
        throw Exception(response.body);
      } else {
        pandora.logFirebaseEvent(
            'UPDATE_DISBURSEMENT_DISBURSE', '/callManagement/updatePipelineDisbursement/', response.body);
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('UPDATE_DISBURSEMENT_DISBURSE', '/callManagement/updatePipelineDisbursement/', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent('UPDATE_DISBURSEMENT_DEAL', '/callManagement/updatePipelineDisbursement/', error.toString());
      throw Exception(error);
    }
    return null;
  }


  /// Search a customer in pipeline deal
  Future<dynamic> searchCustomer(String searchQuery) async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/customer-details/$searchQuery'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        var customerInfo =
        SearchUserResponse.fromJson(jsonDecode(response.body));
        Map<String, dynamic> item = {
          'groupId': customerInfo.groupId,
          'customerId': customerInfo.customerId,
          'customerName': customerInfo.customerName,
          'depositBalance': customerInfo.depositBalance,
          'loanBalance': customerInfo.loanBalance,
          'ytdRevenue': customerInfo.ytdRevenue,
          'prevMonthRevenue': customerInfo.prevMonthRevenue,
          'customerRelationshipAge': customerInfo.customerRelationshipAge,
          'businessSegment': customerInfo.businessSegment,
          'subBusinessSegment': customerInfo.subBusinessSegment,
          'rmCode': customerInfo.rmCode,
          'rmName': customerInfo.rmName,
          'activeStat': customerInfo.activeStat,
        };
        return (item);
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'SEARCH_FOR_USER', '/customer-details/$searchQuery', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('SEARCH_CUSTOMER_FOR_DEALS',
          '/customer-details/$searchQuery', exception.toString());
      throw Exception(exception);
    } catch (error) {
      pandora.logFirebaseEvent(
          'SEARCH_CUSTOMER_FOR_DEALS', '/customer-details/$searchQuery', error.toString());
      throw Exception(error);
    }
  }


  /// Get Turn Around Time for Completed Rm Deals
  var returnTat = <TurnAroundTimeResponse>[];
  Future<List<dynamic>> getTurnAroundTimeChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/callManagement/getTatForCompletedRmDeals/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['result'] is List) {
        var returnData = jsonDecode(response.body)['result'];
        returnTat =
            List.from(returnData).map((e) => TurnAroundTimeResponse.fromMap(e)).toList();
        return returnTat;
      } else {
        pandora.logFirebaseEvent('GET_TAT_FOR_COMPLETED_DEALS',
            '/callManagement/getTatForCompletedRmDeals/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_TAT_FOR_COMPLETED_DEALS',
          '/callManagement/getTatForCompletedRmDeals/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_TAT_FOR_COMPLETED_DEALS',
          '/callManagement/getTatForCompletedRmDeals/', response.body);
      return [];
    }
  }


  /// Get deal by product type
  var returnProductType = <DealByProductTypeResponse>[];
  Future<List<dynamic>> getDealsByProductTypeChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmDealsGroupedByProduct/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['result'] is List) {
        var returnData = jsonDecode(response.body)['result'];
        returnProductType =
            List.from(returnData).map((e) => DealByProductTypeResponse.fromMap(e)).toList();
        return returnProductType;
      } else {
        pandora.logFirebaseEvent('GET_DEAL_BY_PRODUCT_TYPE',
            '/callManagement/getRmDealsGroupedByProduct/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_DEAL_BY_PRODUCT_TYPE',
          '/callManagement/getRmDealsGroupedByProduct/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_DEAL_BY_PRODUCT_TYPE',
          '/callManagement/getRmDealsGroupedByProduct/', response.body);
      return [];
    }
  }


  /// Get deal by currency
  var returnCurrency= <DealByCurrencyResponse>[];
  Future<List<dynamic>> getDealsByCurrencyChart() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.get(
        Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmDealsGroupedByCurrency/'),
        headers: postAuthHeaders(Global.API_TOKEN!));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['result'] is List) {
        var returnData = jsonDecode(response.body)['result'];
        returnCurrency =
            List.from(returnData).map((e) => DealByCurrencyResponse.fromMap(e)).toList();
        return returnCurrency;
      } else {
        pandora.logFirebaseEvent('GET_DEAL_BY_CURRENCY',
            '/callManagement/getRmDealsGroupedByCurrency/', response.body);
        return [];
      }
    } else if (response.statusCode == 404) {
      pandora.logFirebaseEvent('GET_DEAL_BY_CURRENCY',
          '/callManagement/getRmDealsGroupedByCurrency/', response.body);
      return [];
    } else {
      pandora.logFirebaseEvent('GET_DEAL_BY_CURRENCY',
          '/callManagement/getRmDealsGroupedByCurrency/', response.body);
      return [];
    }
  }

  /// Get Completed Deals By Products
  getCompletedDealsByProduct() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmDealsByProduct/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        DealsByProductsResponse completedDeals = DealsByProductsResponse.fromJson(jsonDecode(response.body));
        return completedDeals;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_COMPLETED_DEALS_BY_PRODUCTS', '/callManagement/getRmDealsByProduct/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_COMPLETED_DEALS_BY_PRODUCTS',
          '/callManagement/getRmDealsByProduct/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_COMPLETED_DEALS_BY_PRODUCTS', '/callManagement/getRmDealsByProduct/', error.toString());
      throw Exception(error);
    }
  }

  /// Get Pending Deals By Products
  getPendingDealsByProduct() async {
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      var response = await http.get(Uri.parse(Global.InitialBaseUrl + '/callManagement/getRmPndnDealsByProduct/'),
          headers: postAuthHeaders(Global.API_TOKEN!));
      if (response.statusCode == 200) {
        DealsByProductsResponse pendingDeals = DealsByProductsResponse.fromJson(jsonDecode(response.body));
        return pendingDeals;
      } else if (response.statusCode == 404) {
        pandora.logFirebaseEvent(
            'GET_PENDING_DEALS_BY_PRODUCTS', '/callManagement/getRmPndnDealsByProduct/', response.body);
        return [];
      }
    } on Exception catch (exception) {
      pandora.logFirebaseEvent('GET_PENDING_DEALS_BY_PRODUCTS',
          '/callManagement/getRmPndnDealsByProduct/', exception.toString());
      return [];
    } catch (error) {
      pandora.logFirebaseEvent(
          'GET_PENDING_DEALS_BY_PRODUCTS', '/callManagement/getRmPndnDealsByProduct/', error.toString());
      throw Exception(error);
    }
  }
}

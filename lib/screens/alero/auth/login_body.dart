import 'package:alero/models/response/login_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';
import '../../../network/AleroAPIService.dart';
import '../../../utils/Global.dart';
import '../../../utils/Pandora.dart';
import '../components/button.dart';
import 'login_text_field.dart';
import '../../../utils/Strings.dart' as Strings;
import '../../../style/theme.dart' as Style;

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  String userId;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    pandora
        .getFromSharedPreferences('API_TOKEN2')
        .then((value) => Global.PREF_TOKEN = value);
    pandora
        .getFromSharedPreferences('API_TOKEN2')
        .then((value) => Global.PREF_TOKEN2 = value);
    GetIt.I<FirebaseAnalytics>().logEvent(
      name: 'reached_login_screen',
      parameters: <String, dynamic>{
        'device_name': Global.DeviceName,
        'device_type': Global.DeviceType,
      },
    );
    super.initState();
    pandora.getFromSharedPreferences('userID').then((value) => userId = value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (userId != null && userId.isNotEmpty) {
      usernameController.text = userId;
    }
    return Stack(
      children: [
        buildBackgroundGradient(size),
        SingleChildScrollView(
          child: loginDesigns(size),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 400),
              loginScreenText(size),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              RoundedButton(
                  text: "Login",
                  color: Colors.white,
                  textColor: Style.Colors.buttonColor,
                  press: () async {
                    if (validateLoginCredentials(
                        usernameController.text, passwordController.text)) {
                      await newLogin(usernameController.text,
                          passwordController.text, context);
                      await presentLogin(usernameController.text,
                          passwordController.text, context);
                    } else {
                      pandora.showToast(
                          Strings.Errors.loginValidationError,
                          context,
                          MessageTypes.WARNING.toString().split('.').last);
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }

  Padding loginScreenText(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Style.Constants.Padding20,
          vertical: Style.Constants.Padding10),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Enter your staff details to login.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column loginDesigns(Size size) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        Stack(
          children: [
            Image.asset('assets/login/alero_logo_img.png',
                height: size.height * 0.20),
            Container(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/login/login_effects.svg'),
            )
          ],
        ),
      ],
    );
  }

  Container buildBackgroundGradient(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF059FD5),
              Color(0xFF186B96),
              Color(0xFF114C6A),
              Color(0xFF000000)
            ],
            stops: const [0.0, 0.3, 0.7, 2.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }

  bool validateLoginCredentials(String username, String password) {
    return (username.isEmpty || password.isEmpty) ? false : true;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> newLogin(
      String username, String password, BuildContext context) async {
    var response;
    Global.USER_NAME = username;
    OneContext().showProgressIndicator();
    try {
      response = await apiService.loginUser(username, password);
      if (response != null) {
        pandora.saveToSharedPreferences('userID', username);
        loginUser(response, context);
      } else {
        pandora.showToast(
            response, context, MessageTypes.FAILED.toString().split('.').last);
      }
    } catch (error) {
      if (error != null &&
          error
              .toString()
              .contains('Exception: Exception: "You are already logged in"')) {
        try {
          response = await apiService.logoutUser();
          newLogin(username, password, context);
        } catch (error) {
          print(error);
        }
      } else if (error != null &&
          error.toString().contains(
              'Exception: Exception: "You have exceeded password retries"')) {
        pandora.showToast('Invalid username or password', context,
            MessageTypes.FAILED.toString().split('.').last);
      } else {
        pandora.showToast('Failed to connect', context,
            MessageTypes.FAILED.toString().split('.').last);
      }
      OneContext().hideProgressIndicator();
    }
    OneContext().hideProgressIndicator();
  }

  void loginUser(LoginResponse responseBody, BuildContext context) {
    Global.API_TOKEN = responseBody.token;
    Global.APP_TIMEOUT = responseBody.slideTimeout;
    Global.PREF_TOKEN = responseBody.token;
    print('The general token is: ');
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
  }

  Future<void> presentLogin(
      String username, String password, BuildContext context) async {
    var presentResponse;
    Global.USER_NAME = username;
    try {
      presentResponse = await apiService.presentLoginUser(username, password);
      if (presentResponse != null) {
        pandora.saveToSharedPreferences('userID', username);
        presentLoginUser(presentResponse, context);
      } else {
        pandora.showToast(presentResponse, context,
            MessageTypes.FAILED.toString().split('.').last);
      }
    } catch (error) {
      if (error != null &&
          error.toString().contains(
              'Exception: Exception: "You have exceeded password retries"')) {
        pandora.showToast('Invalid username or password', context,
            MessageTypes.FAILED.toString().split('.').last);
      } else {
        pandora.showToast('Failed to connect', context,
            MessageTypes.FAILED.toString().split('.').last);
      }
    }
  }

  void presentLoginUser(LoginResponseForPm responseBody, BuildContext context) {
    Global.API_TOKEN2 = responseBody.token2;
    Global.APP_TIMEOUT = responseBody.slideTimeout;
    Global.PREF_TOKEN2 = responseBody.token2;
    /*print('The token for pm is: ');
    print(responseBody.token2);*/
    pandora.saveToSharedPreferences('API_TOKEN2', Global.API_TOKEN2);
  }
}























/*
class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  String userId;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    pandora
        .getFromSharedPreferences('API_TOKEN2')
        .then((value) => Global.PREF_TOKEN = value);
    pandora
        .getFromSharedPreferences('API_TOKEN2')
        .then((value) => Global.PREF_TOKEN2 = value);
    GetIt.I<FirebaseAnalytics>().logEvent(
      name: 'reached_login_screen',
      parameters: <String, dynamic>{
        'device_name': Global.DeviceName,
        'device_type': Global.DeviceType,
      },
    );
    super.initState();
    pandora.getFromSharedPreferences('userID').then((value) => userId = value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (userId != null && userId.isNotEmpty) {
      usernameController.text = userId;
    }
    return Stack(
      children: [
        buildBackgroundGradient(size),
        SingleChildScrollView(
          child: loginDesigns(size),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 400),
              loginScreenText(size),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              RoundedButton(
                  text: "Login",
                  color: Colors.white,
                  textColor: Style.Colors.buttonColor,
                  press: () async {
                    if (validateLoginCredentials(
                        usernameController.text, passwordController.text)) {
                      await newLogin(usernameController.text,
                          passwordController.text, context);
                      await newLoginForPm(usernameController.text,
                          passwordController.text, context);
                    } else {
                      pandora.showToast(
                          Strings.Errors.loginValidationError,
                          context,
                          MessageTypes.WARNING.toString().split('.').last);
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }

  Padding loginScreenText(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Style.Constants.Padding20,
          vertical: Style.Constants.Padding10),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Enter your staff details to login.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column loginDesigns(Size size) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        Stack(
          children: [
            Image.asset('assets/login/alero_logo_img.png',
                height: size.height * 0.20),
            Container(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/login/login_effects.svg'),
            )
          ],
        ),
      ],
    );
  }

  Container buildBackgroundGradient(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF059FD5),
              Color(0xFF186B96),
              Color(0xFF114C6A),
              Color(0xFF000000)
            ],
            stops: const [0.0, 0.3, 0.7, 2.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }

  bool validateLoginCredentials(String username, String password) {
    return (username.isEmpty || password.isEmpty) ? false : true;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> newLogin(
      String username, String password, BuildContext context) async {
    var response;
    Global.USER_NAME = username;
    OneContext().showProgressIndicator();
    try {
      response = await apiService.loginUser(username, password);
      if (response != null) {
        pandora.saveToSharedPreferences('userID', username);
        loginUser(response, context);
      } else {
        pandora.showToast(
            response, context, MessageTypes.FAILED.toString().split('.').last);
      }
    } catch (error) {
      if (error != null &&
          error
              .toString()
              .contains('Exception: Exception: "You are already logged in"')) {
        try {
          response = await apiService.logoutUser();
          newLogin(username, password, context);
        } catch (error) {
          print(error);
        }
      } else if (error != null &&
          error.toString().contains(
              'Exception: Exception: "You have exceeded password retries"')) {
        pandora.showToast('Invalid username or password', context,
            MessageTypes.FAILED.toString().split('.').last);
      } else {
        pandora.showToast('Failed to connect', context,
            MessageTypes.FAILED.toString().split('.').last);
      }
      OneContext().hideProgressIndicator();
    }
    OneContext().hideProgressIndicator();
  }

  void loginUser(LoginResponse responseBody, BuildContext context) {
    Global.API_TOKEN = responseBody.token;
    Global.APP_TIMEOUT = responseBody.slideTimeout;
    Global.PREF_TOKEN = responseBody.token;
    print('The general token is: ');
    */
/*print(responseBody.token);
    pandora.saveToSharedPreferences('API_TOKEN', Global.API_TOKEN);*//*

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
  }

  Future<void> newLoginForPm(
      String username, String password, BuildContext context) async {
    var responseForPm;
    Global.USER_NAME = username;
    try {
      responseForPm = await apiService.loginUserForPm(username, password);
      if (responseForPm != null) {
        pandora.saveToSharedPreferences('userID', username);
        loginUserForPm(responseForPm, context);
      } else {
        pandora.showToast(responseForPm, context,
            MessageTypes.FAILED.toString().split('.').last);
      }
    } catch (error) {
      if (error != null &&
          error.toString().contains(
              'Exception: Exception: "You have exceeded password retries"')) {
        pandora.showToast('Invalid username or password', context,
            MessageTypes.FAILED.toString().split('.').last);
      } else {
        pandora.showToast('Failed to connect', context,
            MessageTypes.FAILED.toString().split('.').last);
      }
    }
  }

  void loginUserForPm(LoginResponseForPm responseBody, BuildContext context) {
    Global.API_TOKEN2 = responseBody.token2;
    Global.APP_TIMEOUT = responseBody.slideTimeout;
    Global.PREF_TOKEN2 = responseBody.token2;
    */
/*print('The token for pm is: ');
    print(responseBody.token2);*//*

    pandora.saveToSharedPreferences('API_TOKEN2', Global.API_TOKEN2);
  }
}
*/








/*Future<void> newLoginForPm(String username, String password,
      BuildContext context) async {
    var responseForPm;
    Global.USER_NAME = username;
      responseForPm = await apiService.loginUser(username, password);
      if (responseForPm != null) {
        pandora.saveToSharedPreferences('userID', username);
        loginUserForPm(responseForPm, context);
      } else {
        pandora.showToast(
            responseForPm, context, MessageTypes.FAILED
            .toString()
            .split('.')
            .last);
      }
    }
*/















/*
import 'package:alero/models/response/login_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';
import '../../../network/AleroAPIService.dart';
import '../../../utils/Global.dart';
import '../../../utils/Pandora.dart';
import '../components/button.dart';
import 'login_text_field.dart';
import '../../../utils/Strings.dart' as Strings;
import '../../../style/theme.dart' as Style;

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  String userId;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    pandora
        .getFromSharedPreferences('API_TOKEN')
        .then((value) => Global.PREF_TOKEN = value);
    GetIt.I<FirebaseAnalytics>().logEvent(
      name: 'reached_login_screen',
      parameters: <String, dynamic>{
        'device_name': Global.DeviceName,
        'device_type': Global.DeviceType,
      },
    );
    super.initState();
    pandora.getFromSharedPreferences('userID').then((value) => userId = value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print(Global.PREF_TOKEN);

    if (userId != null && userId.isNotEmpty) {
      usernameController.text = userId;
    }
    return Stack(
      children: [
        buildBackgroundGradient(size),
        SingleChildScrollView(
          child: loginDesigns(size),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 400),
              loginScreenText(size),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              RoundedButton(
                  text: "Login",
                  color: Colors.white,
                  textColor: Style.Colors.buttonColor,
                  press: () {
                    if (validateLoginCredentials(
                        usernameController.text, passwordController.text)) {
                      newLogin(usernameController.text, passwordController.text,
                          context);
                    } else {
                      pandora.showToast(
                          Strings.Errors.loginValidationError,
                          context,
                          MessageTypes.WARNING.toString().split('.').last);
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }

  Padding loginScreenText(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Style.Constants.Padding20,
          vertical: Style.Constants.Padding10),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Enter your staff details to login.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column loginDesigns(Size size) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        Stack(
          children: [
            Image.asset('assets/login/alero_logo_img.png',
                height: size.height * 0.20),
            Container(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/login/login_effects.svg'),
            )
          ],
        ),
      ],
    );
  }

  Container buildBackgroundGradient(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF059FD5),
              Color(0xFF186B96),
              Color(0xFF114C6A),
              Color(0xFF000000)
            ],
            stops: const [0.0, 0.3, 0.7, 2.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }

  bool validateLoginCredentials(String username, String password) {
    return (username.isEmpty || password.isEmpty) ? false : true;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> newLogin(
      String username, String password, BuildContext context) async {
    var response;
    var responseForPm;
    Global.USER_NAME = username;
    OneContext().showProgressIndicator();
    try {
      response = await apiService.loginUser(username, password);
      if (response != null) {
        pandora.saveToSharedPreferences('userID', username);
        loginUser(response, context);
      } else {
        pandora.showToast(
            response, context, MessageTypes.FAILED.toString().split('.').last);
      }
    } catch (error) {
      if (error != null &&
          error
              .toString()
              .contains('Exception: Exception: "You are already logged in"')) {
        try {
          response = await apiService.logoutUser();
        } catch (error) {
          print(error);
        }
      } else if (error != null &&
          error
              .toString()
              .contains('Exception: Exception: "You have exceeded password retries"')){
        pandora.showToast('Invalid username or password', context,
            MessageTypes.FAILED.toString().split('.').last);
      }else{
        pandora.showToast('Failed to connect', context,
            MessageTypes.FAILED.toString().split('.').last);
      }
      OneContext().hideProgressIndicator();
    }
    OneContext().hideProgressIndicator();
  }

  void loginUser(LoginResponse responseBody, BuildContext context) {
    Global.API_TOKEN = responseBody.token;
    Global.APP_TIMEOUT = responseBody.slideTimeout;
    Global.PREF_TOKEN = responseBody.token;
    pandora.saveToSharedPreferences('API_TOKEN', Global.API_TOKEN);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
  }
}
*/

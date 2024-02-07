import 'package:alero/screens/alero/components/screen_iteraction_listener.dart';
import 'package:alero/utils/Global.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';
import 'screens/alero/auth/login_page.dart';
import 'screens/alero/routes.dart';
import 'utils/device_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.I.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);
  DeviceDetails details = DeviceDetails();
  await details.initPlatformState();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FirebaseCrashlytics.instance.crash();
    /*DeviceDetails details = DeviceDetails();
    details.initPlatformState();*/
    return ScreenInteractionListener(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('mn', 'MN'),
            initialRoute: '/login',
            onGenerateRoute: Routes.generateRoute,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: GetIt.I<FirebaseAnalytics>())
            ],
            builder: OneContext().builder,
            home: LoginPage()),
        timeout: Global.APP_TIMEOUT,
        route: '');
  }
}

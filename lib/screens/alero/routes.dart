import 'package:alero/screens/alero/call/prospect_page.dart';
import 'package:alero/screens/alero/customer/customer_accounts.dart';
import 'package:alero/screens/alero/home/home_screen.dart';
import 'package:alero/screens/alero/call/pipeline_page.dart';
import 'package:alero/screens/alero/prospect/prospect_bio_data_input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'auth/login_page.dart';
import 'call/call_management_page.dart';
import 'components/route_animator.dart';
import 'error/error_page.dart';
import 'landing/landing_page.dart';
import 'search/search_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case '/login':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Login Screen');
        return RouteAnimator(page: LoginPage());
      case '/landing':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Landing Page');
        return RouteAnimator(page: HomeScreen(data: arguments));
      case '/single-customer-view':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Single Customer View Page');
        return RouteAnimator(
            page: SingleCustomerViewLanding(rmName: arguments));
      case '/search':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Search Page');
        return RouteAnimator(page: SearchPage(searchQuery: arguments));
      case '/customer-profile':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Customer Profile Page');
        return RouteAnimator(page: CustomerAccounts(groupId: arguments));
      case '/call-management':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Call Management Page');
        return RouteAnimator(page: CallManagementPage(userId: arguments));
      case '/prospect-bio-data-input':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Prospect BioData Input Page');
        return RouteAnimator(page: ProspectBioDataInput(prospectId: arguments));
      case '/pipeline':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Pipeline Deals Page');
        return RouteAnimator(page: PipelinePage(groupId: arguments));
      case '/callManagementPage':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Call Management Page');
        return RouteAnimator(page: CallManagementPage(userId: arguments));
      case '/prospect':
        GetIt.I<FirebaseAnalytics>().setCurrentScreen(screenName: 'Prospect Page');
        return RouteAnimator(page: ProspectPage(data: arguments));
      default:
        return RouteAnimator(page: ErrorPage());
    }
  }
}

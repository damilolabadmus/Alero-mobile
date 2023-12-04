import 'package:alero/screens/alero/call/prospect_page.dart';
import 'package:alero/screens/alero/concession/terminate_concession.dart';
import 'package:alero/screens/alero/customer/customer_accounts.dart';
import 'package:alero/screens/alero/home/home_screen.dart';
import 'package:alero/screens/alero/call/pipeline_page.dart';
import 'package:alero/screens/alero/performance/balance_sheet_side_menu.dart';
import 'package:alero/screens/alero/performance/performance_management_page.dart';
import 'package:alero/screens/alero/performance/my_balance_sheet_page.dart';
import 'package:alero/screens/alero/performance/profitability_reports_page.dart';
import 'package:alero/screens/alero/profitability/account_pr.dart';
import 'package:alero/screens/alero/profitability/cpr_balance_sheet.dart';
import 'package:alero/screens/alero/profitability/cpr_profit_loss_page.dart';
import 'package:alero/screens/alero/profitability/cpr_page.dart';
import 'package:alero/screens/alero/profitability/search_cpr_page.dart';
import 'package:alero/screens/alero/profitability/monthly_pr.dart';
import 'package:alero/screens/alero/profitability/net_revenue_from_funds.dart';
import 'package:alero/screens/alero/prospect/prospect_bio_data_input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'allocation/allocation_upload_summary.dart';
import 'allocation/cost_allocation_page.dart';
import 'allocation/cost_allocation_report.dart';
import 'auth/login_page.dart';
import 'call/call_management_page.dart';
import 'components/route_animator.dart';
import 'concession/approve_concession.dart';
import 'concession/concession_dashboard.dart';
import 'concession/create_concession.dart';
import 'concession/retrieve_concession.dart';
import 'concession/track_concession.dart';
import 'concession/treat_concession.dart';
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
      case '/performance-management':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Performance Management Page');
        return RouteAnimator(page: PerformanceManagementPage(userId: arguments));
      case '/balance_sheet_side_menu':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'BalanceSheetSideMenu');
        return RouteAnimator(page: BalanceSheetSideMenu());
      case '/my-balance-sheet-page':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'MyBalanceSheetPage');
        return RouteAnimator(page: MyBalanceSheetPage(regionId: arguments));
      case '/profitability-reports':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Profitability Reports');
        return RouteAnimator(page: ProfitabilityReportsPage(userId: arguments));
      case '/cost-allocation':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Cost Allocation');
        return RouteAnimator(page: CostAllocationPage(userId: arguments));
      case '/customer-pr':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Customer Profitability Report');
        return RouteAnimator(page: CustomerProfitabilityReportPage(searchQuery: arguments));
      case '/account-pr':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Account Profitability Report');
        return RouteAnimator(page: AccountProfitabilityReportPage(userId: arguments));
      case '/monthly-pr':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Monthly Profitability Report');
        return RouteAnimator(page: MonthlyProfitabilityReport(userId: arguments));
      case '/nrff':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Net Revenue From Funds');
        return RouteAnimator(page: NetRevenueFromFunds(userId: arguments));
      case '/cost-allocation-report':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Cost Allocation Report');
        return RouteAnimator(page: CostAllocationReport(userId: arguments));
      case '/cost-allocation-upload-summary':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Cost Allocation Upload Summary');
        return RouteAnimator(page: AllocationUploadSummary(userId: arguments));
      case '/concession-dashboard':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Concession Dashboard');
        return RouteAnimator(page: ConcessionDashboard());
      case '/create-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Create Concession');
        return RouteAnimator(page: CreateConcession());
      case '/approve-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Approve Concession');
        return RouteAnimator(page: ApproveConcession());
      case '/treat-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Treat Concession');
        return RouteAnimator(page: TreatConcession());
      case '/retrieve-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Retrieve Concession');
        return RouteAnimator(page: RetrieveConcession());
      case '/terminate-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Terminate Concession');
        return RouteAnimator(page: TerminateConcession());
      case '/track-concession':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Track Concession');
        return RouteAnimator(page: TrackConcession());
      case '/cpr-profit-and-loss':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Cpr Profit and Loss Page');
        return RouteAnimator(page: CprProfitAndLossPage());
      case '/searched-cpr':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Search Cpr Page');
        return RouteAnimator(page: SearchCprPage());
      case '/cpr-balance-sheet':
        GetIt.I<FirebaseAnalytics>()
            .setCurrentScreen(screenName: 'Cpr Balance Sheet');
        return RouteAnimator(page: CprBalanceSheet());
      default:
        return RouteAnimator(page: ErrorPage());
    }
  }
}

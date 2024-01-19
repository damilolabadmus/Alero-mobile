import 'package:flutter/cupertino.dart';

class AprResponse {
  final String customerId;
  final String accountNumber;
  final String accountName;
  final dynamic nrff;
  final dynamic accountMaintenanceFee;
  final dynamic loanRelatedFees;
  final dynamic eBusinessFees;
  final dynamic tradeFees;
  final dynamic fxIncome;
  final dynamic otherCommFees;
  final dynamic loanRecoveries;
  final dynamic commFees;
  final dynamic totalIncome;
  final String accountCategory;
  final List<AprMainReport> mainReport;
  final List<AprExcludedTab> excludedTab;

  AprResponse({
    @required this.customerId,
    @required this.accountNumber,
    @required this.accountName,
    @required this.nrff,
    @required this.accountMaintenanceFee,
    @required this.loanRelatedFees,
    @required this.eBusinessFees,
    @required this.tradeFees,
    @required this.fxIncome,
    @required this.otherCommFees,
    @required this.loanRecoveries,
    @required this.commFees,
    @required this.totalIncome,
    @required this.accountCategory,
    @required this.mainReport,
    @required this.excludedTab,
  });

  factory AprResponse.fromJson(Map<String, dynamic> json) {
    return AprResponse(
      customerId: json['customerId'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      nrff: json['nrff'],
      accountMaintenanceFee: json['accountMaintenanceFee'],
      loanRelatedFees: json['loanRelatedFees'],
      eBusinessFees: json['eBusinessFees'],
      tradeFees: json['tradeFees'],
      fxIncome: json['fxIncome'],
      otherCommFees: json['otherCommFees'],
      loanRecoveries: json['loanRecoveries'],
      commFees: json['commFees'],
      totalIncome: json['totalIncome'],
      accountCategory: json['accountCategory'],
      mainReport: (json['mainReport'] as List)
          .map((report) => AprMainReport.fromJson(report))
          .toList(),
      excludedTab: (json['excludedTab'] as List)
          .map((excluded) => AprExcludedTab.fromJson(excluded))
          .toList(),
    );
  }
}

class AprMainReport {
  final String customerNo;
  final String accountNo;
  final String customerName;
  final String incomeType;
  final Map<String, dynamic> monthsData;
  final Map<String, dynamic> currentMonthBudget;
  final Map<String, dynamic> currentMonthVariance;
  final Map<String, dynamic> currentMonthAchieved;
  final dynamic ytDActualValue;
  final dynamic ytDBudgetValue;
  final dynamic variance;
  final dynamic ytDAchieved;
  final dynamic fullYearBudget;
  final dynamic runRate;
  final List<dynamic> dropdown;

  AprMainReport({
    @required this.customerNo,
    @required this.accountNo,
    @required this.customerName,
    @required this.incomeType,
    @required this.monthsData,
    @required this.currentMonthBudget,
    @required this.currentMonthVariance,
    @required this.currentMonthAchieved,
    @required this.ytDActualValue,
    @required this.ytDBudgetValue,
    @required this.variance,
    @required this.ytDAchieved,
    @required this.fullYearBudget,
    @required this.runRate,
    @required this.dropdown,
  });

  factory AprMainReport.fromJson(Map<String, dynamic> json) {
    return AprMainReport(
      customerNo: json['customerNo'],
      accountNo: json['accountNo'],
      customerName: json['customerName'],
      incomeType: json['incomeType'],
      monthsData: Map<String, dynamic>.from(json['monthsData']),
      currentMonthBudget: Map<String, dynamic>.from(json['currentMonthBudget']),
      currentMonthVariance:
      Map<String, dynamic>.from(json['currentMonthVariance']),
      currentMonthAchieved:
      Map<String, dynamic>.from(json['currentMonthAchieved']),
      ytDActualValue: json['ytD_ACTUAL_VALUE'],
      ytDBudgetValue: json['ytD_BUDGET_VALUE'],
      variance: json['variance'],
      ytDAchieved: json['ytD_ACHIEVED'],
      fullYearBudget: json['full_Year_Budget'],
      runRate: json['runRate'],
      dropdown: json['dropdown'],
    );
  }
}

class AprExcludedTab {
  final String customerNo;
  final String accountNo;
  final String customerName;
  final String incomeType;
  final Map<String, dynamic> monthsData;
  final Map<String, dynamic> currentMonthBudget;
  final Map<String, dynamic> currentMonthVariance;
  final Map<String, dynamic> currentMonthAchieved;
  final dynamic ytDActualValue;
  final dynamic ytDBudgetValue;
  final dynamic variance;
  final dynamic ytDAchieved;
  final dynamic fullYearBudget;
  final dynamic runRate;

  AprExcludedTab({
    @required this.customerNo,
    @required this.accountNo,
    @required this.customerName,
    @required this.incomeType,
    @required this.monthsData,
    @required this.currentMonthBudget,
    @required this.currentMonthVariance,
    @required this.currentMonthAchieved,
    @required this.ytDActualValue,
    @required this.ytDBudgetValue,
    @required this.variance,
    @required this.ytDAchieved,
    @required this.fullYearBudget,
    @required this.runRate,
  });

  factory AprExcludedTab.fromJson(Map<String, dynamic> json) {
    return AprExcludedTab(
      customerNo: json['customerNo'],
      accountNo: json['accountNo'],
      customerName: json['customerName'],
      incomeType: json['incomeType'],
      monthsData: Map<String, dynamic>.from(json['monthsData']),
      currentMonthBudget: Map<String, dynamic>.from(json['currentMonthBudget']),
      currentMonthVariance:
      Map<String, dynamic>.from(json['currentMonthVariance']),
      currentMonthAchieved:
      Map<String, dynamic>.from(json['currentMonthAchieved']),
      ytDActualValue: json['ytD_ACTUAL_VALUE'],
      ytDBudgetValue: json['ytD_BUDGET_VALUE'],
      variance: json['variance'],
      ytDAchieved: json['ytD_ACHIEVED'],
      fullYearBudget: json['full_Year_Budget'],
      runRate: json['runRate'],
    );
  }
}

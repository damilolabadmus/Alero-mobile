import 'package:flutter/cupertino.dart';

class CprResponse {
  final String customerNo;
  final String customerName;
  final dynamic accountCount;
  final String customerType;
  final String activeStatus;
  final String region;
  final String area;
  final String branchName;
  final dynamic actualBalance;
  final dynamic averageBalance;
  final dynamic ftpIncome;
  final dynamic interestExpense;
  final dynamic interestIncome;
  final dynamic totalExpense;
  final dynamic profitability;
  final dynamic totalIncome;
  final String customerCategory;
  final List<MainReport> mainReport;
  final List<ExcludedTab> excludedTab;

  CprResponse({
    @required this.customerNo,
    @required this.customerName,
    @required this.accountCount,
    @required this.customerType,
    @required this.activeStatus,
    @required this.region,
    @required this.area,
    @required this.branchName,
    @required this.actualBalance,
    @required this.averageBalance,
    @required this.ftpIncome,
    @required this.interestExpense,
    @required this.interestIncome,
    @required this.totalExpense,
    @required this.profitability,
    @required this.totalIncome,
    @required this.customerCategory,
    @required this.mainReport,
    @required this.excludedTab,
  });

  factory CprResponse.fromJson(Map<String, dynamic> json) {
    return CprResponse(
      customerNo: json['customerNo'],
      customerName: json['customerName'],
      accountCount: json['accountCount'],
      customerType: json['customerType'],
      activeStatus: json['activeStatus'],
      region: json['region'],
      area: json['area'],
      branchName: json['branch_Name'],
      actualBalance: json['actualBalance'],
      averageBalance: json['averageBalance'],
      ftpIncome: json['ftpIncome'],
      interestExpense: json['interestExpense'],
      interestIncome: json['interestIncome'],
      totalExpense: json['totalExpense'],
      profitability: json['profitability'],
      totalIncome: json['totalIncome'],
      customerCategory: json['customerCategory'],
      mainReport: (json['mainReport'] as List)
          .map((report) => MainReport.fromJson(report))
          .toList(),
      excludedTab: (json['excludedTab'] as List)
          .map((excluded) => ExcludedTab.fromJson(excluded))
          .toList(),
    );
  }
}

class MainReport {
  final String customerName;
  final String customerNo;
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

  MainReport({
    @required this.customerName,
    @required this.customerNo,
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

  factory MainReport.fromJson(Map<String, dynamic> json) {
    return MainReport(
      customerName: json['customerName'],
      customerNo: json['customerNo'],
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

class ExcludedTab {
  final String customerName;
  final String customerNo;
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

  ExcludedTab({
    @required this.customerName,
    @required this.customerNo,
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

  factory ExcludedTab.fromJson(Map<String, dynamic> json) {
    return ExcludedTab(
      customerName: json['customerName'],
      customerNo: json['customerNo'],
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

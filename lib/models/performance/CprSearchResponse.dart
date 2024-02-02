

import 'dart:convert';

List<CprSearchResponse> cprSearchResponseFromJson(String str) => List<CprSearchResponse>.from(json.decode(str).map((x) => CprSearchResponse.fromJson(x)));

String cprSearchResponseToJson(List<CprSearchResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CprSearchResponse {
  String? customerNo;
  CustomerName? customerName;
  int? accountCount;
  String? customerType;
  String? activeStatus;
  String? region;
  String? area;
  String? branchName;
  double? actualBalance;
  double? averageBalance;
  double? ftpIncome;
  int? interestExpense;
  int? interestIncome;
  double? totalExpense;
  double? profitability;
  double? totalIncome;
  dynamic customerCategory;
  List<ExcludedTab>? mainReport;
  List<ExcludedTab>? excludedTab;

  CprSearchResponse({
    this.customerNo,
    this.customerName,
    this.accountCount,
    this.customerType,
    this.activeStatus,
    this.region,
    this.area,
    this.branchName,
    this.actualBalance,
    this.averageBalance,
    this.ftpIncome,
    this.interestExpense,
    this.interestIncome,
    this.totalExpense,
    this.profitability,
    this.totalIncome,
    this.customerCategory,
    this.mainReport,
    this.excludedTab,
  });

  factory CprSearchResponse.fromJson(Map<String, dynamic> json) => CprSearchResponse(
    customerNo: json["customerNo"],
    customerName: customerNameValues.map[json["customerName"]],
    accountCount: json["accountCount"],
    customerType: json["customerType"],
    activeStatus: json["activeStatus"],
    region: json["region"],
    area: json["area"],
    branchName: json["branch_Name"],
    actualBalance: json["actualBalance"].toDouble(),
    averageBalance: json["averageBalance"].toDouble(),
    ftpIncome: json["ftpIncome"].toDouble(),
    interestExpense: json["interestExpense"],
    interestIncome: json["interestIncome"],
    totalExpense: json["totalExpense"].toDouble(),
    profitability: json["profitability"].toDouble(),
    totalIncome: json["totalIncome"].toDouble(),
    customerCategory: json["customerCategory"],
    mainReport: List<ExcludedTab>.from(json["mainReport"].map((x) => ExcludedTab.fromJson(x))),
    excludedTab: List<ExcludedTab>.from(json["excludedTab"].map((x) => ExcludedTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customerNo": customerNo,
    "customerName": customerNameValues.reverse![customerName],
    "accountCount": accountCount,
    "customerType": customerType,
    "activeStatus": activeStatus,
    "region": region,
    "area": area,
    "branch_Name": branchName,
    "actualBalance": actualBalance,
    "averageBalance": averageBalance,
    "ftpIncome": ftpIncome,
    "interestExpense": interestExpense,
    "interestIncome": interestIncome,
    "totalExpense": totalExpense,
    "profitability": profitability,
    "totalIncome": totalIncome,
    "customerCategory": customerCategory,
    "mainReport": List<dynamic>.from(mainReport!.map((x) => x.toJson())),
    "excludedTab": List<dynamic>.from(excludedTab!.map((x) => x.toJson())),
  };
}

enum CustomerName {
  OMOROGBE_MERCY
}

final customerNameValues = EnumValues({
  "OMOROGBE MERCY": CustomerName.OMOROGBE_MERCY
});

class ExcludedTab {
  CustomerName? customerName;
  String? customerNo;
  String? incomeType;
  Map<String, double?>? monthsData;
  CurrentMonthBudget? currentMonthBudget;
  CurrentMonthVariance? currentMonthVariance;
  CurrentMonthAchieved? currentMonthAchieved;
  double? ytDActualValue;
  int? ytDBudgetValue;
  double? variance;
  double? ytDAchieved;
  int? fullYearBudget;
  double? runRate;
  List<ExcludedTab>? dropdown;

  ExcludedTab({
    this.customerName,
    this.customerNo,
    this.incomeType,
    this.monthsData,
    this.currentMonthBudget,
    this.currentMonthVariance,
    this.currentMonthAchieved,
    this.ytDActualValue,
    this.ytDBudgetValue,
    this.variance,
    this.ytDAchieved,
    this.fullYearBudget,
    this.runRate,
    this.dropdown,
  });

  factory ExcludedTab.fromJson(Map<String, dynamic> json) => ExcludedTab(
    customerName: customerNameValues.map[json["customerName"]],
    customerNo: json["customerNo"],
    incomeType: json["incomeType"],
    monthsData: Map.from(json["monthsData"]).map((k, v) => MapEntry<String, double?>(k, v.toDouble())),
    currentMonthBudget: CurrentMonthBudget.fromJson(json["currentMonthBudget"]),
    currentMonthVariance: CurrentMonthVariance.fromJson(json["currentMonthVariance"]),
    currentMonthAchieved: CurrentMonthAchieved.fromJson(json["currentMonthAchieved"]),
    ytDActualValue: json["ytD_ACTUAL_VALUE"].toDouble(),
    ytDBudgetValue: json["ytD_BUDGET_VALUE"],
    variance: json["variance"].toDouble(),
    ytDAchieved: json["ytD_ACHIEVED"].toDouble(),
    fullYearBudget: json["full_Year_Budget"],
    runRate: json["runRate"].toDouble(),
    dropdown: List<ExcludedTab>.from(json["dropdown"].map((x) => ExcludedTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customerName": customerNameValues.reverse![customerName],
    "customerNo": customerNo,
    "incomeType": incomeType,
    "monthsData": Map.from(monthsData!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "currentMonthBudget": currentMonthBudget!.toJson(),
    "currentMonthVariance": currentMonthVariance!.toJson(),
    "currentMonthAchieved": currentMonthAchieved!.toJson(),
    "ytD_ACTUAL_VALUE": ytDActualValue,
    "ytD_BUDGET_VALUE": ytDBudgetValue,
    "variance": variance,
    "ytD_ACHIEVED": ytDAchieved,
    "full_Year_Budget": fullYearBudget,
    "runRate": runRate,
    "dropdown": List<dynamic>.from(dropdown!.map((x) => x.toJson())),
  };
}

class CurrentMonthAchieved {
  double? sep2023Achieved;

  CurrentMonthAchieved({
    this.sep2023Achieved,
  });

  factory CurrentMonthAchieved.fromJson(Map<String, dynamic> json) => CurrentMonthAchieved(
    sep2023Achieved: json["Sep_2023_Achieved"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Sep_2023_Achieved": sep2023Achieved,
  };
}

class CurrentMonthBudget {
  int? sep2023BudgetValue;

  CurrentMonthBudget({
    this.sep2023BudgetValue,
  });

  factory CurrentMonthBudget.fromJson(Map<String, dynamic> json) => CurrentMonthBudget(
    sep2023BudgetValue: json["Sep_2023_Budget_Value"],
  );

  Map<String, dynamic> toJson() => {
    "Sep_2023_Budget_Value": sep2023BudgetValue,
  };
}

class CurrentMonthVariance {
  double? sep2023Variance;

  CurrentMonthVariance({
    this.sep2023Variance,
  });

  factory CurrentMonthVariance.fromJson(Map<String, dynamic> json) => CurrentMonthVariance(
    sep2023Variance: json["Sep_2023_Variance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Sep_2023_Variance": sep2023Variance,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

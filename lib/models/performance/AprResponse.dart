import 'dart:convert';

List<AprResponse> aprResponseFromJson(String str) => List<AprResponse>.from(json.decode(str).map((x) => AprResponse.fromJson(x)));

String aprResponseToJson(List<AprResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AprResponse {
  String customerId;
  String accountNumber;
  String accountName;
  double nrff;
  double accountMaintenanceFee;
  double loanRelatedFees;
  double eBusinessFees;
  int tradeFees;
  int fxIncome;
  double otherCommFees;
  int loanRecoveries;
  double commFees;
  double totalIncome;
  AccountCategory accountCategory;
  List<ExcludedTab> mainReport;
  List<ExcludedTab> excludedTab;

  AprResponse({
    this.customerId,
    this.accountNumber,
    this.accountName,
    this.nrff,
    this.accountMaintenanceFee,
    this.loanRelatedFees,
    this.eBusinessFees,
    this.tradeFees,
    this.fxIncome,
    this.otherCommFees,
    this.loanRecoveries,
    this.commFees,
    this.totalIncome,
    this.accountCategory,
    this.mainReport,
    this.excludedTab,
  });

  factory AprResponse.fromJson(Map<String, dynamic> json) => AprResponse(
    customerId: json["customerId"],
    accountNumber: json["accountNumber"],
    accountName: json["accountName"],
    nrff: json["nrff"].toDouble(),
    accountMaintenanceFee: json["accountMaintenanceFee"].toDouble(),
    loanRelatedFees: json["loanRelatedFees"].toDouble(),
    eBusinessFees: json["eBusinessFees"].toDouble(),
    tradeFees: json["tradeFees"],
    fxIncome: json["fxIncome"],
    otherCommFees: json["otherCommFees"].toDouble(),
    loanRecoveries: json["loanRecoveries"],
    commFees: json["commFees"].toDouble(),
    totalIncome: json["totalIncome"].toDouble(),
    accountCategory: accountCategoryValues.map[json["accountCategory"]],
    mainReport: List<ExcludedTab>.from(json["mainReport"].map((x) => ExcludedTab.fromJson(x))),
    excludedTab: List<ExcludedTab>.from(json["excludedTab"].map((x) => ExcludedTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "accountNumber": accountNumber,
    "accountName": accountName,
    "nrff": nrff,
    "accountMaintenanceFee": accountMaintenanceFee,
    "loanRelatedFees": loanRelatedFees,
    "eBusinessFees": eBusinessFees,
    "tradeFees": tradeFees,
    "fxIncome": fxIncome,
    "otherCommFees": otherCommFees,
    "loanRecoveries": loanRecoveries,
    "commFees": commFees,
    "totalIncome": totalIncome,
    "accountCategory": accountCategoryValues.reverse[accountCategory],
    "mainReport": List<dynamic>.from(mainReport.map((x) => x.toJson())),
    "excludedTab": List<dynamic>.from(excludedTab.map((x) => x.toJson())),
  };
}

enum AccountCategory {
  TOP_100_ACCOUNTS
}

final accountCategoryValues = EnumValues({
  "Top 100 Accounts": AccountCategory.TOP_100_ACCOUNTS
});

class ExcludedTab {
  String customerNo;
  String accountNo;
  String customerName;
  IncomeType incomeType;
  Map<String, double> monthsData;
  CurrentMonthBudget currentMonthBudget;
  CurrentMonthVariance currentMonthVariance;
  CurrentMonthAchieved currentMonthAchieved;
  double ytDActualValue;
  int ytDBudgetValue;
  double variance;
  double ytDAchieved;
  int fullYearBudget;
  double runRate;
  List<ExcludedTab> dropdown;

  ExcludedTab({
    this.customerNo,
    this.accountNo,
    this.customerName,
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
    customerNo: json["customerNo"],
    accountNo: json["accountNo"],
    customerName: json["customerName"],
    incomeType: incomeTypeValues.map[json["incomeType"]],
    monthsData: Map.from(json["monthsData"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
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
    "customerNo": customerNo,
    "accountNo": accountNo,
    "customerName": customerName,
    "incomeType": incomeTypeValues.reverse[incomeType],
    "monthsData": Map.from(monthsData).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "currentMonthBudget": currentMonthBudget.toJson(),
    "currentMonthVariance": currentMonthVariance.toJson(),
    "currentMonthAchieved": currentMonthAchieved.toJson(),
    "ytD_ACTUAL_VALUE": ytDActualValue,
    "ytD_BUDGET_VALUE": ytDBudgetValue,
    "variance": variance,
    "ytD_ACHIEVED": ytDAchieved,
    "full_Year_Budget": fullYearBudget,
    "runRate": runRate,
    "dropdown": List<dynamic>.from(dropdown.map((x) => x.toJson())),
  };
}

class CurrentMonthAchieved {
  int oct2023Achieved;

  CurrentMonthAchieved({
    this.oct2023Achieved,
  });

  factory CurrentMonthAchieved.fromJson(Map<String, dynamic> json) => CurrentMonthAchieved(
    oct2023Achieved: json["Oct_2023_Achieved"],
  );

  Map<String, dynamic> toJson() => {
    "Oct_2023_Achieved": oct2023Achieved,
  };
}

class CurrentMonthBudget {
  int oct2023BudgetValue;

  CurrentMonthBudget({
    this.oct2023BudgetValue,
  });

  factory CurrentMonthBudget.fromJson(Map<String, dynamic> json) => CurrentMonthBudget(
    oct2023BudgetValue: json["Oct_2023_Budget_Value"],
  );

  Map<String, dynamic> toJson() => {
    "Oct_2023_Budget_Value": oct2023BudgetValue,
  };
}

class CurrentMonthVariance {
  int oct2023Variance;

  CurrentMonthVariance({
    this.oct2023Variance,
  });

  factory CurrentMonthVariance.fromJson(Map<String, dynamic> json) => CurrentMonthVariance(
    oct2023Variance: json["Oct_2023_Variance"],
  );

  Map<String, dynamic> toJson() => {
    "Oct_2023_Variance": oct2023Variance,
  };
}

enum IncomeType {
  ACCOUNT_MAINTENANCE_FEE,
  ALLOCATED_COST,
  ALLOCATED_EXPENSE,
  AMCON_COST,
  ATM_COMMISSIONS,
  BDC_COMMISSIONS,
  BILLS_COMMISSIONS,
  CARDS_FEE,
  CASHLITE,
  CASH_FEES,
  COMMISSIONS_AND_FEES,
  COMMISSIONS_CASH_HANDLING,
  COMMISSIONS_GI,
  COMMISSIONS_ON_FOREIGN_CURRENCY_TRANSFERS,
  COMM_AGRIC_LOANS,
  DEPOSIT_ACTUAL_BALANCE,
  DEPOSIT_AVERAGE_BALANCE,
  DIRECT_EXPENSE,
  DIVIDEND_INCOME,
  EBUSINESS_FEE,
  FCUBS_COST,
  FORM_A_COMMISSIONS,
  FORM_M_COMMISSIONS,
  FTP_EXPENSE,
  FTP_EXPENSE_SUBSIDY,
  FTP_INCOME,
  FTP_INCOME_SUBSIDY,
  FX_GAIN_OR_LOSS_CARDS,
  FX_INCOME,
  FX_INCOME_FORWARDS,
  FX_INCOME_FUTURES,
  FX_REVALUATION,
  GAIN_EQUITY_INVESTMENTS,
  INTEREST_EXPENSE,
  INTEREST_INCOME,
  INTEREST_SUSPENSE,
  INTERNET_BANKING,
  INVESTMENT_INCOME,
  LC_COMMISSIONS,
  LEGAL_INCOME,
  LOANS_ACTUAL_BALANCE,
  LOANS_AVERAGE_BALANCE,
  LOAN_FEES,
  LOAN_RECOVERIES,
  MANAGEMENT_TECHNOLOGY_FEES,
  MARKETING_COST,
  MOBILE_BANKING,
  MTM_INCOME_BONDS,
  MTM_INCOME_TBILLS,
  NDIC_COST,
  NET_FTP_INCOME,
  NET_INCOME,
  NET_INTEREST_INCOME,
  OPERATING_EXPENSES,
  OTHER_COMMISSIONS,
  OTHER_EXPENSE,
  OTHER_INCOME,
  PAYMENTS_COLLECTIONS,
  POS_COMMISSIONS,
  PROFIT_BEFORE_TAX,
  REMITTANCES,
  RENTAL_INCOME,
  RM_STAFF_COSTS,
  SMS_FEE,
  SUNDRY_INCOME,
  TRADE_ACTUAL_BALANCE,
  TRADE_AVERAGE_BALANCE,
  TRADE_FEE,
  TREASURY_INCOME
}

final incomeTypeValues = EnumValues({
  "Account Maintenance Fee": IncomeType.ACCOUNT_MAINTENANCE_FEE,
  "Allocated Cost": IncomeType.ALLOCATED_COST,
  "Allocated Expense": IncomeType.ALLOCATED_EXPENSE,
  "Amcon Cost": IncomeType.AMCON_COST,
  "Atm Commissions": IncomeType.ATM_COMMISSIONS,
  "Bdc Commissions": IncomeType.BDC_COMMISSIONS,
  "Bills Commissions": IncomeType.BILLS_COMMISSIONS,
  "Cards Fee": IncomeType.CARDS_FEE,
  "Cashlite": IncomeType.CASHLITE,
  "Cash Fees": IncomeType.CASH_FEES,
  "Commissions And Fees": IncomeType.COMMISSIONS_AND_FEES,
  "Commissions Cash Handling": IncomeType.COMMISSIONS_CASH_HANDLING,
  "Commissions Gi": IncomeType.COMMISSIONS_GI,
  "Commissions On Foreign Currency Transfers": IncomeType.COMMISSIONS_ON_FOREIGN_CURRENCY_TRANSFERS,
  "Comm Agric Loans": IncomeType.COMM_AGRIC_LOANS,
  "Deposit Actual Balance": IncomeType.DEPOSIT_ACTUAL_BALANCE,
  "Deposit Average Balance": IncomeType.DEPOSIT_AVERAGE_BALANCE,
  "Direct Expense": IncomeType.DIRECT_EXPENSE,
  "Dividend Income": IncomeType.DIVIDEND_INCOME,
  "Ebusiness Fee": IncomeType.EBUSINESS_FEE,
  "Fcubs Cost": IncomeType.FCUBS_COST,
  "Form A Commissions": IncomeType.FORM_A_COMMISSIONS,
  "Form M Commissions": IncomeType.FORM_M_COMMISSIONS,
  "Ftp Expense": IncomeType.FTP_EXPENSE,
  "Ftp Expense Subsidy": IncomeType.FTP_EXPENSE_SUBSIDY,
  "Ftp Income": IncomeType.FTP_INCOME,
  "Ftp Income Subsidy": IncomeType.FTP_INCOME_SUBSIDY,
  "Fx Gain Or Loss Cards": IncomeType.FX_GAIN_OR_LOSS_CARDS,
  "Fx Income": IncomeType.FX_INCOME,
  "Fx Income Forwards": IncomeType.FX_INCOME_FORWARDS,
  "Fx Income Futures": IncomeType.FX_INCOME_FUTURES,
  "Fx Revaluation": IncomeType.FX_REVALUATION,
  "Gain Equity Investments": IncomeType.GAIN_EQUITY_INVESTMENTS,
  "Interest Expense": IncomeType.INTEREST_EXPENSE,
  "Interest Income": IncomeType.INTEREST_INCOME,
  "Interest Suspense": IncomeType.INTEREST_SUSPENSE,
  "Internet Banking": IncomeType.INTERNET_BANKING,
  "Investment Income": IncomeType.INVESTMENT_INCOME,
  "Lc Commissions": IncomeType.LC_COMMISSIONS,
  "Legal Income": IncomeType.LEGAL_INCOME,
  "Loans Actual Balance": IncomeType.LOANS_ACTUAL_BALANCE,
  "Loans Average Balance": IncomeType.LOANS_AVERAGE_BALANCE,
  "Loan Fees": IncomeType.LOAN_FEES,
  "Loan Recoveries": IncomeType.LOAN_RECOVERIES,
  "Management Technology Fees": IncomeType.MANAGEMENT_TECHNOLOGY_FEES,
  "Marketing Cost": IncomeType.MARKETING_COST,
  "Mobile Banking": IncomeType.MOBILE_BANKING,
  "Mtm Income Bonds": IncomeType.MTM_INCOME_BONDS,
  "Mtm Income Tbills": IncomeType.MTM_INCOME_TBILLS,
  "Ndic Cost": IncomeType.NDIC_COST,
  "Net Ftp Income": IncomeType.NET_FTP_INCOME,
  "Net Income": IncomeType.NET_INCOME,
  "Net Interest Income": IncomeType.NET_INTEREST_INCOME,
  "Operating Expenses": IncomeType.OPERATING_EXPENSES,
  "Other Commissions": IncomeType.OTHER_COMMISSIONS,
  "Other Expense": IncomeType.OTHER_EXPENSE,
  "Other Income": IncomeType.OTHER_INCOME,
  "Payments Collections": IncomeType.PAYMENTS_COLLECTIONS,
  "Pos Commissions": IncomeType.POS_COMMISSIONS,
  "Profit Before Tax": IncomeType.PROFIT_BEFORE_TAX,
  "Remittances": IncomeType.REMITTANCES,
  "Rental Income": IncomeType.RENTAL_INCOME,
  "Rm Staff Costs": IncomeType.RM_STAFF_COSTS,
  "Sms Fee": IncomeType.SMS_FEE,
  "Sundry Income": IncomeType.SUNDRY_INCOME,
  "Trade Actual Balance": IncomeType.TRADE_ACTUAL_BALANCE,
  "Trade Average Balance": IncomeType.TRADE_AVERAGE_BALANCE,
  "Trade Fee": IncomeType.TRADE_FEE,
  "Treasury Income": IncomeType.TREASURY_INCOME
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

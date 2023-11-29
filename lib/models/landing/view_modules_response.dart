import 'dart:convert';

ViewModulesResponse viewModulesResponseFromJson(String str) => ViewModulesResponse.fromJson(json.decode(str));

String viewModulesResponseToJson(ViewModulesResponse data) => json.encode(data.toJson());

class ViewModulesResponse {
  ViewModulesResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  Result result;

  factory ViewModulesResponse.fromJson(Map<String, dynamic> json) => ViewModulesResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.hasAccessToUTrack,
    this.hasAccessToTrialBalance,
    this.hasAccessToBalanceSheet,
    this.hasAccessToUserManagement,
    this.hasAccessToSingleCustomerView,
    this.hasAccessToFraudReportingTool,
    this.hasAccessToPerformanceManagementTracker,
    this.hasAccessToProductCatalogue,
    this.hasAccessToCallManagement,
    this.hasAccessToBudget,
    this.hasAccessToScorecardOthers,
    this.hasAccessToAdjustment,
    this.hasAccessToRaffleDraw,
    this.hasAccessToApr,
    this.hasAccessToDataDictionary,
    this.hasAccessToFinancialModule,
  });

  bool hasAccessToUTrack;
  bool hasAccessToTrialBalance;
  bool hasAccessToBalanceSheet;
  HasAccessToUserManagement hasAccessToUserManagement;
  bool hasAccessToSingleCustomerView;
  HasAccessTo hasAccessToFraudReportingTool;
  bool hasAccessToPerformanceManagementTracker;
  bool hasAccessToProductCatalogue;
  HasAccessToCallManagement hasAccessToCallManagement;
  HasAccessToBudget hasAccessToBudget;
  HasAccessToScorecardOthers hasAccessToScorecardOthers;
  HasAccessToAdjustment hasAccessToAdjustment;
  HasAccessToRaffleDraw hasAccessToRaffleDraw;
  HasAccessToApr hasAccessToApr;
  HasAccessToDataDictionary hasAccessToDataDictionary;
  HasAccessToFinancialModule hasAccessToFinancialModule;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    hasAccessToUTrack: json["hasAccessToUTrack"],
    hasAccessToTrialBalance: json["hasAccessToTrialBalance"],
    hasAccessToBalanceSheet: json["hasAccessToBalanceSheet"],
    hasAccessToUserManagement: HasAccessToUserManagement.fromJson(json["hasAccessToUserManagement"]),
    hasAccessToSingleCustomerView: json["hasAccessToSingleCustomerView"],
    hasAccessToFraudReportingTool: HasAccessTo.fromJson(json["hasAccessToFraudReportingTool"]),
    hasAccessToPerformanceManagementTracker: json["hasAccessToPerformanceManagementTracker"],
    hasAccessToProductCatalogue: json["hasAccessToProductCatalogue"],
    hasAccessToCallManagement: HasAccessToCallManagement.fromJson(json["hasAccessToCallManagement"]),
    hasAccessToBudget: HasAccessToBudget.fromJson(json["hasAccessToBudget"]),
    hasAccessToScorecardOthers: HasAccessToScorecardOthers.fromJson(json["hasAccessToScorecardOthers"]),
    hasAccessToAdjustment: HasAccessToAdjustment.fromJson(json["hasAccessToAdjustment"]),
    hasAccessToRaffleDraw: HasAccessToRaffleDraw.fromJson(json["hasAccessToRaffleDraw"]),
    hasAccessToApr: HasAccessToApr.fromJson(json["hasAccessToApr"]),
    hasAccessToDataDictionary: HasAccessToDataDictionary.fromJson(json["hasAccessToDataDictionary"]),
    hasAccessToFinancialModule: HasAccessToFinancialModule.fromJson(json["hasAccessToFinancialModule"]),
  );

  Map<String, dynamic> toJson() => {
    "hasAccessToUTrack": hasAccessToUTrack,
    "hasAccessToTrialBalance": hasAccessToTrialBalance,
    "hasAccessToBalanceSheet": hasAccessToBalanceSheet,
    "hasAccessToUserManagement": hasAccessToUserManagement.toJson(),
    "hasAccessToSingleCustomerView": hasAccessToSingleCustomerView,
    "hasAccessToFraudReportingTool": hasAccessToFraudReportingTool.toJson(),
    "hasAccessToPerformanceManagementTracker": hasAccessToPerformanceManagementTracker,
    "hasAccessToProductCatalogue": hasAccessToProductCatalogue,
    "hasAccessToCallManagement": hasAccessToCallManagement.toJson(),
    "hasAccessToBudget": hasAccessToBudget.toJson(),
    "hasAccessToScorecardOthers": hasAccessToScorecardOthers.toJson(),
    "hasAccessToAdjustment": hasAccessToAdjustment.toJson(),
    "hasAccessToRaffleDraw": hasAccessToRaffleDraw.toJson(),
    "hasAccessToApr": hasAccessToApr.toJson(),
    "hasAccessToDataDictionary": hasAccessToDataDictionary.toJson(),
    "hasAccessToFinancialModule": hasAccessToFinancialModule.toJson(),
  };
}

class HasAccessToAdjustment {
  HasAccessToAdjustment({
    this.canCreateAdjustment,
    this.canApproveAdjustment,
    this.canViewAdjustment,
  });

  bool canCreateAdjustment;
  bool canApproveAdjustment;
  bool canViewAdjustment;

  factory HasAccessToAdjustment.fromJson(Map<String, dynamic> json) => HasAccessToAdjustment(
    canCreateAdjustment: json["canCreateAdjustment"],
    canApproveAdjustment: json["canApproveAdjustment"],
    canViewAdjustment: json["canViewAdjustment"],
  );

  Map<String, dynamic> toJson() => {
    "canCreateAdjustment": canCreateAdjustment,
    "canApproveAdjustment": canApproveAdjustment,
    "canViewAdjustment": canViewAdjustment,
  };
}

class HasAccessToApr {
  HasAccessToApr({
    this.canViewUserApr,
    this.canViewAdminApr,
  });

  bool canViewUserApr;
  bool canViewAdminApr;

  factory HasAccessToApr.fromJson(Map<String, dynamic> json) => HasAccessToApr(
    canViewUserApr: json["canViewUserApr"],
    canViewAdminApr: json["canViewAdminApr"],
  );

  Map<String, dynamic> toJson() => {
    "canViewUserApr": canViewUserApr,
    "canViewAdminApr": canViewAdminApr,
  };

  @override
  String toString() {
    // TODO: implement toString
    return 'HasAccessToApr{canViewUserApr: $canViewUserApr, canViewAdminApr: $canViewAdminApr}';
  }
}

class HasAccessToBudget {
  HasAccessToBudget({
    this.canAccessBudget,
    this.canAccessBudgetAdmin,
    this.canAccessHrBudget,
  });

  bool canAccessBudget;
  bool canAccessBudgetAdmin;
  bool canAccessHrBudget;

  factory HasAccessToBudget.fromJson(Map<String, dynamic> json) => HasAccessToBudget(
    canAccessBudget: json["canAccessBudget"],
    canAccessBudgetAdmin: json["canAccessBudgetAdmin"],
    canAccessHrBudget: json["canAccessHrBudget"],
  );

  Map<String, dynamic> toJson() => {
    "canAccessBudget": canAccessBudget,
    "canAccessBudgetAdmin": canAccessBudgetAdmin,
    "canAccessHrBudget": canAccessHrBudget,
  };
}

class HasAccessToCallManagement {
  HasAccessToCallManagement({
    this.hasAccessToProspect,
    this.hasAccessToPipelineDeal,
  });

  HasAccessTo hasAccessToProspect;
  HasAccessTo hasAccessToPipelineDeal;

  factory HasAccessToCallManagement.fromJson(Map<String, dynamic> json) => HasAccessToCallManagement(
    hasAccessToProspect: HasAccessTo.fromJson(json["hasAccessToProspect"]),
    hasAccessToPipelineDeal: HasAccessTo.fromJson(json["hasAccessToPipelineDeal"]),
  );

  Map<String, dynamic> toJson() => {
    "hasAccessToProspect": hasAccessToProspect.toJson(),
    "hasAccessToPipelineDeal": hasAccessToPipelineDeal.toJson(),
  };
}

class HasAccessTo {
  HasAccessTo({
    this.canCreate,
    this.canViewReports,
  });

  bool canCreate;
  bool canViewReports;

  factory HasAccessTo.fromJson(Map<String, dynamic> json) => HasAccessTo(
    canCreate: json["canCreate"],
    canViewReports: json["canViewReports"],
  );

  Map<String, dynamic> toJson() => {
    "canCreate": canCreate,
    "canViewReports": canViewReports,
  };

  @override
  String toString() {
    return 'HasAccessTo{canCreate: $canCreate, canViewReports: $canViewReports}';
  }
}

class HasAccessToDataDictionary {
  HasAccessToDataDictionary({
    this.canViewDataDictionary,
  });

  bool canViewDataDictionary;

  factory HasAccessToDataDictionary.fromJson(Map<String, dynamic> json) => HasAccessToDataDictionary(
    canViewDataDictionary: json["canViewDataDictionary"],
  );

  Map<String, dynamic> toJson() => {
    "canViewDataDictionary": canViewDataDictionary,
  };
}

class HasAccessToFinancialModule {
  HasAccessToFinancialModule({
    this.canCreateFinancialModuleAdjustment,
    this.canApproveFinancialModuleAdjustment,
    this.canViewFinancialModule,
  });

  bool canCreateFinancialModuleAdjustment;
  bool canApproveFinancialModuleAdjustment;
  bool canViewFinancialModule;

  factory HasAccessToFinancialModule.fromJson(Map<String, dynamic> json) => HasAccessToFinancialModule(
    canCreateFinancialModuleAdjustment: json["canCreateFinancialModuleAdjustment"],
    canApproveFinancialModuleAdjustment: json["canApproveFinancialModuleAdjustment"],
    canViewFinancialModule: json["canViewFinancialModule"],
  );

  Map<String, dynamic> toJson() => {
    "canCreateFinancialModuleAdjustment": canCreateFinancialModuleAdjustment,
    "canApproveFinancialModuleAdjustment": canApproveFinancialModuleAdjustment,
    "canViewFinancialModule": canViewFinancialModule,
  };
}

class HasAccessToRaffleDraw {
  HasAccessToRaffleDraw({
    this.canViewRaffleDraw,
  });

  bool canViewRaffleDraw;

  factory HasAccessToRaffleDraw.fromJson(Map<String, dynamic> json) => HasAccessToRaffleDraw(
    canViewRaffleDraw: json["canViewRaffleDraw"],
  );

  Map<String, dynamic> toJson() => {
    "canViewRaffleDraw": canViewRaffleDraw,
  };
}

class HasAccessToScorecardOthers {
  HasAccessToScorecardOthers({
    this.canAccessBranchServicesApp,
    this.canAccessServiceAssuranceApp,
  });

  bool canAccessBranchServicesApp;
  bool canAccessServiceAssuranceApp;

  factory HasAccessToScorecardOthers.fromJson(Map<String, dynamic> json) => HasAccessToScorecardOthers(
    canAccessBranchServicesApp: json["canAccessBranchServicesApp"],
    canAccessServiceAssuranceApp: json["canAccessServiceAssuranceApp"],
  );

  Map<String, dynamic> toJson() => {
    "canAccessBranchServicesApp": canAccessBranchServicesApp,
    "canAccessServiceAssuranceApp": canAccessServiceAssuranceApp,
  };
}

class HasAccessToUserManagement {
  HasAccessToUserManagement({
    this.hasAccessToAuditLog,
    this.hasAccessToCreateRole,
    this.hasAccessToCreateUser,
    this.hasAccessToConfigureAlero,
  });

  bool hasAccessToAuditLog;
  bool hasAccessToCreateRole;
  bool hasAccessToCreateUser;
  bool hasAccessToConfigureAlero;

  factory HasAccessToUserManagement.fromJson(Map<String, dynamic> json) => HasAccessToUserManagement(
    hasAccessToAuditLog: json["hasAccessToAuditLog"],
    hasAccessToCreateRole: json["hasAccessToCreateRole"],
    hasAccessToCreateUser: json["hasAccessToCreateUser"],
    hasAccessToConfigureAlero: json["hasAccessToConfigureAlero"],
  );

  Map<String, dynamic> toJson() => {
    "hasAccessToAuditLog": hasAccessToAuditLog,
    "hasAccessToCreateRole": hasAccessToCreateRole,
    "hasAccessToCreateUser": hasAccessToCreateUser,
    "hasAccessToConfigureAlero": hasAccessToConfigureAlero,
  };
}

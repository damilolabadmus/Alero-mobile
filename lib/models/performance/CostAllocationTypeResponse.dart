import 'dart:convert';

List<CostAllocationTypeResponse> costAllocationTypeResponseFromJson(String str) => List<CostAllocationTypeResponse>.from(json.decode(str).map((x) => CostAllocationTypeResponse.fromJson(x)));

String costAllocationTypeResponseToJson(List<CostAllocationTypeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostAllocationTypeResponse {
    String expenseGroup;
    double commercial;
    double corporate;
    double retail;
    double sme;
    double treasury;
    int corporateFunctions;
    int finance;
    int riskMgt;
    int serviceTechnology;
    double entrprise;
    int mdPool;
    String expenseType;
    int expensePosition;
    String expensePeriod;
    dynamic deptCode;
    dynamic deptName;
    dynamic criteriaCode;
    dynamic criteriaCodeName;
    int criteriaSum;

    CostAllocationTypeResponse({
        this.expenseGroup,
        this.commercial,
        this.corporate,
        this.retail,
        this.sme,
        this.treasury,
        this.corporateFunctions,
        this.finance,
        this.riskMgt,
        this.serviceTechnology,
        this.entrprise,
        this.mdPool,
        this.expenseType,
        this.expensePosition,
        this.expensePeriod,
        this.deptCode,
        this.deptName,
        this.criteriaCode,
        this.criteriaCodeName,
        this.criteriaSum,
    });

    factory CostAllocationTypeResponse.fromJson(Map<String, dynamic> json) => CostAllocationTypeResponse(
        expenseGroup: json["expenseGroup"],
        commercial: json["commercial"].toDouble(),
        corporate: json["corporate"].toDouble(),
        retail: json["retail"].toDouble(),
        sme: json["sme"].toDouble(),
        treasury: json["treasury"].toDouble(),
        corporateFunctions: json["corporateFunctions"],
        finance: json["finance"],
        riskMgt: json["riskMgt"],
        serviceTechnology: json["serviceTechnology"],
        entrprise: json["entrprise"].toDouble(),
        mdPool: json["mdPool"],
        expenseType: json["expenseType"],
        expensePosition: json["expensePosition"],
        expensePeriod: json["expensePeriod"],
        deptCode: json["deptCode"],
        deptName: json["deptName"],
        criteriaCode: json["criteriaCode"] ?? 0,
        criteriaCodeName: json["criteriaCodeName"],
        criteriaSum: json["criteriaSum"],
    );

    Map<String, dynamic> toJson() => {
        "expenseGroup": expenseGroup,
        "commercial": commercial,
        "corporate": corporate,
        "retail": retail,
        "sme": sme,
        "treasury": treasury,
        "corporateFunctions": corporateFunctions,
        "finance": finance,
        "riskMgt": riskMgt,
        "serviceTechnology": serviceTechnology,
        "entrprise": entrprise,
        "mdPool": mdPool,
        "expenseType": expenseType,
        "expensePosition": expensePosition,
        "expensePeriod": expensePeriod,
        "deptCode": deptCode,
        "deptName": deptName,
        "criteriaCode": criteriaCode,
        "criteriaCodeName": criteriaCodeName,
        "criteriaSum": criteriaSum,
    };
}

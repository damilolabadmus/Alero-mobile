

import 'dart:convert';

ProfitabilityReportResponse profitabilityReportResponseFromJson(String str) => ProfitabilityReportResponse.fromJson(json.decode(str));

String profitabilityReportResponseToJson(ProfitabilityReportResponse data) => json.encode(data.toJson());

class ProfitabilityReportResponse {
  ProfitabilityReportResponse({
    this.plScorecards,
    this.bsActualScorecards,
    this.bsAverageScorecards,
    this.nrffScorecards,
  });

  List<dynamic>? plScorecards;
  List<BsAScorecard>? bsActualScorecards;
  List<BsAScorecard>? bsAverageScorecards;
  List<dynamic>? nrffScorecards;

  factory ProfitabilityReportResponse.fromJson(Map<String, dynamic> json) => ProfitabilityReportResponse(
    plScorecards: List<dynamic>.from(json["plScorecards"].map((x) => x)),
    bsActualScorecards: List<BsAScorecard>.from(json["bsActualScorecards"].map((x) => BsAScorecard.fromJson(x))),
    bsAverageScorecards: List<BsAScorecard>.from(json["bsAverageScorecards"].map((x) => BsAScorecard.fromJson(x))),
    nrffScorecards: List<dynamic>.from(json["nrffScorecards"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "plScorecards": List<dynamic>.from(plScorecards!.map((x) => x)),
    "bsActualScorecards": List<dynamic>.from(bsActualScorecards!.map((x) => x.toJson())),
    "bsAverageScorecards": List<dynamic>.from(bsAverageScorecards!.map((x) => x.toJson())),
    "nrffScorecards": List<dynamic>.from(nrffScorecards!.map((x) => x)),
  };
}

class BsAScorecard {
  BsAScorecard({
    this.categoryCode,
    this.categoryDescription,
    this.parentCategoryCode,
    this.parentCategoryDescription,
    this.segmentCode,
    this.businessSegment,
    this.amount,
    this.period,
    this.reportType,
    this.product,
    this.productPosition,
    this.productType,
    this.productTypePosition,
    this.productGroup,
    this.productGroupPosition,
  });

  CategoryCode? categoryCode;
  CategoryDescription? categoryDescription;
  ParentCategoryCode? parentCategoryCode;
  ParentCategoryDescription? parentCategoryDescription;
  SegmentCode? segmentCode;
  BusinessSegment? businessSegment;
  double? amount;
  String? period;
  ReportType? reportType;
  String? product;
  int? productPosition;
  ProductType? productType;
  int? productTypePosition;
  ProductGroup? productGroup;
  int? productGroupPosition;

  factory BsAScorecard.fromJson(Map<String, dynamic> json) => BsAScorecard(
    categoryCode: categoryCodeValues.map[json["categoryCode"]],
    categoryDescription: categoryDescriptionValues.map[json["categoryDescription"]],
    parentCategoryCode: parentCategoryCodeValues.map[json["parentCategoryCode"]],
    parentCategoryDescription: parentCategoryDescriptionValues.map[json["parentCategoryDescription"]],
    segmentCode: segmentCodeValues.map[json["segmentCode"]],
    businessSegment: businessSegmentValues.map[json["businessSegment"]],
    amount: json["amount"].toDouble(),
    period: json["period"],
    reportType: reportTypeValues.map[json["reportType"]],
    product: json["product"],
    productPosition: json["productPosition"],
    productType: productTypeValues.map[json["productType"]],
    productTypePosition: json["productTypePosition"],
    productGroup: productGroupValues.map[json["productGroup"]],
    productGroupPosition: json["productGroupPosition"],
  );

  Map<String, dynamic> toJson() => {
    "categoryCode": categoryCodeValues.reverse[categoryCode],
    "categoryDescription": categoryDescriptionValues.reverse[categoryDescription],
    "parentCategoryCode": parentCategoryCodeValues.reverse[parentCategoryCode],
    "parentCategoryDescription": parentCategoryDescriptionValues.reverse[parentCategoryDescription],
    "segmentCode": segmentCodeValues.reverse[segmentCode],
    "businessSegment": businessSegmentValues.reverse[businessSegment],
    "amount": amount,
    "period": period,
    "reportType": reportTypeValues.reverse[reportType],
    "product": product,
    "productPosition": productPosition,
    "productType": productTypeValues.reverse[productType],
    "productTypePosition": productTypePosition,
    "productGroup": productGroupValues.reverse[productGroup],
    "productGroupPosition": productGroupPosition,
  };
}

enum BusinessSegment { COMMERCIAL }

final businessSegmentValues = EnumValues({
  "COMMERCIAL": BusinessSegment.COMMERCIAL
});

enum CategoryCode { C0341, C0401, C0601 }

final categoryCodeValues = EnumValues({
  "C0341": CategoryCode.C0341,
  "C0401": CategoryCode.C0401,
  "C0601": CategoryCode.C0601
});

enum CategoryDescription { ABEOKUTA, ADO_EKITI_MAIN, AKURE_MAIN }

final categoryDescriptionValues = EnumValues({
  "Abeokuta": CategoryDescription.ABEOKUTA,
  "Ado-Ekiti Main": CategoryDescription.ADO_EKITI_MAIN,
  "Akure Main": CategoryDescription.AKURE_MAIN
});

enum ParentCategoryCode { C4002 }

final parentCategoryCodeValues = EnumValues({
  "C4002": ParentCategoryCode.C4002
});

enum ParentCategoryDescription { AKURE }

final parentCategoryDescriptionValues = EnumValues({
  "Akure": ParentCategoryDescription.AKURE
});

enum ProductGroup { LIABILITIES, ASSETS }

final productGroupValues = EnumValues({
  "ASSETS": ProductGroup.ASSETS,
  "LIABILITIES": ProductGroup.LIABILITIES
});

enum ProductType { DEPOSIT, LOAN, OTHLIAB }

final productTypeValues = EnumValues({
  "DEPOSIT": ProductType.DEPOSIT,
  "LOAN": ProductType.LOAN,
  "OTHLIAB": ProductType.OTHLIAB
});

enum ReportType { ACTUAL }

final reportTypeValues = EnumValues({
  "ACTUAL": ReportType.ACTUAL
});

enum SegmentCode { COM_230, COM_220, COM_210, COM_205 }

final segmentCodeValues = EnumValues({
  "COM_205": SegmentCode.COM_205,
  "COM_210": SegmentCode.COM_210,
  "COM_220": SegmentCode.COM_220,
  "COM_230": SegmentCode.COM_230
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

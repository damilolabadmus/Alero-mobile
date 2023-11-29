import 'dart:convert';

List<MyBalanceSheetRmResponse> myBalanceSheetRmResponseFromJson(String str) => List<MyBalanceSheetRmResponse>.from(json.decode(str).map((x) => MyBalanceSheetRmResponse.fromJson(x)));

String myBalanceSheetRmResponseToJson(List<MyBalanceSheetRmResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBalanceSheetRmResponse {
  dynamic format;
  dynamic breakdown;
  dynamic position;
  dynamic prodPosition;
  dynamic catCode;
  dynamic category;
  dynamic supCatCode;
  dynamic supCategory;
  dynamic segment;
  dynamic product;
  dynamic productSubCategory;
  dynamic productCategory;
  dynamic currentBalance;
  dynamic previousBal;
  dynamic variance;
  dynamic monthEndBalance;
  dynamic varianceFromMonthEnd;
  dynamic budget;
  dynamic varianceFromBudget;
  dynamic achievementPercent;

  MyBalanceSheetRmResponse({
    this.format,
    this.breakdown,
    this.position,
    this.prodPosition,
    this.catCode,
    this.category,
    this.supCatCode,
    this.supCategory,
    this.segment,
    this.product,
    this.productSubCategory,
    this.productCategory,
    this.currentBalance,
    this.previousBal,
    this.variance,
    this.monthEndBalance,
    this.varianceFromMonthEnd,
    this.budget,
    this.varianceFromBudget,
    this.achievementPercent,
  });

  factory MyBalanceSheetRmResponse.fromJson(Map<String, dynamic> json) => MyBalanceSheetRmResponse(
    format: json["format"],
    breakdown: json["breakdown"],
    position: json["position"],
    prodPosition: json["prodPosition"] == null ? 0 : json["prodPosition"],
    catCode: json["catCode"] == null ? ' ' : json["catCode"],
    category: json["category"] == null ? ' ' : json["category"],
    supCatCode: json["supCatCode"] == null ? 0 : json["supCatCode"],
    supCategory: json["supCategory"] == null ? ' ' : json["supCategory"],
    segment: json["segment"] == null ? ' ' : json["segment"],
    product: json["product"] == null ? ' ' : json["product"],
    productSubCategory: json["productSubCategory"] == null ? ' ' : json["productSubCategory"],
    productCategory: json["productCategory"] == null ? ' ' : json["productCategory"],
    currentBalance: json["currentBalance"] == null ? 0.0 : json["currentBalance"],
    previousBal: json["previousBal"] == null ? 0.0 : json["previousBal"],
    variance: json["variance"] == null ? 0.0 : json["variance"],
    monthEndBalance: json["monthEndBalance"] == null ? 0.0 : json["monthEndBalance"],
    varianceFromMonthEnd: json["varianceFromMonthEnd"] == null ? 0.0 : json["varianceFromMonthEnd"],
    budget: json["budget"] == null ? 0 : json["budget"],
    varianceFromBudget: json["varianceFromBudget"] == null ? 0.0 : json["varianceFromBudget"],
    achievementPercent: json["achievementPercent"] == null ? 0 : json["achievementPercent"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "breakdown": breakdown,
    "position": position,
    "prodPosition": prodPosition,
    "catCode": catCode,
    "category": category,
    "supCatCode": supCatCode,
    "supCategory": supCategory,
    "segment": segment,
    "product": product,
    "productSubCategory": productSubCategory,
    "productCategory": productCategory,
    "currentBalance": currentBalance,
    "previousBal": previousBal,
    "variance": variance,
    "monthEndBalance": monthEndBalance,
    "varianceFromMonthEnd": varianceFromMonthEnd,
    "budget": budget,
    "varianceFromBudget": varianceFromBudget,
    "achievementPercent": achievementPercent,
  };
}

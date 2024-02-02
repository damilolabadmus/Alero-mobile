

import 'dart:convert';
List<MyBalanceSheetResponse> myBalanceSheetResponseFromJson(String str) =>
    List<MyBalanceSheetResponse>.from(json.decode(str).map((x) => MyBalanceSheetResponse.fromJson(x)));

String myBalanceSheetResponseToJson(List<MyBalanceSheetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBalanceSheetResponse {
  MyBalanceSheetResponse({
    this.format,
    this.breakdown,
    this.position,
    this.productCategory,
    this.product,
    this.currentBalance,
    this.previousBal,
    this.variance,
    this.monthEndBalance,
    this.varianceFromMonthEnd,
    this.budget,
    this.varianceFromBudget,
    this.achievementPercent,
  });

  dynamic format;
  dynamic breakdown;
  int? position;
  String? productCategory;
  String? product;
  dynamic currentBalance;
  dynamic previousBal;
  dynamic variance;
  dynamic monthEndBalance;
  dynamic varianceFromMonthEnd;
  dynamic budget;
  dynamic varianceFromBudget;
  dynamic achievementPercent;

  factory MyBalanceSheetResponse.fromJson(Map<String, dynamic> json) => MyBalanceSheetResponse(
    format: json["format"],
    breakdown: json["breakdown"],
    position: json["position"],
    productCategory: json["productCategory"] == null ? 'No Data' : json["productCategory"],
    product: json["product"] == null ? 'No Data' : json["product"],
    currentBalance: json["currentBalance"] == null ? 0.0 : json["currentBalance"],
    previousBal: json["previousBal"] == null ? 0.0 : json["previousBal"],
    variance: json["variance"] == null ? 0.0 : json["variance"],
    monthEndBalance: json["monthEndBalance"] == null ? 0.0 : json["monthEndBalance"],
    varianceFromMonthEnd: json["varianceFromMonthEnd"] == null ? 0.0 : json["varianceFromMonthEnd"],
    budget: json["budget"] == null ? 0.0 : json["budget"],
    varianceFromBudget: json["varianceFromBudget"] == null ? 0.0 : json["varianceFromBudget"],
    achievementPercent: json["achievementPercent"] == null ? 0.0 : json["achievementPercent"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "breakdown": breakdown,
    "position": position,
    "productCategory": productCategory,
    "product": product,
    "currentBalance": currentBalance,
    "previousBal": previousBal,
    "variance": variance,
    "monthEndBalance": monthEndBalance,
    "varianceFromMonthEnd": varianceFromMonthEnd,
    "budget": budget,
    "varianceFromBudget": varianceFromBudget,
    "achievementPercent": achievementPercent,
  };

  @override
  String toString() {
    return 'MyBalanceSheetResponse{format: $format, breakdown: $breakdown, position: $position, productCategory: $productCategory, product: $product, currentBalance: $currentBalance, previousBal: $previousBal, variance: $variance, monthEndBalance: $monthEndBalance, varianceFromMonthEnd: $varianceFromMonthEnd, budget: $budget, varianceFromBudget: $varianceFromBudget, achievementPercent: $achievementPercent}';
  }
}

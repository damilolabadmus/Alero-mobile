import 'dart:convert';

List<MyBalanceSheetTypeResponse> myBalanceSheetTypeResponseFromJson(String str) => List<MyBalanceSheetTypeResponse>.from(json.decode(str).map((x) => MyBalanceSheetTypeResponse.fromJson(x)));

String myBalanceSheetSecondResponseToJson(List<MyBalanceSheetTypeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBalanceSheetTypeResponse {
  dynamic reportCategory;
  dynamic reportType;
  dynamic segmentCode;
  dynamic businessSegment;
  dynamic categoryCode;
  dynamic categoryDescription;
  dynamic parentCategoryCode;
  dynamic parentCategoryDescription;
  dynamic currentBalance;
  dynamic previousBalance;
  dynamic variance;
  dynamic monthEndBalance;
  dynamic monthEndVariance;
  dynamic categoryType;
  dynamic categoryTypePosition;
  dynamic categoryGroup;
  dynamic categoryGroupPosition;
  dynamic product;
  dynamic productPosition;

  MyBalanceSheetTypeResponse({
    this.reportCategory,
    this.reportType,
    this.segmentCode,
    this.businessSegment,
    this.categoryCode,
    this.categoryDescription,
    this.parentCategoryCode,
    this.parentCategoryDescription,
    this.currentBalance,
    this.previousBalance,
    this.variance,
    this.monthEndBalance,
    this.monthEndVariance,
    this.categoryType,
    this.categoryTypePosition,
    this.categoryGroup,
    this.categoryGroupPosition,
    this.product,
    this.productPosition,
  });

  factory MyBalanceSheetTypeResponse.fromJson(Map<String, dynamic> json) => MyBalanceSheetTypeResponse(
    reportCategory: json["reportCategory"] == null ? ' ' : json["reportCategory"],
    reportType: json["reportType"] == null ? ' ' : json["reportType"],
    segmentCode: json["segmentCode"] == null ? 0 : json["segmentCode"],
    businessSegment: json["businessSegment"] == null ? ' ' : json["businessSegment"] ,
    categoryCode: json["categoryCode"] == null ? 0 : json["categoryCode"] ,
    categoryDescription: json["categoryDescription"] == null ? ' ' : json["categoryDescription"],
    parentCategoryCode: json["parentCategoryCode"] == null ? 0 : json["parentCategoryCode"],
    parentCategoryDescription: json["parentCategoryDescription"] == null ? ' ' : json["parentCategoryDescription"],
    currentBalance: json["currentBalance"] == null ? 0.0 : json["currentBalance"],
    previousBalance: json["previousBalance"] == null ? 0.0 : json["previousBalance"],
    variance: json["variance"] == null ? 0.0 : json["variance"].toDouble(),
    monthEndBalance: json["monthEndBalance"] == null ? 0.0 : json["monthEndBalance"],
    monthEndVariance: json["monthEndVariance"] == null ? 0.0 : json["monthEndVariance"],
    categoryType: json["categoryType"] == null ? ' ' : json["categoryType"],
    categoryTypePosition: json["categoryTypePosition"] == null ? ' ' : json["categoryTypePosition"],
    categoryGroup: json["categoryGroup"] == null ? ' ' : json["categoryGroup"],
    categoryGroupPosition: json["categoryGroupPosition"] == null ? ' ' : json["categoryGroupPosition"],
    product: json["product"] == null ? ' ' : json["product"],
    productPosition: json["productPosition"] == null ? 0 : json["productPosition"],
  );

  Map<String, dynamic> toJson() => {
    "reportCategory": reportCategory,
    "reportType": reportType,
    "segmentCode": segmentCode,
    "businessSegment": businessSegment,
    "categoryCode": categoryCode,
    "categoryDescription": categoryDescription,
    "parentCategoryCode": parentCategoryCode,
    "parentCategoryDescription": parentCategoryDescription,
    "currentBalance": currentBalance,
    "previousBalance": previousBalance,
    "variance": variance,
    "monthEndBalance": monthEndBalance,
    "monthEndVariance": monthEndVariance,
    "categoryType": categoryType,
    "categoryTypePosition": categoryTypePosition,
    "categoryGroup": categoryGroup,
    "categoryGroupPosition": categoryGroupPosition,
    "product": product,
    "productPosition": productPosition,
  };

  @override
  String toString() {
    return 'MyBalanceSheetTypeResponse{reportCategory: $reportCategory, reportType: $reportType, segmentCode: $segmentCode, businessSegment: $businessSegment, categoryCode: $categoryCode, categoryDescription: $categoryDescription, parentCategoryCode: $parentCategoryCode, currentBalance: $currentBalance, previousBalance: $previousBalance, variance: $variance, monthEndBalance: $monthEndBalance, monthEndVariance: $monthEndVariance, categoryType: $categoryType, categoryTypePosition: $categoryTypePosition, categoryGroup: $categoryGroup, categoryGroupPosition: $categoryGroupPosition,product: $product, productPosition: $productPosition}';
  }
}

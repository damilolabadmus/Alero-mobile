import 'dart:convert';

DealsItemsResponse dealsItemsResponseFromJson(String str) => DealsItemsResponse.fromJson(json.decode(str));

String dealsItemsResponseToJson(DealsItemsResponse data) => json.encode(data.toJson());

class DealsItemsResponse {
  DealsItemsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  Result result;

  factory DealsItemsResponse.fromJson(Map<String, dynamic> json) => DealsItemsResponse(
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
  int _allDeals;
  int _convertedDeals;
  int _completedDeals;
  int _declinedDeals;
  double _conversionRate;
  double _allDealsValue;
  double _convertedDealsValue;
  double _completedDealsValue;
  double _declinedDealsValue;

  Result({
    int allDeals,
    int convertedDeals,
    int completedDeals,
    int declinedDeals,
    double conversionRate,
    double allDealsValue,
    double convertedDealsValue,
    double completedDealsValue,
    double declinedDealsValue,
  }) {
    this._allDeals = allDeals;
    this._convertedDeals = convertedDeals;
    this._completedDeals = completedDeals;
    this._declinedDeals = declinedDeals;
    this._conversionRate = conversionRate;
    this._allDealsValue = allDealsValue;
    this._convertedDealsValue = convertedDealsValue;
    this._completedDealsValue = completedDealsValue;
    this._declinedDealsValue = declinedDealsValue;
  }

  int get allDeals => _allDeals;
  set allDeals(int allDeals) => _allDeals = allDeals;
  int get convertedDeals => _convertedDeals;
  set convertedDeals(int convertedDeals) => _convertedDeals = convertedDeals;
  int get completedDeals => _completedDeals;
  set completedDeals(int completedDeals) => _completedDeals = completedDeals;
  int get declinedDeals => _declinedDeals;
  set declinedDeals(int declinedDeals) => _declinedDeals = declinedDeals;
  double get conversionRate => _conversionRate;
  set conversionRate(double conversionRate) => _conversionRate = conversionRate;
  double get allDealsValue => _allDealsValue;
  set allDealsValue(double allDealsValue) => _allDealsValue = allDealsValue;
  double get convertedDealsValue => _completedDealsValue;
  set convertedDealsValue(double convertedDealsValue) => _convertedDealsValue = convertedDealsValue;
  double get completedDealsValue => _completedDealsValue;
  set completedDealsValue(double completedDealsValue) => _completedDealsValue = completedDealsValue;
  double get declinedDealsValue => _declinedDealsValue;
  set declinedDealsValue(double declinedDealsValue) => _declinedDealsValue = declinedDealsValue;

  Result.fromJson(Map<String, dynamic> json) {
    _allDeals = json["allDeals"];
    _convertedDeals = json["convertedDeals"];
    _completedDeals = json["completedDeals"];
    _declinedDeals = json["declinedDeals"];
    _conversionRate = json["conversionRate"];
    _allDealsValue = json["allDealsValue"];
    _convertedDealsValue = json["convertedDealsValue"];
    _completedDealsValue = json["completedDealsValue"];
    _declinedDealsValue = json["declinedDealsValue"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["allDeals"] = this._allDeals;
    data["convertedDeals"] = this._convertedDeals;
    data["completedDeals"] = this._completedDeals;
    data["declinedDeals"] = this._declinedDeals;
    data["conversionRate"] = this._conversionRate;
    data["allDealsValue"] = this._allDealsValue;
    data["convertedDealsValue"] = this._convertedDealsValue;
    data["completedDealsValue"] = this._completedDealsValue;
    data["declinedDealsValue"] = this._declinedDealsValue;
    return data;
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      allDeals: map["allDeals"]?.toInt() ?? 0,
      convertedDeals: map["convertedDeals"]?.toInt() ?? 0,
      completedDeals: map["completedDeals"]?.toInt() ?? 0,
      declinedDeals: map["declinedDeals"]?.toInt() ?? 0,
      conversionRate: map["conversionRate"]?.toDouble() ?? 0.0,
      allDealsValue: map["allDealsValue"]?.toDouble() ?? 0.0,
      convertedDealsValue: map["convertedDealsValue"]?.toDouble() ?? 0.0,
      completedDealsValue: map["completedDealsValue"]?.toDouble() ?? 0.0,
      declinedDealsValue: map["declinedDealsValue"]?.toDouble() ?? 0.0,
    );
  }
}

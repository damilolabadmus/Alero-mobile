

import 'dart:convert';

CurrencyDetailsResponse currencyDetailsResponseFromJson(String str) => CurrencyDetailsResponse.fromJson(json.decode(str));

String currencyDetailsResponseToJson(CurrencyDetailsResponse data) => json.encode(data.toJson());

class CurrencyDetailsResponse {
  CurrencyDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String? responseCode;
  String? responseDescription;
  List<Result>? result;

  factory CurrencyDetailsResponse.fromJson(Map<String, dynamic> json) => CurrencyDetailsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.currencyName,
    this.currencyCode,
  });

  String? currencyName;
  String? currencyCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    currencyName: json["currencyName"],
    currencyCode: json["currencyCode"],
  );

  Map<String, dynamic> toJson() => {
    "currencyName": currencyName,
    "currencyCode": currencyCode,
  };

  @override
  String toString() {
    return 'Result{currencyName: $currencyName, currencyCode: $currencyCode}';
  }
}

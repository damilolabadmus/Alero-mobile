import 'dart:convert';

DealsByProductsResponse dealsByProductsResponseFromJson(String str) => DealsByProductsResponse.fromJson(json.decode(str));

String dealsByProductsResponseToJson(DealsByProductsResponse data) => json.encode(data.toJson());

class DealsByProductsResponse {
  DealsByProductsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  List<Result> result;

  factory DealsByProductsResponse.fromJson(Map<String, dynamic> json) => DealsByProductsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String _currency;
  int _count;
  double _value;
  String _product;

  Result({
    String currency,
    int count,
    double value,
    String product,
  }) {
    this._currency = currency;
    this._count = count;
    this._value = value;
    this._product = product;
  }

  String get currency => _currency;
  set currency(String currency) => _currency = currency;
  int get count => _count;
  set count(int count) => _count = count;
  double get value => _value;
  set value(double value) => _value = value;
  String get product => _product;
  set product(String product) => _product = product;

  Result.fromJson(Map<String, dynamic> json) {
    _currency = json['currency'];
    _count = json['count'];
    _value = json['value'];
    _product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this._currency;
    data['count'] = this._count;
    data['value'] = this._value;
    data['product'] = this._product;
    return data;
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      currency: map['currency'] ?? '',
      count: map['count']?.toInt() ?? 0,
      value: map['value']?.toDouble() ?? 0.0,
      product: map['product'] ?? '',
    );
  }
}

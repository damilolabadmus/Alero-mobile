import 'dart:convert';

DealsByCurrencyResponse dealsByCurrencyResponseFromJson(String str) => DealsByCurrencyResponse.fromJson(json.decode(str));

String dealsByCurrencyResponseToJson(DealsByCurrencyResponse data) => json.encode(data.toJson());

class DealsByCurrencyResponse {
  DealsByCurrencyResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  List<DealByCurrencyResponse> result;

  factory DealsByCurrencyResponse.fromJson(Map<String, dynamic> json) => DealsByCurrencyResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<DealByCurrencyResponse>.from(json["result"].map((x) => DealByCurrencyResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class DealByCurrencyResponse {
  String _currency;
  int _count;

  DealByCurrencyResponse({
    String currency, int count,
  }) {
    this._currency = currency;
    this._count = count;
  }

  String get currency => _currency;
  set currency(String currency) => _currency = currency;
  int get count => _count;
  set count(int count) => _count = count;

  DealByCurrencyResponse.fromJson(Map<String, dynamic> json) {
    _currency = json['currency'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this._currency;
    data['count'] = this._count;
    return data;
  }

  factory DealByCurrencyResponse.fromMap(Map<String, dynamic> map) {
    return DealByCurrencyResponse(
      currency: map['currency'] ?? '',
      count: map['count']?.toInt() ?? 0,
    );
  }
}

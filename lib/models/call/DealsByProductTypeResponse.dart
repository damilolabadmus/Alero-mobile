

import 'dart:convert';

DealsByProductTypeResponse dealsByProductTypeResponseFromJson(String str) => DealsByProductTypeResponse.fromJson(json.decode(str));

String dealsByProductTypeResponseToJson(DealsByProductTypeResponse data) => json.encode(data.toJson());

class DealsByProductTypeResponse {
  DealsByProductTypeResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String? responseCode;
  String? responseDescription;
  List<DealByProductTypeResponse>? result;

  factory DealsByProductTypeResponse.fromJson(Map<String, dynamic> json) => DealsByProductTypeResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<DealByProductTypeResponse>.from(json["result"].map((x) => DealByProductTypeResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class DealByProductTypeResponse {
  int? _count;
  String? _product;

  DealByProductTypeResponse(
      {int? count,
        String? product}) {
    this._count = count;
    this._product = product;
  }

  int? get count => _count;
  set count(int? count) => _count = count;
  String? get product => _product;
  set product(String? product) => _product = product;

  DealByProductTypeResponse.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['product'] = this._product;
    return data;
  }

  factory DealByProductTypeResponse.fromMap(Map<String, dynamic> map) {
    return DealByProductTypeResponse(
      count: map['count']?.toInt() ?? 0,
      product: map['product'] ?? '',
    );
  }
}

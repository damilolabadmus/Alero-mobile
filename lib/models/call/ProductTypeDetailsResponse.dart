// To parse this JSON data, do
//
//     final productTypeDetailsResponse = productTypeDetailsResponseFromJson(jsonString);

import 'dart:convert';

ProductTypeDetailsResponse productTypeDetailsResponseFromJson(String str) => ProductTypeDetailsResponse.fromJson(json.decode(str));

String productTypeDetailsResponseToJson(ProductTypeDetailsResponse data) => json.encode(data.toJson());

class ProductTypeDetailsResponse {
  ProductTypeDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  List<ProductDetails> result;

  factory ProductTypeDetailsResponse.fromJson(Map<String, dynamic> json) => ProductTypeDetailsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<ProductDetails>.from(json["result"].map((x) => ProductDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ProductDetails {
  ProductDetails({
    this.productId,
    this.product,
    this.transactionTypes,
    this.startDate,
    this.tenor,
    this.amount,
    this.currency,
    this.feesRate,
    this.interestRate,
    this.netInterestMargin,
    this.dealProbability,
    this.isCustomerOnboarded,
    this.statusUpdate1,
    this.statusUpdate2,
  });

  String productId;
  String product;
  List<TransactionType> transactionTypes;
  String startDate;
  String tenor;
  String amount;
  String currency;
  String feesRate;
  String interestRate;
  String netInterestMargin;
  String dealProbability;
  String isCustomerOnboarded;
  String statusUpdate1;
  String statusUpdate2;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    productId: json["productId"],
    product: json["product"],
    transactionTypes: List<TransactionType>.from(json["transactionTypes"].map((x) => TransactionType.fromJson(x))),
    startDate: json["startDate"],
    tenor: json["tenor"],
    amount: json["amount"],
    currency: json["currency"],
    feesRate: json["feesRate"],
    interestRate: json["interestRate"],
    netInterestMargin: json["netInterestMargin"],
    dealProbability: json["dealProbability"],
    isCustomerOnboarded: json["isCustomerOnboarded"],
    statusUpdate1: json["statusUpdate1"],
    statusUpdate2: json["statusUpdate2"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "product": product,
    "transactionTypes": List<dynamic>.from(transactionTypes.map((x) => x.toJson())),
    "startDate": startDate,
    "tenor": tenor,
    "amount": amount,
    "currency": currency,
    "feesRate": feesRate,
    "interestRate": interestRate,
    "netInterestMargin": netInterestMargin,
    "dealProbability": dealProbability,
    "isCustomerOnboarded": isCustomerOnboarded,
    "statusUpdate1": statusUpdate1,
    "statusUpdate2": statusUpdate2,
  };
}

class TransactionType {
  TransactionType({
    this.transaction,
  });

  String transaction;

  factory TransactionType.fromJson(Map<String, dynamic> json) => TransactionType(
    transaction: json["transaction"],
  );

  Map<String, dynamic> toJson() => {
    "transaction": transaction,
  };
}

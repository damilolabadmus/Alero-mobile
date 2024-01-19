import 'dart:convert';

List<NrffResponse> nrffResponseFromJson(String str) => List<NrffResponse>.from(json.decode(str).map((x) => NrffResponse.fromJson(x)));

String nrffResponseToJson(List<NrffResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NrffResponse {
  String product;
  dynamic actualValue;
  dynamic averageValue;
  dynamic interestExpense;
  dynamic effInRate;
  dynamic ftpExpense;
  dynamic effFtpRate;
  dynamic nrff;

  NrffResponse({
    this.product,
    this.actualValue,
    this.averageValue,
    this.interestExpense,
    this.effInRate,
    this.ftpExpense,
    this.effFtpRate,
    this.nrff,
  });

  factory NrffResponse.fromJson(Map<String, dynamic> json) => NrffResponse(
    product: json["Product"] == null ? '-' : json["Product"],
    actualValue: json["ActualValue"] == null ? 0.0 : json["ActualValue"],
    averageValue: json["AverageValue"] == null ? 0.0 : json["AverageValue"],
    interestExpense: json["InterestExpense"] == null ? 0.0 : json["InterestExpense"],
    effInRate: json["EffInRate"] == null ? 0.0 : json["EffInRate"],
    ftpExpense: json["FtpExpense"] == null ? 0.0 : json["FtpExpense"],
    effFtpRate: json["EffFtpRate"] == null ? 0.0 : json["EffFtpRate"],
    nrff: json["Nrff"] == null ? 0.0 : json["Nrff"],
  );

  Map<String, dynamic> toJson() => {
    "Product": product,
    "ActualValue": actualValue,
    "AverageValue": averageValue,
    "InterestExpense": interestExpense,
    "EffInRate": effInRate,
    "FtpExpense": ftpExpense,
    "EffFtpRate": effFtpRate,
    "Nrff": nrff,
  };

  /*@override
  String toString() {
    return 'NrffResponse{Product: $product, ActualValue: $actualValue, AverageValue: $averageValue, InterestExpense: $interestExpense, EffInRate: $effInRate, FtpExpense: $ftpExpense, EffFtpRate: $effFtpRate, Nrff: $nrff}';
  }

  double getSum() {
    return actualValue +
        averageValue +
        interestExpense +
        effInRate +
        ftpExpense +
        effFtpRate +
        nrff;
  }*/

}

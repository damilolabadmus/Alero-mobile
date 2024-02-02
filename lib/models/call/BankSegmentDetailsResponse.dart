

import 'dart:convert';

BankSegmentDetailsResponse bankSegmentDetailsFromJson(String str) => BankSegmentDetailsResponse.fromJson(json.decode(str));

String bankSegmentDetailsToJson(BankSegmentDetailsResponse data) => json.encode(data.toJson());

class BankSegmentDetailsResponse {
  BankSegmentDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String? responseCode;
  String? responseDescription;
  List<Result>? result;

  factory BankSegmentDetailsResponse.fromJson(Map<String, dynamic> json) => BankSegmentDetailsResponse(
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
    this.segment,
  });

  String? segment;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    segment: json["segment"],
  );

  Map<String, dynamic> toJson() => {
    "segment": segment,
  };

  @override
  String toString() {
    return 'Result{segment: $segment}';
  }
}

import 'dart:convert';

RevenueDetailsResponse revenueDetailsResponseFromJson(String str) => RevenueDetailsResponse.fromJson(json.decode(str));

String revenueDetailsResponseToJson(RevenueDetailsResponse data) => json.encode(data.toJson());

class RevenueDetailsResponse {
  RevenueDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  RevenueDetailsResponseResult result;

  factory RevenueDetailsResponse.fromJson(Map<String, dynamic> json) => RevenueDetailsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: RevenueDetailsResponseResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result.toJson(),
  };
}

class RevenueDetailsResponseResult {
  RevenueDetailsResponseResult({
    this.result,
    this.id,
    this.exception,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.asyncState,
    this.isFaulted,
  });

  ResultRev result;
  int id;
  dynamic exception;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  dynamic asyncState;
  bool isFaulted;

  factory RevenueDetailsResponseResult.fromJson(Map<String, dynamic> json) => RevenueDetailsResponseResult(
    result: ResultRev.fromJson(json["result"]),
    id: json["id"],
    exception: json["exception"],
    status: json["status"],
    isCanceled: json["isCanceled"],
    isCompleted: json["isCompleted"],
    isCompletedSuccessfully: json["isCompletedSuccessfully"],
    creationOptions: json["creationOptions"],
    asyncState: json["asyncState"],
    isFaulted: json["isFaulted"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "id": id,
    "exception": exception,
    "status": status,
    "isCanceled": isCanceled,
    "isCompleted": isCompleted,
    "isCompletedSuccessfully": isCompletedSuccessfully,
    "creationOptions": creationOptions,
    "asyncState": asyncState,
    "isFaulted": isFaulted,
  };
}

class ResultRev {
  ResultRev({
    this.feesRevenue,
    this.grossRevenue,
    this.nrff,
    this.totalRevenue,
  });

  double feesRevenue;
  double grossRevenue;
  double nrff;
  double totalRevenue;

  factory ResultRev.fromJson(Map<String, dynamic> json) => ResultRev(
    feesRevenue: json["feesRevenue"],
    grossRevenue: json["grossRevenue"],
    nrff: json["nrff"],
    totalRevenue: json["totalRevenue"],
  );

  Map<String, dynamic> toJson() => {
    "feesRevenue": feesRevenue,
    "grossRevenue": grossRevenue,
    "nrff": nrff,
    "totalRevenue": totalRevenue,
  };

  @override
  String toString() {
    return 'ResultResult{feesRevenue: $feesRevenue, grossRevenue: $grossRevenue, nrff: $nrff, totalRevenue: $totalRevenue}';
  }
}

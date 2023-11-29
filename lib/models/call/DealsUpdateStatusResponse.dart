import 'dart:convert';

DealsUpdateStatusResponse dealsUpdateStatusResponseFromJson(String str) => DealsUpdateStatusResponse.fromJson(json.decode(str));

String dealsUpdateStatusResponseToJson(DealsUpdateStatusResponse data) => json.encode(data.toJson());

class DealsUpdateStatusResponse {
  DealsUpdateStatusResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  Result result;

  factory DealsUpdateStatusResponse.fromJson(Map<String, dynamic> json) => DealsUpdateStatusResponse(
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
  Result({
    this.statusUpdate1,
    this.statusUpdate2,
  });

  List<StatusUpdate> statusUpdate1;
  List<StatusUpdate> statusUpdate2;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    statusUpdate1: List<StatusUpdate>.from(json["statusUpdate1"].map((x) => StatusUpdate.fromJson(x))),
    statusUpdate2: List<StatusUpdate>.from(json["statusUpdate2"].map((x) => StatusUpdate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusUpdate1": List<dynamic>.from(statusUpdate1.map((x) => x.toJson())),
    "statusUpdate2": List<dynamic>.from(statusUpdate2.map((x) => x.toJson())),
  };
}

class StatusUpdate {
  StatusUpdate({
    this.statusId,
    this.status,
    this.finalStage,
    this.category,
    this.listOfSubstatus,
  });

  String statusId;
  String status;
  FinalStage finalStage;
  int category;
  List<ListOfSubstatus> listOfSubstatus;

  factory StatusUpdate.fromJson(Map<String, dynamic> json) => StatusUpdate(
    statusId: json["statusId"],
    status: json["status"],
    finalStage: finalStageValues.map[json["finalStage"]],
    category: json["category"],
    listOfSubstatus: List<ListOfSubstatus>.from(json["listOfSubstatus"].map((x) => ListOfSubstatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusId": statusId,
    "status": status,
    "finalStage": finalStageValues.reverse[finalStage],
    "category": category,
    "listOfSubstatus": List<dynamic>.from(listOfSubstatus.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'StatusUpdate{statusId: $statusId, status: $status, category: $category, finalStage: $finalStage }';
  }
}

enum FinalStage { N, Y }

final finalStageValues = EnumValues({
  "N": FinalStage.N,
  "Y": FinalStage.Y
});

class ListOfSubstatus {
  ListOfSubstatus({
    this.statusId,
    this.status,
  });

  String statusId;
  String status;

  factory ListOfSubstatus.fromJson(Map<String, dynamic> json) => ListOfSubstatus(
    statusId: json["statusId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "statusId": statusId,
    "status": status,
  };

  @override
  String toString() {
    return 'ListOfSubstatus{statusId: $statusId, status: $status }';
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

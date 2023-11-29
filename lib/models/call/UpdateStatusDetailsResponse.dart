import 'dart:convert';

UpdateStatusDetailsResponse updateStatusDetailsResponseFromJson(String str) => UpdateStatusDetailsResponse.fromJson(json.decode(str));

String updateStatusDetailsResponseToJson(UpdateStatusDetailsResponse data) => json.encode(data.toJson());

class UpdateStatusDetailsResponse {
  UpdateStatusDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  StatusResult result;

  factory UpdateStatusDetailsResponse.fromJson(Map<String, dynamic> json) => UpdateStatusDetailsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: StatusResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result.toJson(),
  };
}

class StatusResult {
  StatusResult({
    this.statusUpdate1,
    this.statusUpdate2,
  });

  List<DealsStatusUpdate> statusUpdate1;
  List<DealsStatusUpdate> statusUpdate2;

  factory StatusResult.fromJson(Map<String, dynamic> json) => StatusResult(
    statusUpdate1: List<DealsStatusUpdate>.from(json["statusUpdate1"].map((x) => DealsStatusUpdate.fromJson(x))),
    statusUpdate2: List<DealsStatusUpdate>.from(json["statusUpdate2"].map((x) => DealsStatusUpdate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusUpdate1": List<dynamic>.from(statusUpdate1.map((x) => x.toJson())),
    "statusUpdate2": List<dynamic>.from(statusUpdate2.map((x) => x.toJson())),
  };
}

class DealsStatusUpdate {
  DealsStatusUpdate({
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
  List<DealsListOfSubstatus> listOfSubstatus;

  factory DealsStatusUpdate.fromJson(Map<String, dynamic> json) => DealsStatusUpdate(
    statusId: json["statusId"],
    status: json["status"],
    finalStage: finalStageValues.map[json["finalStage"]],
    category: json["category"],
    listOfSubstatus: List<DealsListOfSubstatus>.from(json["listOfSubstatus"].map((x) => DealsListOfSubstatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusId": statusId,
    "status": status,
    "finalStage": finalStageValues.reverse[finalStage],
    "category": category,
    "listOfSubstatus": List<dynamic>.from(listOfSubstatus.map((x) => x.toJson())),
  };
}

enum FinalStage { N, Y }

final finalStageValues = EnumValues({
  "N": FinalStage.N,
  "Y": FinalStage.Y
});

class DealsListOfSubstatus {
  DealsListOfSubstatus({
    this.statusId,
    this.status,
  });

  String statusId;
  String status;

  factory DealsListOfSubstatus.fromJson(Map<String, dynamic> json) => DealsListOfSubstatus(
    statusId: json["statusId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "statusId": statusId,
    "status": status,
  };
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


import 'dart:convert';

List<RmByBranchCodeList> rmByBranchCodeListFromJson(String str) => List<RmByBranchCodeList>.from(json.decode(str).map((x) => RmByBranchCodeList.fromJson(x)));

String rmByBranchCodeListToJson(List<RmByBranchCodeList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RmByBranchCodeList {
  String? rmCode;
  String? rmName;
  String? rmEmail;
  RmHub? rmHub;
  SendScorecard? sendScorecard;
  RmRole? rmRole;
  RecordStatus? recordStatus;
  RmSegment? rmSegment;
  BranchName? branchName;
  String? branchCode;

  RmByBranchCodeList({
    this.rmCode,
    this.rmName,
    this.rmEmail,
    this.rmHub,
    this.sendScorecard,
    this.rmRole,
    this.recordStatus,
    this.rmSegment,
    this.branchName,
    this.branchCode,
  });

  factory RmByBranchCodeList.fromJson(Map<String, dynamic> json) => RmByBranchCodeList(
    rmCode: json["rmCode"],
    rmName: json["rmName"],
    rmEmail: json["rmEmail"],
    rmHub: rmHubValues.map[json["rmHub"]],
    sendScorecard: sendScorecardValues.map[json["sendScorecard"]],
    rmRole: rmRoleValues.map[json["rmRole"]],
    recordStatus: recordStatusValues.map[json["recordStatus"]],
    rmSegment: rmSegmentValues.map[json["rmSegment"]],
    branchName: branchNameValues.map[json["branchName"]],
    branchCode: json["branchCode"],
  );

  Map<String, dynamic> toJson() => {
    "rmCode": rmCode,
    "rmName": rmName,
    "rmEmail": rmEmail,
    "rmHub": rmHubValues.reverse![rmHub],
    "sendScorecard": sendScorecardValues.reverse![sendScorecard],
    "rmRole": rmRoleValues.reverse![rmRole],
    "recordStatus": recordStatusValues.reverse![recordStatus],
    "rmSegment": rmSegmentValues.reverse![rmSegment],
    "branchName": branchNameValues.reverse![branchName],
    "branchCode": branchCode,
  };
}

enum BranchName {
  IKENEGBU_LAYOUT_OKIGWE
}

final branchNameValues = EnumValues({
  "IKENEGBU LAYOUT OKIGWE": BranchName.IKENEGBU_LAYOUT_OKIGWE
});

enum RecordStatus {
  O
}

final recordStatusValues = EnumValues({
  "O": RecordStatus.O
});

enum RmHub {
  C6181,
  RT618
}

final rmHubValues = EnumValues({
  "C6181": RmHub.C6181,
  "RT618": RmHub.RT618
});

enum RmRole {
  BM,
  RM
}

final rmRoleValues = EnumValues({
  "BM": RmRole.BM,
  "RM": RmRole.RM
});

enum RmSegment {
  COMMERCIAL,
  RETAIL
}

final rmSegmentValues = EnumValues({
  "COMMERCIAL": RmSegment.COMMERCIAL,
  "RETAIL": RmSegment.RETAIL
});

enum SendScorecard {
  N,
  Y
}

final sendScorecardValues = EnumValues({
  "N": SendScorecard.N,
  "Y": SendScorecard.Y
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

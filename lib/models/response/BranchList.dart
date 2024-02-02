

import 'dart:convert';

List<BranchByAreaCodeList> branchByAreaListFromJson(String str) => List<BranchByAreaCodeList>.from(json.decode(str).map((x) => BranchByAreaCodeList.fromJson(x)));

String branchByAreaListToJson(List<BranchByAreaCodeList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchByAreaCodeList {
  String? branchCode;
  String? branchName;
  AreaName? areaName;
  dynamic zoneCode;
  String? bmName;
  String? bmCode;
  String? bmEmail;
  String? bsmCode;
  String? bsmName;
  String? bsmEmail;
  BranchType? branchType;
  Status? status;
  dynamic areaCode;
  dynamic regionName;
  dynamic amName;
  dynamic amCode;
  dynamic amEmail;
  dynamic regionCode;
  dynamic reCode;
  dynamic reEmail;
  dynamic reName;

  BranchByAreaCodeList({
    this.branchCode,
    this.branchName,
    this.areaName,
    this.zoneCode,
    this.bmName,
    this.bmCode,
    this.bmEmail,
    this.bsmCode,
    this.bsmName,
    this.bsmEmail,
    this.branchType,
    this.status,
    this.areaCode,
    this.regionName,
    this.amName,
    this.amCode,
    this.amEmail,
    this.regionCode,
    this.reCode,
    this.reEmail,
    this.reName,
  });

  factory BranchByAreaCodeList.fromJson(Map<String, dynamic> json) => BranchByAreaCodeList(
    branchCode: json["branchCode"],
    branchName: json["branchName"],
    areaName: areaNameValues.map[json["areaName"]],
    zoneCode: json["zoneCode"],
    bmName: json["bmName"],
    bmCode: json["bmCode"],
    bmEmail: json["bmEmail"],
    bsmCode: json["bsmCode"],
    bsmName: json["bsmName"],
    bsmEmail: json["bsmEmail"],
    branchType: branchTypeValues.map[json["branchType"]],
    status: statusValues.map[json["status"]],
    areaCode: json["areaCode"],
    regionName: json["regionName"],
    amName: json["amName"],
    amCode: json["amCode"],
    amEmail: json["amEmail"],
    regionCode: json["regionCode"],
    reCode: json["reCode"],
    reEmail: json["reEmail"],
    reName: json["reName"],
  );

  Map<String, dynamic> toJson() => {
    "branchCode": branchCode,
    "branchName": branchName,
    "areaName": areaNameValues.reverse![areaName],
    "zoneCode": zoneCode,
    "bmName": bmName,
    "bmCode": bmCode,
    "bmEmail": bmEmail,
    "bsmCode": bsmCode,
    "bsmName": bsmName,
    "bsmEmail": bsmEmail,
    "branchType": branchTypeValues.reverse![branchType],
    "status": statusValues.reverse![status],
    "areaCode": areaCode,
    "regionName": regionName,
    "amName": amName,
    "amCode": amCode,
    "amEmail": amEmail,
    "regionCode": regionCode,
    "reCode": reCode,
    "reEmail": reEmail,
    "reName": reName,
  };
}

enum AreaName {
  IMO
}

final areaNameValues = EnumValues({
  "IMO": AreaName.IMO
});

enum BranchType {
  BRANCH,
  CASH_MGT_CENTRE,
  CO_HABITING
}

final branchTypeValues = EnumValues({
  "BRANCH": BranchType.BRANCH,
  "CASH MGT CENTRE": BranchType.CASH_MGT_CENTRE,
  "CO-HABITING": BranchType.CO_HABITING
});

enum Status {
  CLOSED,
  OPERATIONAL
}

final statusValues = EnumValues({
  "CLOSED": Status.CLOSED,
  "OPERATIONAL": Status.OPERATIONAL
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

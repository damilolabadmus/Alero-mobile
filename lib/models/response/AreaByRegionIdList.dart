import 'dart:convert';

List<AreaByRegionIdList> areaByRegionIdListFromJson(String str) => List<AreaByRegionIdList>.from(json.decode(str).map((x) => AreaByRegionIdList.fromJson(x)));

String areaByRegionIdListToJson(List<AreaByRegionIdList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaByRegionIdList {
  dynamic branchCode;
  dynamic branchName;
  String areaName;
  dynamic zoneCode;
  dynamic bmName;
  dynamic bmCode;
  dynamic bmEmail;
  dynamic bsmCode;
  dynamic bsmName;
  dynamic bsmEmail;
  dynamic branchType;
  dynamic status;
  String areaCode;
  String regionName;
  String amName;
  String amCode;
  String amEmail;
  dynamic regionCode;
  dynamic reCode;
  dynamic reEmail;
  dynamic reName;

  AreaByRegionIdList({
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

  factory AreaByRegionIdList.fromJson(Map<String, dynamic> json) => AreaByRegionIdList(
    branchCode: json["branchCode"],
    branchName: json["branchName"],
    areaName: json["areaName"],
    zoneCode: json["zoneCode"],
    bmName: json["bmName"],
    bmCode: json["bmCode"],
    bmEmail: json["bmEmail"],
    bsmCode: json["bsmCode"],
    bsmName: json["bsmName"],
    bsmEmail: json["bsmEmail"],
    branchType: json["branchType"],
    status: json["status"],
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
    "areaName": areaName,
    "zoneCode": zoneCode,
    "bmName": bmName,
    "bmCode": bmCode,
    "bmEmail": bmEmail,
    "bsmCode": bsmCode,
    "bsmName": bsmName,
    "bsmEmail": bsmEmail,
    "branchType": branchType,
    "status": status,
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

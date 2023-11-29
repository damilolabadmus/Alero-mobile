import 'dart:convert';

List<RegionList> regionListFromJson(String str) => List<RegionList>.from(json.decode(str).map((x) => RegionList.fromJson(x)));

String regionListToJson(List<RegionList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegionList {
  int indexId;
  String location;
  String locationCode;

  RegionList({
    this.indexId,
    this.location,
    this.locationCode,
  });

  factory RegionList.fromJson(Map<String, dynamic> json) => RegionList(
    indexId: json["indexId"],
    location: json["location"],
    locationCode: json["locationCode"],
  );

  Map<String, dynamic> toJson() => {
    "indexId": indexId,
    "location": location,
    "locationCode": locationCode,
  };
}

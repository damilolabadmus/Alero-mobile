import 'dart:convert';

ProspectDetailsResponse prospectFromJson(String str) => ProspectDetailsResponse.fromJson(json.decode(str));

String prospectToJson(ProspectDetailsResponse data) => json.encode(data.toJson());

class ProspectDetailsResponse {
  ProspectDetailsResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  Result result;

  factory ProspectDetailsResponse.fromJson(Map<String, dynamic> json) => ProspectDetailsResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result:  Result.fromJson(json["result"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result.toJson() ?? {},
  };
}

class Result {
  Result({
    this.userProspects,
    this.hubProspects,
    this.clusterProspects,
    this.divisionProspects,
    this.segmentProspects,
    this.allProspects,
  });

  List<UserProspect> userProspects;
  dynamic hubProspects;
  dynamic clusterProspects;
  dynamic divisionProspects;
  dynamic segmentProspects;
  dynamic allProspects;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userProspects: List<UserProspect>.from(json["userProspects"].map((x) => UserProspect.fromJson(x))),
    hubProspects: json["hubProspects"],
    clusterProspects: json["clusterProspects"],
    divisionProspects: json["divisionProspects"],
    segmentProspects: json["segmentProspects"],
    allProspects: json["allProspects"],
  );

  Map<String, dynamic> toJson() => {
    "userProspects": List<dynamic>.from(userProspects.map((x) => x.toJson())),
    "hubProspects": hubProspects,
    "clusterProspects": clusterProspects,
    "divisionProspects": divisionProspects,
    "segmentProspects": segmentProspects,
    "allProspects": allProspects,
  };
}

class UserProspect {
  UserProspect({
    this.prospectId,
    this.keyPromoterName,
    this.prospectName,
    this.prospectAddress,
    this.prospectType,
    this.businessSegment,
    this.productOffered,
    this.customerWalletSize,
    this.contactPersonName,
    this.contactPersonEmail,
    this.contactPersonPhoneNo,
    this.contactPersonAddress,
    this.prospectConverted,
    this.accountNo,
    this.edit,
    this.introducerStaffCode,
  });

  String prospectId;
  String keyPromoterName;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  double customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress;
  bool prospectConverted;
  String accountNo;
  bool edit;
  String introducerStaffCode;

  factory UserProspect.fromJson(Map<String, dynamic> json) => UserProspect(
    prospectId: json["prospectId"],
    keyPromoterName: json["keyPromoterName"],
    prospectName: json["prospectName"],
    prospectAddress: json["prospectAddress"],
    prospectType: json["prospectType"],
    businessSegment: json["businessSegment"],
    productOffered: json["productOffered"],
    customerWalletSize: json["customerWalletSize"],
    contactPersonName: json["contactPersonName"],
    contactPersonEmail: json["contactPersonEmail"],
    contactPersonPhoneNo: json["contactPersonPhoneNo"],
    contactPersonAddress: json["contactPersonAddress"],
    prospectConverted: json["prospectConverted"],
    accountNo: json["accountNo"],
    edit: json["edit"],
    introducerStaffCode: json["introducerStaffCode"],
  );

  Map<String, dynamic> toJson() => {
    "prospectId": prospectId,
    "keyPromoterName": keyPromoterName,
    "prospectName": prospectName,
    "prospectAddress": prospectAddress,
    "prospectType": prospectType,
    "businessSegment": businessSegment,
    "productOffered": productOffered,
    "customerWalletSize": customerWalletSize,
    "contactPersonName": contactPersonName,
    "contactPersonEmail": contactPersonEmail,
    "contactPersonPhoneNo": contactPersonPhoneNo,
    "contactPersonAddress": contactPersonAddress,
    "prospectConverted": prospectConverted,
    "accountNo": accountNo,
    "edit": edit,
    "introducerStaffCode": introducerStaffCode,
  };

  @override
  String toString() {
    return 'UserProspect{prospectId: $prospectId, keyPromoterName: $keyPromoterName, prospectName: $prospectName, prospectAddress: $prospectAddress, prospectType: $prospectType, businessSegment: $businessSegment, productOffered: $productOffered, customerWalletSize: $customerWalletSize, contactPersonName: $contactPersonName, contactPersonEmail: $contactPersonEmail, contactPersonPhoneNo: $contactPersonPhoneNo, contactPersonAddress: $contactPersonAddress, prospectConverted: $prospectConverted, accountNo: $accountNo, edit: $edit, introducerStaffCode: $introducerStaffCode}';
  }
}

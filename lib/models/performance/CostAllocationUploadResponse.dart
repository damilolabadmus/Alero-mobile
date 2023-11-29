import 'dart:convert';

List<CostAllocationUploadResponse> costAllocationUploadResponseFromJson(String str) => List<CostAllocationUploadResponse>.from(json.decode(str).map((x) => CostAllocationUploadResponse.fromJson(x)));

String costAllocationUploadResponseToJson(List<CostAllocationUploadResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostAllocationUploadResponse {
  int serialNumber;
  String batchId;
  int adjustmentCount;
  double adjustmentValue;
  DateTime uploadDate;
  DateTime runDate;
  dynamic runDateString;
  dynamic branchCode;
  dynamic deptCode;
  dynamic glCode;
  dynamic narration;

  CostAllocationUploadResponse({
    this.serialNumber,
    this.batchId,
    this.adjustmentCount,
    this.adjustmentValue,
    this.uploadDate,
    this.runDate,
    this.runDateString,
    this.branchCode,
    this.deptCode,
    this.glCode,
    this.narration,
  });

  factory CostAllocationUploadResponse.fromJson(Map<String, dynamic> json) => CostAllocationUploadResponse(
    serialNumber: json["serialNumber"],
    batchId: json["batchId"] == "" ? '0' : json["batchId"],
    adjustmentCount: json["adjustmentCount"],
    adjustmentValue: json["adjustmentValue"].toDouble(),
    uploadDate: DateTime.parse(json["uploadDate"]),
    runDate: DateTime.parse(json["runDate"]),
    runDateString: json["runDateString"] ?? 0.0,
    branchCode: json["branchCode"] ?? 0,
    deptCode: json["deptCode"] ?? 0,
    glCode: json["glCode"] ?? 0,
    narration: json["narration"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "serialNumber": serialNumber,
    "batchId": batchId,
    "adjustmentCount": adjustmentCount,
    "adjustmentValue": adjustmentValue,
    "uploadDate": uploadDate.toIso8601String(),
    "runDate": runDate.toIso8601String(),
    "runDateString": runDateString,
    "branchCode": branchCode,
    "deptCode": deptCode,
    "glCode": glCode,
    "narration": narration,
  };
}

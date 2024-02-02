

import 'dart:convert';

DealHistoryResponse dealHistoryResponseFromJson(String str) => DealHistoryResponse.fromJson(json.decode(str));

String dealHistoryResponseToJson(DealHistoryResponse data) => json.encode(data.toJson());

class DealHistoryResponse {
  DealHistoryResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String? responseCode;
  String? responseDescription;
  HistoryResult? result;

  factory DealHistoryResponse.fromJson(Map<String, dynamic> json) => DealHistoryResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: HistoryResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result!.toJson(),
  };
}

class HistoryResult {
  HistoryResult({
    this.pipelineId,
    this.customerName,
    this.customerType,
    this.transactionType,
    this.amount,
    this.currency,
    this.startDate,
    this.expectedDealDate,
    this.tenor,
    this.feesRate,
    this.interestRate,
    this.accountNo,
    this.productType,
    this.netInterestMargin,
    this.feesRevenue,
    this.grossRevenue,
    this.nrff,
    this.totalRevenue,
    this.isProspect,
    this.subStatus,
    this.transactionComment,
    this.statusComment,
    this.status,
    this.disbursedAmount,
    this.disbursementType,
    this.endDate,
    this.entryDate,
    this.statusId,
    this.lastUpate,
    this.turnAroundTime,
    this.statusHistory,
    this.disbursementHistory,
  });

  String? pipelineId;
  String? customerName;
  String? customerType;
  String? transactionType;
  double? amount;
  String? currency;
  DateTime? startDate;
  DateTime? expectedDealDate;
  int? tenor;
  double? feesRate;
  double? interestRate;
  String? accountNo;
  String? productType;
  double? netInterestMargin;
  double? feesRevenue;
  double? grossRevenue;
  double? nrff;
  double? totalRevenue;
  String? isProspect;
  String? subStatus;
  String? transactionComment;
  String? statusComment;
  String? status;
  double? disbursedAmount;
  String? disbursementType;
  DateTime? endDate;
  DateTime? entryDate;
  String? statusId;
  DateTime? lastUpate;
  int? turnAroundTime;
  List<StatusHistory>? statusHistory;
  List<DisbursementHistory>? disbursementHistory;

  factory HistoryResult.fromJson(Map<String, dynamic> json) => HistoryResult(
    pipelineId: json["pipelineId"],
    customerName: json["customerName"],
    customerType: json["customerType"],
    transactionType: json["transactionType"],
    amount: json["amount"],
    currency: json["currency"],
    startDate: json['startDate'] == null ? DateTime.now() : DateTime.parse(json["startDate"]),
    expectedDealDate: json['expectedDealDate'] == null ? DateTime.now() : DateTime.parse(json["expectedDealDate"]),
    tenor: json["tenor"],
    feesRate: json["feesRate"],
    interestRate: json["interestRate"],
    accountNo: json["accountNo"],
    productType: json["productType"],
    netInterestMargin: json["netInterestMargin"],
    feesRevenue: json["feesRevenue"],
    grossRevenue: json["grossRevenue"],
    nrff: json["nrff"],
    totalRevenue: json["totalRevenue"],
    isProspect: json["isProspect"],
    subStatus: json["subStatus"],
    transactionComment: json["transactionComment"],
    statusComment: json["statusComment"],
    status: json["status"],
    disbursedAmount: json["disbursedAmount"],
    disbursementType: json["disbursementType"],
    endDate: json['endDate'] == null ? DateTime.now() : DateTime.parse(json["endDate"]),
    entryDate: json['entryDate'] == null ? DateTime.now() : DateTime.parse(json["entryDate"]),
    statusId: json["statusId"],
    lastUpate: json['lastUpate'] == null ? DateTime.now() : DateTime.parse(json["lastUpate"]),
    turnAroundTime: json["turnAroundTime"],
    statusHistory: List<StatusHistory>.from(json["statusHistory"].map((x) => StatusHistory.fromJson(x))),
    disbursementHistory: List<DisbursementHistory>.from(json["disbursementHistory"].map((x) => DisbursementHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pipelineId": pipelineId,
    "customerName": customerName,
    "customerType": customerType,
    "transactionType": transactionType,
    "amount": amount,
    "currency": currency,
    "startDate": startDate!.toIso8601String(),
    "expectedDealDate": expectedDealDate!.toIso8601String(),
    "tenor": tenor,
    "feesRate": feesRate,
    "interestRate": interestRate,
    "accountNo": accountNo,
    "productType": productType,
    "netInterestMargin": netInterestMargin,
    "feesRevenue": feesRevenue,
    "grossRevenue": grossRevenue,
    "nrff": nrff,
    "totalRevenue": totalRevenue,
    "isProspect": isProspect,
    "subStatus": subStatus,
    "transactionComment": transactionComment,
    "statusComment": statusComment,
    "status": status,
    "disbursedAmount": disbursedAmount,
    "disbursementType": disbursementType,
    "endDate": endDate,
    "entryDate": entryDate!.toIso8601String(),
    "statusId": statusId,
    "lastUpate": lastUpate!.toIso8601String(),
    "turnAroundTime": turnAroundTime,
    "statusHistory": List<dynamic>.from(statusHistory!.map((x) => x.toJson())),
    "disbursementHistory": List<dynamic>.from(disbursementHistory!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'Result{pipelineId: $pipelineId,customerName: $customerName,customerType: $customerType,transactionType: $transactionType, amount: $amount,currency: $currency, startDate: $startDate, expectedDealDate: $expectedDealDate,tenor: $tenor, feesRate: $feesRate, interestRate: $interestRate, accountNo: $accountNo, productType: $productType, netInterestMargin: $netInterestMargin,feesRevenue: $feesRevenue, grossRevenue: $grossRevenue, nrff: $nrff,totalRevenue: $totalRevenue, isProspect: $isProspect, subStatus: $subStatus,transactionComment:$transactionComment, statusComment: $statusComment, status: $status,disbursementAmount: $disbursedAmount, disbursementType: $disbursementType, endDate: $endDate,entryDate: $entryDate, statusId: $statusId, lastUpate: $lastUpate, turnAroundTime: $turnAroundTime}';
  }
}

class DisbursementHistory {
  DisbursementHistory({
    this.pipelineId,
    this.disbursementStatus,
    this.disbursedAmount,
    this.disbursementType,
    this.outstandingAmount,
    this.rmCode,
    this.timeIn,
  });

  String? pipelineId;
  String? disbursementStatus;
  double? disbursedAmount;
  String? disbursementType;
  double? outstandingAmount;
  String? rmCode;
  DateTime? timeIn;

  factory DisbursementHistory.fromJson(Map<String, dynamic> json) => DisbursementHistory(
    pipelineId: json["pipelineId"],
    disbursementStatus: json["disbursementStatus"],
    disbursedAmount: json["disbursedAmount"],
    disbursementType: json["disbursementType"],
    outstandingAmount: json["outstandingAmount"],
    rmCode: json["rmCode"],
    timeIn: DateTime.parse(json["timeIn"]),
  );

  Map<String, dynamic> toJson() => {
    "pipelineId": pipelineId,
    "disbursementStatus": disbursementStatus,
    "disbursedAmount": disbursedAmount,
    "disbursementType": disbursementType,
    "outstandingAmount": outstandingAmount,
    "rmCode": rmCode,
    "timeIn": timeIn!.toIso8601String(),
  };

  @override
  String toString() {
    return 'DisbursementHistory{pipelineId: $pipelineId, disbursementStatus: $disbursementStatus,disbursedAmount: $disbursedAmount,disbursementType: $disbursementType,outstandingAmount: $outstandingAmount,rmCode: $rmCode,timeIn: $timeIn}';
  }
}

class StatusHistory {
  StatusHistory({
    this.pipelineId,
    this.dealStatus,
    this.subStatus,
    this.comment,
    this.rmCode,
    this.timeIn,
  });

  String? pipelineId;
  String? dealStatus;
  String? subStatus;
  String? comment;
  String? rmCode;
  DateTime? timeIn;

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
    pipelineId: json["pipelineId"],
    dealStatus: json["dealStatus"],
    subStatus: json["subStatus"],
    comment: json["comment"],
    rmCode: json["rmCode"],
    timeIn: DateTime.parse(json["timeIn"]),
  );

  Map<String, dynamic> toJson() => {
    "pipelineId": pipelineId,
    "dealStatus": dealStatus,
    "subStatus": subStatus,
    "comment": comment,
    "rmCode": rmCode,
    "timeIn": timeIn!.toIso8601String(),
  };

  @override
  String toString() {
    return 'StatusHistory{pipelineId: $pipelineId, dealStatus: $dealStatus,subStatus: $subStatus, comment: $comment,rmCode: $rmCode,timeIn: $timeIn}';
  }
}

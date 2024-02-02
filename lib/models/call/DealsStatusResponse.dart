

import 'dart:convert';

DealsStatusResponse dealsStatusResponseFromJson(String str) => DealsStatusResponse.fromJson(json.decode(str));

String dealsStatusResponseToJson(DealsStatusResponse data) => json.encode(data.toJson());

class DealsStatusResponse {
  DealsStatusResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String? responseCode;
  String? responseDescription;
  Result? result;

  factory DealsStatusResponse.fromJson(Map<String, dynamic> json) => DealsStatusResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result:  json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": result?.toJson() ?? {},
  };
}

class Result {
  Result({
    this.rejectedDeals,
    this.dealsOngoingApproval,
    this.dealsForStatusUpdate,
    this.dealsForDisbursement,
    this.completedDeals,
    this.droppedDeals,
  });

  List<dynamic>? rejectedDeals;
  List<dynamic>? dealsOngoingApproval;
  List<DealsForStatusUpdate>? dealsForStatusUpdate;
  List<DealsForDisbursement>? dealsForDisbursement;
  List<CompletedDeals>? completedDeals;
  List<dynamic>? droppedDeals;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    rejectedDeals: List<dynamic>.from(json["rejectedDeals"].map((x) => x)),
    dealsOngoingApproval: List<dynamic>.from(json["dealsOngoingApproval"].map((x) => x)),
    dealsForStatusUpdate: List<DealsForStatusUpdate>.from(json["dealsForStatusUpdate"].map((x) => DealsForStatusUpdate.fromJson(x))),
    dealsForDisbursement: List<DealsForDisbursement>.from(json["dealsForDisbursement"].map((x) => DealsForDisbursement.fromJson(x))),
    completedDeals: List<CompletedDeals>.from(json["completedDeals"].map((x) => CompletedDeals.fromJson(x))),
    droppedDeals: List<dynamic>.from(json["droppedDeals"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rejectedDeals": List<dynamic>.from(rejectedDeals!.map((x) => x)),
    "dealsOngoingApproval": List<dynamic>.from(dealsOngoingApproval!.map((x) => x)),
    "dealsForStatusUpdate": List<dynamic>.from(dealsForStatusUpdate!.map((x) => x)),
    "dealsForDisbursement": List<dynamic>.from(dealsForDisbursement!.map((x) => x)),
    "completedDeals": List<dynamic>.from(completedDeals!.map((x) => x)),
    "droppedDeals": List<dynamic>.from(droppedDeals!.map((x) => x)),
  };
}

class DealsForStatusUpdate {
  String? _pipelineId;
  String? _customerName;
  String? _rmName;
  String? _branchName;
  String? _areaName;
  String? _regionName;
  String? _customerType;
  String? _transactionType;
  double? _amount;
  String? _currency;
  DateTime? _startDate;
  DateTime? _expectedDealDate;
  DateTime? _expiryDate;
  int? _tenor;
  double? _feesRate;
  double? _interestRate;
  String? _accountNo;
  String? _productType;
  double? _netInterestMargin;
  double? _feesRevenue;
  double? _grossRevenue;
  double? _nrff;
  double? _totalRevenue;
  String? _statusId;
  String? _status;
  String? _isProspect;
  String? _subStatus;
  String? _transactionComment;
  double? _dealProbability;
  DateTime? _lastUpdate;
  int? _category;
  bool? _canEdit;

  DealsForStatusUpdate({
    String? pipelineId,
    String? customerName,
    String? rmName,
    String? branchName,
    String? areaName,
    String? regionName,
    String? customerType,
    String? transactionType,
    double? amount,
    String? currency,
    DateTime? startDate,
    DateTime? expectedDealDate,
    DateTime? expiryDate,
    int? tenor,
    double? feesRate,
    double? interestRate,
    String? accountNo,
    String? productType,
    double? netInterestMargin,
    double? feesRevenue,
    double? grossRevenue,
    double? nrff,
    double? totalRevenue,
    String? statusId,
    String? status,
    String? isProspect,
    String? subStatus,
    String? transactionComment,
    double? dealProbability,
    DateTime? lastUpdate,
    int? category,
    bool? canEdit,
  }) {
    this._pipelineId = pipelineId;
    this._customerName = customerName;
    this._rmName = rmName;
    this._branchName = branchName;
    this._areaName = areaName;
    this._regionName = regionName;
    this._customerType = customerType;
    this._transactionType = transactionType;
    this._amount = amount;
    this._currency = currency;
    this._startDate = startDate;
    this._expectedDealDate = expectedDealDate;
    this._expiryDate = expiryDate;
    this._tenor = tenor;
    this._feesRate = feesRate;
    this._interestRate = interestRate;
    this._accountNo = accountNo;
    this._productType = productType;
    this._netInterestMargin = netInterestMargin;
    this._feesRevenue = feesRevenue;
    this._grossRevenue = grossRevenue;
    this._nrff = nrff;
    this._totalRevenue = totalRevenue;
    this._statusId = statusId;
    this._status = status;
    this._isProspect = isProspect;
    this._subStatus = subStatus;
    this._transactionComment = transactionComment;
    this._dealProbability = dealProbability;
    this._lastUpdate = lastUpdate;
    this._category = category;
    this._canEdit = canEdit;
  }

  String? get pipelineId => _pipelineId;
  set pipelineId(String? pipelineId) => _pipelineId = pipelineId;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get rmName => _rmName;
  set rmName(String? rmName) => _rmName = rmName;
  String? get branchName => _branchName;
  set branchName(String? branchName) => _branchName = branchName;
  String? get areaName => _areaName;
  set areaName(String? areaName) => _areaName = areaName;
  String? get regionName => _regionName;
  set regionName(String? regionName) => _regionName = regionName;
  String? get customerType => _customerType;
  set customerType(String? customerType) => _customerType = customerType;
  String? get transactionType => _transactionType;
  set transactionType(String? transactionType) => _transactionType = transactionType;
  double? get amount => _amount;
  set amount(double? amount) => _amount = amount;
  String? get currency => _currency;
  set currency(String? currency) => _currency = currency;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) => _startDate = startDate;
  DateTime? get expectedDealDate => _expectedDealDate;
  set expectedDealDate(DateTime? expectedDealDate) => _expectedDealDate = expectedDealDate;
  DateTime? get expiryDate => _expiryDate;
  set expiryDate(DateTime? expiryDate) => _expiryDate = expiryDate;
  int? get tenor => _tenor;
  set tenor(int? tenor) => _tenor = tenor;
  double? get feesRate => _feesRate;
  set feesRate(double? feesRate) => _feesRate = feesRate;
  double? get interestRate => _interestRate;
  set interestRate(double? interestRate) => _interestRate = interestRate;
  String? get accountNo => _accountNo;
  set accountNo(String? accountNo) => _accountNo = accountNo;
  String? get productType => _productType;
  set productType(String? productType) => _productType = productType;
  double? get netInterestMargin => _netInterestMargin;
  set netInterestMargin(double? netInterestMargin) => _netInterestMargin = netInterestMargin;
  double? get feesRevenue => _feesRevenue;
  set feesRevenue(double? feesRevenue) => _feesRevenue = feesRevenue;
  double? get grossRevenue => _grossRevenue;
  set grossRevenue(double? grossRevenue) => _grossRevenue = grossRevenue;
  double? get nrff => _nrff;
  set nrff(double? nrff) => _nrff = nrff;
  double? get totalRevenue => _totalRevenue;
  set totalRevenue(double? totalRevenue) => _totalRevenue = totalRevenue;
  String? get statusId => _statusId;
  set statusId(String? statusId) => _statusId = statusId;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get isProspect => _isProspect;
  set isProspect(String? isProspect) => _isProspect = isProspect;
  String? get subStatus => _subStatus;
  set subStatus(String? subStatus) => _subStatus = subStatus;
  String? get transactionComment => _transactionComment;
  set transactionComment(String? transactionComment) => _transactionComment = transactionComment;
  double? get dealProbability => _dealProbability;
  set dealProbability(double? dealProbability) => _dealProbability = dealProbability;
  DateTime? get lastUpdate => _lastUpdate;
  set lastUpdate(DateTime? lastUpdate) => _lastUpdate = lastUpdate;
  int? get category => _category;
  set category(int? category) => _category = category;
  bool? get canEdit => _canEdit;
  set canEdit(bool? canEdit) => _canEdit = canEdit;

  DealsForStatusUpdate.fromJson(Map<String, dynamic> json) {
    _pipelineId = json['pipelineId'];
    _customerName = json['customerName'];
    _rmName = json['rmName'];
    _branchName = json['branchName'];
    _areaName = json['areaName'];
    _regionName = json['regionName'];
    _customerType = json['customerType'];
    _transactionType = json['transactionType'];
    _amount = json['amount'];
    _currency = json['currency'];
    _startDate = json['startDate'] == null ? DateTime.now() : DateTime.parse(json['startDate']);
    _expectedDealDate = DateTime.parse(json['expectedDealDate']);
    _expiryDate = json['expiryDate'];
    _tenor = json['tenor'];
    _feesRate = json['feesRate'];
    _interestRate = json['interestRate'];
    _accountNo = json['accountNo'];
    _productType = json['productType'];
    _netInterestMargin = json['netInterestMargin'];
    _feesRevenue = json['feesRevenue'];
    _grossRevenue = json['grossRevenue'];
    _nrff = json['nrff'];
    _totalRevenue = json['totalRevenue'];
    _statusId = json['statusId'];
    _status = json['status'];
    _isProspect = json['isProspect'];
    _subStatus = json['subStatus'];
    _transactionComment = json['transactionComment'];
    _dealProbability = json['dealProbability'];
    _lastUpdate = DateTime.parse(json['lastUpdate']);
    _category = json['category'];
    _canEdit = json['canEdit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pipelineId'] = this._pipelineId;
    data['customerName'] = this._customerName;
    data['rmName'] = this._rmName;
    data['branchName'] = this._branchName;
    data['areaName'] = this._areaName;
    data['regionName'] = this._regionName;
    data['customerType'] = this._customerType;
    data['transactionType'] = this._transactionType;
    data['amount'] = this._amount;
    data['currency'] = this._currency;
    data['startDate'] = this._startDate;
    data['expectedDealDate'] = this._expectedDealDate;
    data['expiryDate'] = this._expiryDate;
    data['tenor'] = this._tenor;
    data['feesRate'] = this._feesRate;
    data['interestRate'] = this._interestRate;
    data['accountNo'] = this._accountNo;
    data['productType'] = this._productType;
    data['netInterestMargin'] = this._netInterestMargin;
    data['feesRevenue'] = this._feesRevenue;
    data['grossRevenue'] = this._grossRevenue;
    data['nrff'] = this._nrff;
    data['totalRevenue'] = this._totalRevenue;
    data['statusId'] = this._statusId;
    data['status'] = this._status;
    data['isProspect'] = this._isProspect;
    data['subStatus'] = this._subStatus;
    data['transactionComment'] = this._transactionComment;
    data['dealProbability'] = this._dealProbability;
    data['lastUpdate'] = this._lastUpdate;
    data['category'] = this._category;
    data['canEdit'] = this._canEdit;
    return data;
  }

  factory DealsForStatusUpdate.fromMap(Map<String, dynamic> map) {
    return DealsForStatusUpdate(
      pipelineId: map['pipelineId'] ?? '',
      customerName: map['customerName'] ?? '',
      rmName: map['rmName'] ?? '',
      branchName: map['branchName'] ?? '',
      areaName: map['areaName'] ?? '',
      regionName: map['regionName'] ?? '',
      customerType: map['customerType'] ?? '',
      transactionType: map['transactionType'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? '',
      startDate: map['startDate'] ?? '' as DateTime?,
      expectedDealDate: map['expectedDealDate'] ?? '' as DateTime?,
      expiryDate: map['expiryDate'] ?? '' as DateTime?,
      tenor: map['tenor']?.toInt() ?? 0,
      feesRate: map['feesRate']?.toDouble() ?? 0.0,
      interestRate: map['interestRate']?.toDouble() ?? 0.0,
      accountNo: map['accountNo'] ?? '',
      productType: map['productType'] ?? '',
      netInterestMargin: map['netInterestMargin']?.toDouble() ?? 0.0,
      feesRevenue: map['feesRevenue']?.toDouble() ?? 0.0,
      grossRevenue: map['grossRevenue']?.toDouble() ?? 0.0,
      nrff: map['nrff']?.toDouble() ?? 0.0,
      totalRevenue: map['totalRevenue']?.toDouble() ?? 0.0,
      statusId: map['statusId'] ?? '',
      status: map['status'] ?? '',
      isProspect: map['isProspect'] ?? '',
      subStatus: map['subStatus'] ?? '',
      transactionComment: map['transactionComment'] ?? '',
      dealProbability: map['dealProbability']?.toDouble() ?? 0.0,
      lastUpdate: map['lastUpdate'] ?? '' as DateTime?,
      category: map['category']?.toInt() ?? 0,
      canEdit: map['canEdit'] ?? true,
    );
  }
}

class DealsForDisbursement {
  String? _pipelineId;
  String? _customerName;
  String? _rmName;
  String? _branchName;
  String? _areaName;
  String? _regionName;
  String? _customerType;
  String? _transactionType;
  double? _amount;
  String? _currency;
  DateTime? _startDate;
  DateTime? _entryDate;
  DateTime? _expectedDealDate;
  int? _tenor;
  double? _feesRate;
  double? _interestRate;
  String? _accountNo;
  String? _productType;
  double? _netInterestMargin;
  double? _feesRevenue;
  double? _grossRevenue;
  double? _nrff;
  double? _totalRevenue;
  String? _isProspect;
  String? _lastComment;
  double? _disbursedAmount;
  double? _amountLeftToDisburse;
  String? _disbursementType;
  String? _transactionComment;
  String? _statusId;
  String? _status;
  String? _subStatus;
  double? _dealProbability;
  int? _category;
  DateTime? _lastUpdate;
  bool? _canEdit;

  DealsForDisbursement({
    String? pipelineId,
    String? customerName,
    String? rmName,
    String? branchName,
    String? areaName,
    String? regionName,
    String? customerType,
    String? transactionType,
    double? amount,
    String? currency,
    DateTime? startDate,
    DateTime? entryDate,
    DateTime? expectedDealDate,
    int? tenor,
    double? feesRate,
    double? interestRate,
    String? accountNo,
    String? productType,
    double? netInterestMargin,
    double? feesRevenue,
    double? grossRevenue,
    double? nrff,
    double? totalRevenue,
    String? isProspect,
    String? lastComment,
    double? disbursedAmount,
    double? amountLeftToDisburse,
    String? disbursementType,
    String? transactionComment,
    String? statusId,
    String? status,
    String? subStatus,
    double? dealProbability,
    int? category,
    DateTime? lastUpdate,
    bool? canEdit,
  }) {
    this._pipelineId = pipelineId;
    this._customerName = customerName;
    this._rmName = rmName;
    this._branchName = branchName;
    this._areaName = areaName;
    this._regionName = regionName;
    this._customerType = customerType;
    this._transactionType = transactionType;
    this._amount = amount;
    this._currency = currency;
    this._startDate = startDate;
    this._entryDate = entryDate;
    this._expectedDealDate = expectedDealDate;
    this._tenor = tenor;
    this._feesRate = feesRate;
    this._interestRate = interestRate;
    this._accountNo = accountNo;
    this._productType = productType;
    this._netInterestMargin = netInterestMargin;
    this._feesRevenue = feesRevenue;
    this._grossRevenue = grossRevenue;
    this._nrff = nrff;
    this._totalRevenue = totalRevenue;
    this._isProspect = isProspect;
    this._lastComment = lastComment;
    this._disbursedAmount = disbursedAmount;
    this._amountLeftToDisburse = amountLeftToDisburse;
    this._disbursementType = disbursementType;
    this._transactionComment = transactionComment;
    this._statusId = statusId;
    this._status = status;
    this._subStatus = subStatus;
    this._dealProbability = dealProbability;
    this._category = category;
    this._lastUpdate = lastUpdate;
    this._canEdit = canEdit;
  }

  String? get pipelineId => _pipelineId;
  set pipelineId(String? pipelineId) => _pipelineId = pipelineId;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get rmName => _rmName;
  set rmName(String? rmName) => _rmName = rmName;
  String? get branchName => _branchName;
  set branchName(String? branchName) => _branchName = branchName;
  String? get areaName => _areaName;
  set areaName(String? areaName) => _areaName = areaName;
  String? get regionName => _regionName;
  set regionName(String? regionName) => _regionName = regionName;
  String? get customerType => _customerType;
  set customerType(String? customerType) => _customerType = customerType;
  String? get transactionType => _transactionType;
  set transactionType(String? transactionType) => _transactionType = transactionType;
  double? get amount => _amount;
  set amount(double? amount) => _amount = amount;
  String? get currency => _currency;
  set currency(String? currency) => _currency = currency;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) => _startDate = startDate;
  DateTime? get entryDate => _entryDate;
  set entryDate(DateTime? entryDate) => _entryDate = entryDate;
  DateTime? get expectedDealDate => _expectedDealDate;
  set expectedDealDate(DateTime? expectedDealDate) => _expectedDealDate = expectedDealDate;
  int? get tenor => _tenor;
  set tenor(int? tenor) => _tenor = tenor;
  double? get feesRate => _feesRate;
  set feesRate(double? feesRate) => _feesRate = feesRate;
  double? get interestRate => _interestRate;
  set interestRate(double? interestRate) => _interestRate = interestRate;
  String? get accountNo => _accountNo;
  set accountNo(String? accountNo) => _accountNo = accountNo;
  String? get productType => _productType;
  set productType(String? productType) => _productType = productType;
  double? get netInterestMargin => _netInterestMargin;
  set netInterestMargin(double? netInterestMargin) => _netInterestMargin = netInterestMargin;
  double? get feesRevenue => _feesRevenue;
  set feesRevenue(double? feesRevenue) => _feesRevenue = feesRevenue;
  double? get grossRevenue => _grossRevenue;
  set grossRevenue(double? grossRevenue) => _grossRevenue = grossRevenue;
  double? get nrff => _nrff;
  set nrff(double? nrff) => _nrff = nrff;
  double? get totalRevenue => _totalRevenue;
  set totalRevenue(double? totalRevenue) => _totalRevenue = totalRevenue;
  String? get isProspect => _isProspect;
  set isProspect(String? isProspect) => _isProspect = isProspect;
  String? get lastComment => _lastComment;
  set lastComment(String? lastComment) => _lastComment = lastComment;
  double? get disbursedAmount => _disbursedAmount;
  set disbursedAmount(double? disbursedAmount) => _disbursedAmount = disbursedAmount;
  double? get amountLeftToDisburse => _amountLeftToDisburse;
  set amountLeftToDisburse(double? amountLeftToDisburse) => _amountLeftToDisburse = amountLeftToDisburse;
  String? get disbursementType => _disbursementType;
  set disbursementType(String? disbursementType) => _disbursementType = disbursementType;
  String? get transactionComment => _transactionComment;
  set transactionComment(String? transactionComment) => _transactionComment = transactionComment;
  String? get statusId => _statusId;
  set statusId(String? statusId) => _statusId = statusId;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get subStatus => _subStatus;
  set subStatus(String? subStatus) => _subStatus = subStatus;
  double? get dealProbability => _dealProbability;
  set dealProbability(double? dealProbability) => _dealProbability = dealProbability;
  int? get category => _category;
  set category(int? category) => _category = category;
  DateTime? get lastUpdate => _lastUpdate;
  set lastUpdate(DateTime? lastUpdate) => _lastUpdate = lastUpdate;
  bool? get canEdit => _canEdit;
  set canEdit(bool? canEdit) => _canEdit = canEdit;

  DealsForDisbursement.fromJson(Map<String, dynamic> json) {
    _pipelineId = json['pipelineId'];
    _customerName = json['customerName'];
    _rmName = json['rmName'];
    _branchName = json['branchName'];
    _areaName = json['areaName'];
    _regionName = json['regionName'];
    _customerType = json['customerType'];
    _transactionType = json['transactionType'];
    _amount = json['amount'];
    _currency = json['currency'];
    _startDate = json['startDate'] == null ? DateTime.now() : DateTime.parse(json['startDate']);
    _entryDate = DateTime.parse(json['entryDate']);
    _expectedDealDate = DateTime.parse(json['expectedDealDate']);
    _tenor = json['tenor'];
    _feesRate = json['feesRate'];
    _interestRate = json['interestRate'];
    _accountNo = json['accountNo'];
    _productType = json['productType'];
    _netInterestMargin = json['netInterestMargin'];
    _feesRevenue = json['feesRevenue'];
    _grossRevenue = json['grossRevenue'];
    _nrff = json['nrff'];
    _totalRevenue = json['totalRevenue'];
    _isProspect = json['isProspect'];
    _lastComment = json['lastComment'];
    _disbursedAmount = json['disbursedAmount'];
    _amountLeftToDisburse = json['amountLeftToDisburse'];
    _disbursementType = json['disbursementType'];
    _transactionComment = json['transactionComment'];
    _statusId = json['statusId'];
    _status = json['status'];
    _subStatus = json['subStatus'];
    _dealProbability = json['dealProbability'];
    _category = json['category'];
    _lastUpdate = DateTime.parse(json['lastUpdate']);
    _canEdit = json['canEdit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pipelineId'] = this._pipelineId;
    data['customerName'] = this._customerName;
    data['rmName'] = this._rmName;
    data['branchName'] = this._branchName;
    data['areaName'] = this._areaName;
    data['regionName'] = this._regionName;
    data['customerType'] = this._customerType;
    data['transactionType'] = this._transactionType;
    data['amount'] = this._amount;
    data['currency'] = this._currency;
    data['startDate'] = this._startDate;
    data['entryDate'] = this._entryDate;
    data['expectedDealDate'] = this._expectedDealDate;
    data['tenor'] = this._tenor;
    data['feesRate'] = this._feesRate;
    data['interestRate'] = this._interestRate;
    data['accountNo'] = this._accountNo;
    data['productType'] = this._productType;
    data['netInterestMargin'] = this._netInterestMargin;
    data['feesRevenue'] = this._feesRevenue;
    data['grossRevenue'] = this._grossRevenue;
    data['nrff'] = this._nrff;
    data['totalRevenue'] = this._totalRevenue;
    data['isProspect'] = this._isProspect;
    data['lastComment'] = this._lastComment;
    data['disbursedAmount'] = this._disbursedAmount;
    data['amountLeftToDisburse'] = this._amountLeftToDisburse;
    data['disbursementType'] = this._disbursementType;
    data['transactionComment'] = this._transactionComment;
    data['statusId'] = this._statusId;
    data['status'] = this._status;
    data['subStatus'] = this._subStatus;
    data['dealProbability'] = this._dealProbability;
    data['category'] = this._category;
    data['lastUpdate'] = this._lastUpdate;
    data['canEdit'] = this._canEdit;
    return data;
  }

  factory DealsForDisbursement.fromMap(Map<String, dynamic> map) {
    return DealsForDisbursement(
      pipelineId: map['pipelineId'] ?? '',
      customerName: map['customerName'] ?? '',
      rmName: map['rmName'] ?? '',
      branchName: map['branchName'] ?? '',
      areaName: map['areaName'] ?? '',
      regionName: map['regionName'] ?? '',
      customerType: map['customerType'] ?? '',
      transactionType: map['transactionType'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? '',
      startDate: map['startDate'] ?? '' as DateTime?,
      entryDate: map['entryDate'] ?? '' as DateTime?,
      expectedDealDate: map['expectedDealDate'] ?? '' as DateTime?,
      tenor: map['tenor']?.toInt() ?? 0,
      feesRate: map['feesRate']?.toDouble() ?? 0.0,
      interestRate: map['interestRate']?.toDouble() ?? 0.0,
      accountNo: map['accountNo'] ?? '',
      productType: map['productType'] ?? '',
      netInterestMargin: map['netInterestMargin']?.toDouble() ?? 0.0,
      feesRevenue: map['feesRevenue']?.toDouble() ?? 0.0,
      grossRevenue: map['grossRevenue']?.toDouble() ?? 0.0,
      nrff: map['nrff']?.toDouble() ?? 0.0,
      totalRevenue: map['totalRevenue']?.toDouble() ?? 0.0,
      isProspect: map['isProspect'] ?? '',
      lastComment: map['lastComment'] ?? '',
      disbursedAmount: map['disbursedAmount']?.toDouble() ?? 0.0,
      amountLeftToDisburse: map['amountLeftToDisburse']?.toDouble() ?? 0.0,
      disbursementType: map['disbursementType'] ?? '',
      transactionComment: map['transactionComment'] ?? '',
      statusId: map['statusId'] ?? '',
      status: map['status'] ?? '',
      subStatus: map['subStatus'] ?? '',
      dealProbability: map['dealProbability']?.toDouble() ?? 0.0,
      category: map['category']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate'] ?? '' as DateTime?,
      canEdit: map['canEdit'] ?? true,
    );
  }
}

class CompletedDeals {
  String? _pipelineId;
  String? _customerName;
  String? _rmName;
  String? _branchName;
  String? _areaName;
  String? _regionName;
  String? _customerType;
  String? _transactionType;
  double? _amount;
  String? _currency;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _lastDate;
  DateTime? _entryDate;
  DateTime? _expectedDealDate;
  int? _tenor;
  double? _feesRate;
  double? _interestRate;
  String? _accountNo;
  String? _productType;
  double? _netInterestMargin;
  double? _feesRevenue;
  double? _grossRevenue;
  int? _turnAroundTime;
  double? _nrff;
  double? _totalRevenue;
  String? _isProspect;
  String? _statusComment;
  String? _status;
  String? _statusId;
  String? _subStatus;
  double? _disbursedAmount;
  String? _disbursementType;
  String? _transactionComment;

  CompletedDeals({
    String? pipelineId,
    String? customerName,
    String? rmName,
    String? branchName,
    String? areaName,
    String? regionName,
    String? customerType,
    String? transactionType,
    double? amount,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastDate,
    DateTime? entryDate,
    DateTime? expectedDealDate,
    int? tenor,
    double? feesRate,
    double? interestRate,
    String? accountNo,
    String? productType,
    double? netInterestMargin,
    double? feesRevenue,
    double? grossRevenue,
    int? turnAroundTime,
    double? nrff,
    double? totalRevenue,
    String? isProspect,
    String? statusComment,
    String? status,
    String? statusId,
    String? subStatus,
    double? disbursedAmount,
    String? disbursementType,
    String? transactionComment,
  }) {
    this._pipelineId = pipelineId;
    this._customerName = customerName;
    this._rmName = rmName;
    this._branchName = branchName;
    this._areaName = areaName;
    this._regionName = regionName;
    this._customerType = customerType;
    this._transactionType = transactionType;
    this._amount = amount;
    this._currency = currency;
    this._startDate = startDate;
    this._endDate = endDate;
    this._lastDate = lastDate;
    this._entryDate = entryDate;
    this._expectedDealDate = expectedDealDate;
    this._tenor = tenor;
    this._feesRate = feesRate;
    this._interestRate = interestRate;
    this._accountNo = accountNo;
    this._productType = productType;
    this._netInterestMargin = netInterestMargin;
    this._feesRevenue = feesRevenue;
    this._grossRevenue = grossRevenue;
    this._turnAroundTime = turnAroundTime;
    this._nrff = nrff;
    this._totalRevenue = totalRevenue;
    this._isProspect = isProspect;
    this._statusComment = statusComment;
    this._status = status;
    this._statusId = statusId;
    this._subStatus = subStatus;
    this._disbursedAmount = disbursedAmount;
    this._disbursementType = disbursementType;
    this._transactionComment = transactionComment;
  }

  String? get pipelineId => _pipelineId;
  set pipelineId(String? pipelineId) => _pipelineId = pipelineId;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get rmName => _rmName;
  set rmName(String? rmName) => _rmName = rmName;
  String? get branchName => _branchName;
  set branchName(String? branchName) => _branchName = branchName;
  String? get areaName => _areaName;
  set areaName(String? areaName) => _areaName = areaName;
  String? get regionName => _regionName;
  set regionName(String? regionName) => _regionName = regionName;
  String? get customerType => _customerType;
  set customerType(String? customerType) => _customerType = customerType;
  String? get transactionType => _transactionType;
  set transactionType(String? transactionType) => _transactionType = transactionType;
  double? get amount => _amount;
  set amount(double? amount) => _amount = amount;
  String? get currency => _currency;
  set currency(String? currency) => _currency = currency;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) => _startDate = startDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? endDate) => _endDate = endDate;
  DateTime? get lastDate => _lastDate;
  set lastDate(DateTime? lastDate) => _lastDate = lastDate;
  DateTime? get entryDate => _entryDate;
  set entryDate(DateTime? entryDate) => _entryDate = entryDate;
  DateTime? get expectedDealDate => _expectedDealDate;
  set expectedDealDate(DateTime? expectedDealDate) => _expectedDealDate = expectedDealDate;
  int? get tenor => _tenor;
  set tenor(int? tenor) => _tenor = tenor;
  double? get feesRate => _feesRate;
  set feesRate(double? feesRate) => _feesRate = feesRate;
  double? get interestRate => _interestRate;
  set interestRate(double? interestRate) => _interestRate = interestRate;
  String? get accountNo => _accountNo;
  set accountNo(String? accountNo) => _accountNo = accountNo;
  String? get productType => _productType;
  set productType(String? productType) => _productType = productType;
  double? get netInterestMargin => _netInterestMargin;
  set netInterestMargin(double? netInterestMargin) => _netInterestMargin = netInterestMargin;
  double? get feesRevenue => _feesRevenue;
  set feesRevenue(double? feesRevenue) => _feesRevenue = feesRevenue;
  double? get grossRevenue => _grossRevenue;
  set grossRevenue(double? grossRevenue) => _grossRevenue = grossRevenue;
  int? get turnAroundTime => _turnAroundTime;
  set turnAroundTime(int? turnAroundTime) => _turnAroundTime = turnAroundTime;
  double? get nrff => _nrff;
  set nrff(double? nrff) => _nrff = nrff;
  double? get totalRevenue => _totalRevenue;
  set totalRevenue(double? totalRevenue) => _totalRevenue = totalRevenue;
  String? get isProspect => _isProspect;
  set isProspect(String? isProspect) => _isProspect = isProspect;
  String? get statusComment => _statusComment;
  set statusComment(String? statusComment) => _statusComment = statusComment;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get statusId => _statusId;
  set statusId(String? statusId) => _statusId = statusId;
  String? get subStatus => _subStatus;
  set subStatus(String? subStatus) => _subStatus = subStatus;
  double? get disbursedAmount => _disbursedAmount;
  set disbursedAmount(double? disbursedAmount) => _disbursedAmount;
  String? get disbursementType => _disbursementType;
  set disbursementType(String? disbursementType) => _disbursementType = disbursementType;
  String? get transactionComment => _transactionComment;
  set transactionComment(String? transactionComment) => _transactionComment = transactionComment;

  CompletedDeals.fromJson(Map<String, dynamic> json) {
    _pipelineId = json['pipelineId'];
    _customerName = json['customerName'];
    _rmName = json['rmName'];
    _branchName = json['branchName'];
    _areaName = json['areaName'];
    _regionName = json['regionName'];
    _customerType = json['customerType'];
    _transactionType = json['transactionType'];
    _amount = json['amount'];
    _currency = json['currency'];
    _startDate = json['startDate'] == null ? DateTime.now() : DateTime.parse(json['startDate']);
    _endDate = DateTime.parse(json['endDate']);
    _lastDate = json['lastDate'] == null ? DateTime.now() : DateTime.parse(json['lastDate']);
    _entryDate = DateTime.parse(json['entryDate']);
    _expectedDealDate = DateTime.parse(json['expectedDealDate']);
    _tenor = json['tenor'];
    _feesRate = json['feesRate'];
    _interestRate = json['interestRate'];
    _accountNo = json['accountNo'];
    _productType = json['productType'];
    _netInterestMargin = json['netInterestMargin'];
    _feesRevenue = json['feesRevenue'];
    _grossRevenue = json['grossRevenue'];
    _turnAroundTime = json['turnAroundTime'];
    _nrff = json['nrff'];
    _totalRevenue = json['totalRevenue'];
    _isProspect = json['isProspect'];
    _statusComment = json['statusComment'];
    _status = json['status'];
    _statusId = json['statusId'];
    _subStatus = json['subStatus'];
    _disbursedAmount = json['disbursedAmount'];
    _transactionComment = json['transactionComment'];
    _disbursementType = json['disbursementType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pipelineId'] = this._pipelineId;
    data['customerName'] = this._customerName;
    data['rmName'] = this._rmName;
    data['branchName'] = this._branchName;
    data['areaName'] = this._areaName;
    data['regionName'] = this._regionName;
    data['customerType'] = this._customerType;
    data['transactionType'] = this._transactionType;
    data['amount'] = this._amount;
    data['currency'] = this._currency;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['lastDate'] = this._lastDate;
    data['entryDate'] = this._entryDate;
    data['expectedDealDate'] = this._expectedDealDate;
    data['tenor'] = this._tenor;
    data['feesRate'] = this._feesRate;
    data['interestRate'] = this._interestRate;
    data['accountNo'] = this._accountNo;
    data['productType'] = this._productType;
    data['netInterestMargin'] = this._netInterestMargin;
    data['feesRevenue'] = this._feesRevenue;
    data['grossRevenue'] = this._grossRevenue;
    data['turnAroundTime'] = this._turnAroundTime;
    data['nrff'] = this._nrff;
    data['totalRevenue'] = this._totalRevenue;
    data['isProspect'] = this._isProspect;
    data['statusComment'] = this._statusComment;
    data['status'] = this._status;
    data['statusId'] = this._statusId;
    data['subStatus'] = this._subStatus;
    data['disbursedAmount'] = this._disbursedAmount;
    data['transactionComment'] = this._transactionComment;
    data['disbursementType'] = this._disbursementType;
    return data;
  }

  factory CompletedDeals.fromMap(Map<String, dynamic> map) {
    return CompletedDeals(
      pipelineId: map['pipelineId'] ?? '',
      customerName: map['customerName'] ?? '',
      rmName: map['rmName'] ?? '',
      branchName: map['branchName'] ?? '',
      areaName: map['areaName'] ?? '',
      regionName: map['regionName'] ?? '',
      customerType: map['customerType'] ?? '',
      transactionType: map['transactionType'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? '',
      startDate: map['startDate'] ?? '' as DateTime?,
      endDate: map['endDate'] ?? '' as DateTime?,
      lastDate: map['lastDate'] ?? '' as DateTime?,
      entryDate: map['entryDate'] ?? '' as DateTime?,
      expectedDealDate: map['expectedDealDate'] ?? '' as DateTime?,
      tenor: map['tenor']?.toInt() ?? 0,
      feesRate: map['feesRate']?.toDouble() ?? 0.0,
      interestRate: map['interestRate']?.toDouble() ?? 0.0,
      accountNo: map['accountNo'] ?? '',
      productType: map['productType'] ?? '',
      netInterestMargin: map['netInterestMargin']?.toDouble() ?? 0.0,
      feesRevenue: map['feesRevenue']?.toDouble() ?? 0.0,
      grossRevenue: map['grossRevenue']?.toDouble() ?? 0.0,
      turnAroundTime: map['turnAroundTime']?.toInt() ?? 0,
      nrff: map['nrff']?.toDouble() ?? 0.0,
      totalRevenue: map['totalRevenue']?.toDouble() ?? 0.0,
      isProspect: map['isProspect'] ?? '',
      statusComment: map['statusComment'] ?? '',
      status: map['status'] ?? '',
      statusId: map['statusId'] ?? '',
      subStatus: map['subStatus'] ?? '',
      disbursedAmount: map['disbursedAmount'],
      transactionComment: map['transactionComment'] ?? '',
      disbursementType: map['disbursementType'] ?? '',
    );
  }
}


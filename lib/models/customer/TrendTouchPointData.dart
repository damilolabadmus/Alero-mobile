class TrendTouchPointData {
  dynamic _custAccountNo;
  dynamic _customerGroupNo;
  dynamic _branchCode;
  dynamic _period;
  String _debitCreditIndicator;
  String _transactionChannel;
  String _touchPointCount;
  String _transactionVolume;

  TrendTouchPointData(
      {dynamic custAccountNo,
        dynamic customerGroupNo,
        dynamic branchCode,
        dynamic period,
        String debitCreditIndicator,
        String transactionChannel,
        String touchPointCount,
        String transactionVolume}) {
    this._custAccountNo = custAccountNo;
    this._customerGroupNo = customerGroupNo;
    this._branchCode = branchCode;
    this._period = period;
    this._debitCreditIndicator = debitCreditIndicator;
    this._transactionChannel = transactionChannel;
    this._touchPointCount = touchPointCount;
    this._transactionVolume = transactionVolume;
  }

  dynamic get custAccountNo => _custAccountNo;
  set custAccountNo(dynamic custAccountNo) => _custAccountNo = custAccountNo;
  dynamic get customerGroupNo => _customerGroupNo;
  set customerGroupNo(dynamic customerGroupNo) => _customerGroupNo = customerGroupNo;
  dynamic get branchCode => _branchCode;
  set branchCode(dynamic branchCode) => _branchCode = branchCode;
  dynamic get period => _period;
  set period(dynamic period) => _period = period;
  String get debitCreditIndicator => _debitCreditIndicator;
  set debitCreditIndicator(String debitCreditIndicator) => _debitCreditIndicator = debitCreditIndicator;
  String get transactionChannel => _transactionChannel;
  set transactionChannel(String transactionChannel) => _transactionChannel = transactionChannel;
  String get touchPointCount => _touchPointCount;
  set touchPointCount(String touchPointCount) => _touchPointCount = touchPointCount;
  String get transactionVolume => _transactionVolume;
  set transactionVolume(String transactionVolume) => _transactionVolume = transactionVolume;

  TrendTouchPointData.fromJson(Map<String, dynamic> json) {
    _custAccountNo = json['custAccountNo'];
    _customerGroupNo = json['customerGroupNo'];
    _branchCode = json['branchCode'];
    _period = json['period'];
    _debitCreditIndicator = json['debitCreditIndicator'];
    _transactionChannel = json['transactionChannel'];
    _touchPointCount = json['touchPointCount'];
    _transactionVolume = json['transactionVolume'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custAccountNo'] = this._custAccountNo;
    data['customerGroupNo'] = this._customerGroupNo;
    data['branchCode'] = this._branchCode;
    data['period'] = this._period;
    data['debitCreditIndicator'] = this._debitCreditIndicator;
    data['transactionChannel'] = this._transactionChannel;
    data['touchPointCount'] = this._touchPointCount;
    data['transactionVolume'] = this._transactionVolume;
    return data;
  }

  factory TrendTouchPointData.fromMap(Map<String, dynamic> map) {
    return TrendTouchPointData(
      custAccountNo: map['custAccountNo'] ?? '',
      customerGroupNo: map['customerGroupNo'] ?? '',
      branchCode: map['branchCode'] ?? '',
      period: map['period'] ?? '',
      debitCreditIndicator: map['debitCreditIndicator'] ?? '',
      transactionChannel: map['transactionChannel'] ?? '',
      touchPointCount: map['touchPointCount'] ?? '',
      transactionVolume: map['transactionVolume'] ?? '',
    );
  }
}


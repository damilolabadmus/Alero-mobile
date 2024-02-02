

class LoanClassificationStatus{
  String? _rmCode;
  String? _loanStatus;
  int? _loanStatusCount;
  double? _loanStatusAmount;

  LoanClassificationStatus(
      {String? rmCode,
        String? loanStatus,
        int? loanStatusCount,
        double? loanStatusAmount}) {
    this._rmCode = rmCode;
    this._loanStatus = loanStatus;
    this._loanStatusCount = loanStatusCount;
    this._loanStatusAmount = loanStatusAmount;
  }

  String? get rmCode => _rmCode;
  set rmCode(String? rmCode) => _rmCode = rmCode;
  String? get loanStatus => _loanStatus;
  set loanStatus(String? loanStatus) => _loanStatus = loanStatus;
  int? get loanStatusCount => _loanStatusCount;
  set loanStatusCount(int? loanStatusCount) => _loanStatusCount = loanStatusCount;
  double? get loanStatusAmount => _loanStatusAmount;
  set loanStatusAmount(double? loanStatusAmount) => _loanStatusAmount = loanStatusAmount;

  LoanClassificationStatus.fromJson(Map<String, dynamic> json) {
    _rmCode = json['rmCode'];
    _loanStatus = json['loanStatus'];
    _loanStatusCount = json['loanStatusCount'];
    _loanStatusAmount = json['loanStatusAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rmCode'] = this._rmCode;
    data['loanStatus'] = this._loanStatus;
    data['loanStatusCount'] = this._loanStatusCount;
    data['loanStatusAmount'] = this._loanStatusAmount;
    return data;
  }

  factory LoanClassificationStatus.fromMap(Map<String, dynamic> map) {
    return LoanClassificationStatus(
      rmCode: map['rmCode'] ?? '',
      loanStatus: map['loanStatus'] ?? '',
      loanStatusCount: map['loanStatusCount']?.toInt() ?? 0,
      loanStatusAmount: map['loanStatusAmount']?.toDouble() ?? 00,
    );
  }
}


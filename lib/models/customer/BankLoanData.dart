

class BankLoanData{
  double? _actualLoans;
  double? _actualLoansChange;
  double? _averageLoans;
  double? _averageLoansChange;
  double? _loansData;
  String? _periodName;

  BankLoanData(
      {double? actualLoans,
        double? actualLoansChange,
        double? averageLoans,
        double? averageLoansChange,
        double? loansData,
        String? periodName,
      }) {
    this._actualLoans = actualLoans;
    this._actualLoansChange = actualLoansChange;
    this._averageLoans = averageLoans;
    this._averageLoansChange = averageLoansChange;
    this._loansData = loansData;
    this._periodName = periodName;
  }

  double? get actualLoans => _actualLoans;
  set actualLoans(double? actualLoans) => _actualLoans = actualLoans;
  double? get actualLoansChange => _actualLoansChange;
  set actualLoansChange(double? actualLoansChange) => _actualLoansChange = actualLoansChange;
  double? get averageLoans => _averageLoans;
  set averageLoans(double? averageLoans) => _averageLoans = averageLoans;
  double? get averageLoansChange => _averageLoansChange;
  set averageLoansChange(double? averageLoansChange) => _averageLoansChange = averageLoansChange;
  double? get loansData => _loansData;
  set loansData(double? loansData) => _loansData = loansData;
  String? get periodName => _periodName;
  set periodName(String? periodName) => _periodName = periodName;

  BankLoanData.fromJson(Map<String, dynamic> json) {
    _actualLoans = json['actualLoans'];
    _actualLoansChange = json['actualLoansChange'];
    _averageLoans = json['averageLoans'];
    _averageLoansChange = json['averageLoansChange'];
    _loansData = json['loansData'];
    _periodName = json['periodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualLoans'] = this._actualLoans;
    data['actualLoansChange'] = this._actualLoansChange;
    data['averageLoans'] = this._averageLoans;
    data['averageLoansChange'] = this._averageLoansChange;
    data['loansData'] = this._loansData;
    data['periodName'] = this._periodName;
    return data;
  }

  factory BankLoanData.fromMap(Map<String, dynamic> map) {
    return BankLoanData(
      actualLoans: map['actualLoans']?.toDouble() ?? 0.0,
      actualLoansChange: map['actualLoansChange']?.toDouble() ?? 0.0,
      averageLoans: map['averageLoans']?.toDouble() ?? 0.0,
      averageLoansChange: map['averageLoansChange']?.toDouble() ?? 0.0,
      loansData: map['loansData']?.toDouble() ?? 0.0,
      periodName: map['periodName'] ?? '',
    );
  }
}

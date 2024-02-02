

class BankDepositsData {
  double? _actualDeposits;
  double? _actualDepositsChange;
  double? _averageDepositsChange;
  double? _averageDeposits;
  double? _depositsData;
  String? _periodName;

  BankDepositsData(
      {double? actualDeposits,
        double? actualDepositsChange,
        double? averageDepositsChange,
        double? averageDeposits,
        double? depositsData,
        String? periodName,
      }) {
    this._actualDeposits = actualDeposits;
    this._actualDepositsChange = actualDepositsChange;
    this._averageDepositsChange = averageDepositsChange;
    this._averageDeposits = averageDeposits;
    this._depositsData = depositsData;
    this._periodName = periodName;
  }

  double? get actualDeposits => _actualDeposits;
  set actualDeposits(double? actualDeposits) => _actualDeposits = actualDeposits;
  double? get actualDepositsChange => _actualDepositsChange;
  set actualDepositsChange(double? actualDepositsChange) =>
      _actualDepositsChange = actualDepositsChange;
  double? get averageDepositsChange => _averageDepositsChange;
  set averageDepositsChange(double? averageDepositsChange) =>
      _averageDepositsChange = averageDepositsChange;
  double? get averageDeposits => _averageDeposits;
  set averageDeposits(double? averageDeposits) => _averageDeposits = averageDeposits;
  double? get depositsData => _depositsData;
  set depositsData(double? depositsData) => _depositsData = depositsData;
  String? get periodName => _periodName;
  set periodName(String? periodName) => _periodName = periodName;

  BankDepositsData.fromJson(Map<String, dynamic> json) {
    _actualDeposits = json['actualDeposits'];
    _actualDepositsChange = json['actualDepositsChange'];
    _averageDepositsChange = json['averageDepositsChange'];
    _averageDeposits = json['averageDeposits'];
    _depositsData = json['depositsData'];
    _periodName = json['periodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualDeposits'] = this._actualDeposits;
    data['actualDepositsChange'] = this._actualDepositsChange;
    data['averageDepositsChange'] = this._averageDepositsChange;
    data['averageDeposits'] = this._averageDeposits;
    data['depositsData'] = this._depositsData;
    data['periodName'] = this._periodName;
    return data;
  }

  factory BankDepositsData.fromMap(Map<String, dynamic> map) {
    return BankDepositsData(
      actualDeposits: map['actualDeposits']?.toDuble() ?? 0.0,
      actualDepositsChange: map['actualDepositsChange']?.toDouble() ?? 0.0,
      averageDepositsChange: map['averageDepositsChange']?.toDouble() ?? 0.0,
      averageDeposits: map['averageDeposits']?.toDouble() ?? 0.0,
      depositsData: map['depositsData']?.toDouble() ?? 0.0,
      periodName: map['periodName'] ?? '',
    );
  }
}

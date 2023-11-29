class RevenueChartData {
  String _periodCode;
  String _periodName;
  double _revenueData;
  double _depositsData;
  double _loansData;

  RevenueChartData(
      {String periodCode,
        String periodName,
        double revenueData,
        double depositsData,
        double loansData,
      }) {
    this._periodCode = periodCode;
    this._periodName = periodName;
    this._revenueData = revenueData;
    this._depositsData = depositsData;
    this._loansData = loansData;
  }

  String get periodCode => _periodCode;
  set periodCode(String periodCode) => _periodCode = periodCode;
  String get periodName => _periodName;
  set periodName(String periodName) => _periodName = periodName;
  double get revenueData => _revenueData;
  set revenueData(double revenueData) => _revenueData = revenueData;
  double get depositsData => _depositsData;
  set depositsData(double depositsData) => _depositsData = depositsData;
  double get loansData => _loansData;
  set loansData(double loansData) => _loansData = loansData;



  RevenueChartData.fromJson(Map<String, dynamic> json) {
    _periodCode = json['periodCode'];
    _periodName = json['periodName'];
    _revenueData = json['revenueData'];
    _depositsData = json['depositsData'];
    _loansData = json['loansData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['periodCode'] = this._periodCode;
    data['periodName'] = this._periodName;
    data['revenueData'] = this._revenueData;
    data['depositsData'] = this._depositsData;
    data['loansData'] = this._loansData;
    return data;
  }

  factory RevenueChartData.fromMap(Map<String, dynamic> map) {
    return RevenueChartData(
      periodCode: map['periodCode'] ?? '',
      periodName: map['periodName'] ?? '',
      revenueData: map['revenueData']?.toDouble() ?? 0.0,
      depositsData: map['depositsData']?.toDouble() ?? 0.0,
      loansData: map['loansData']?.toDouble() ?? 0.0,
    );
  }
}
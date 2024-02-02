

class BankRevenueData{
  double? _ytdRevenue;
  double? _loansRevenue;
  double? _depositsRevenue;
  double? _commFeesRevenue;
  double? _revenueData;
  String? _periodName;

  BankRevenueData(
      {double? ytdRevenue,
        double? loansRevenue,
        double? depositsRevenue,
        double? commFeesRevenue,
        double? revenueData,
        String? periodName,
      }) {
    this._ytdRevenue = ytdRevenue;
    this._loansRevenue = loansRevenue;
    this._depositsRevenue = depositsRevenue;
    this._commFeesRevenue = commFeesRevenue;
    this._revenueData = revenueData;
    this._periodName = periodName;
  }

  double? get ytdRevenue => _ytdRevenue;
  set ytdRevenue(double? ytdRevenue) => _ytdRevenue = ytdRevenue;
  double? get loansRevenue => _loansRevenue;
  set loansRevenue(double? loansRevenue) => _loansRevenue = loansRevenue;
  double? get depositsRevenue => _depositsRevenue;
  set depositsRevenue(double? depositsRevenue) => _depositsRevenue = depositsRevenue;
  double? get commFeesRevenue => _commFeesRevenue;
  set commFeesRevenue(double? commFeesRevenue) => _commFeesRevenue = commFeesRevenue;
  double? get revenueData => _revenueData;
  set revenueData(double? revenueData) => _revenueData = revenueData;
  String? get periodName => _periodName;
  set periodName(String? periodName) => _periodName = periodName;

  BankRevenueData.fromJson(Map<String, dynamic> json) {
    _ytdRevenue = json['ytdRevenue'];
    _loansRevenue = json['loansRevenue'];
    _depositsRevenue = json['depositsRevenue'];
    _commFeesRevenue = json['commFeesRevenue'];
    _revenueData = json['revenueData'];
    _periodName = json['periodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ytdRevenue'] = this._ytdRevenue;
    data['loansRevenue'] = this._loansRevenue;
    data['depositsRevenue'] = this._depositsRevenue;
    data['commFeesRevenue'] = this._commFeesRevenue;
    data['revenueData'] = this._revenueData;
    data['periodName'] = this._periodName;
    return data;
  }

  factory BankRevenueData.fromMap(Map<String, dynamic> map) {
    return BankRevenueData(
      ytdRevenue: map['ytdRevenue'] ?.toDouble() ?? 0.0,
      loansRevenue: map['loansRevenue']?.toDouble() ?? 0.0,
      depositsRevenue: map['depositsRevenue']?.toDouble() ?? 0.0,
      commFeesRevenue: map['commFeesRevenue']?.toDouble() ?? 0.0,
      revenueData: map['revenueData']?.toDouble() ?? 0.0,
      periodName: map['periodName'] ?? '',
    );
  }
}

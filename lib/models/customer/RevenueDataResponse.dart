

class RevenueDataResponse {
  String? _groupId;
  String? _customerId;
  double? _depositBalance;
  double? _loanBalance;
  double? _ytdRevenue;
  double? _prevMonthRevenue;

  RevenueDataResponse(
      {String? groupId,
        String? customerId,
        double? depositBalance,
        double? loanBalance,
        double? ytdRevenue,
        double? prevMonthRevenue}) {
    this._groupId = groupId;
    this._customerId = customerId;
    this._depositBalance = depositBalance;
    this._loanBalance = loanBalance;
    this._ytdRevenue = ytdRevenue;
    this._prevMonthRevenue = prevMonthRevenue;
  }

  String? get groupId => _groupId;
  set groupId(String? groupId) => _groupId = groupId;
  String? get customerId => _customerId;
  set customerId(String? customerId) => _customerId = customerId;
  double? get depositBalance => _depositBalance;
  set depositBalance(double? depositBalance) => _depositBalance = depositBalance;
  double? get loanBalance => _loanBalance;
  set loanBalance(double? loanBalance) => _loanBalance = loanBalance;
  double? get ytdRevenue => _ytdRevenue;
  set ytdRevenue(double? ytdRevenue) => _ytdRevenue = ytdRevenue;
  double? get prevMonthRevenue => _prevMonthRevenue;
  set prevMonthRevenue(double? prevMonthRevenue) =>
      _prevMonthRevenue = prevMonthRevenue;

  RevenueDataResponse.fromJson(Map<String, dynamic> json) {
    _groupId = json['groupId'];
    _customerId = json['customerId'];
    _depositBalance = json['depositBalance'];
    _loanBalance = json['loanBalance'];
    _ytdRevenue = json['ytdRevenue'];
    _prevMonthRevenue = json['prevMonthRevenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this._groupId;
    data['customerId'] = this._customerId;
    data['depositBalance'] = this._depositBalance;
    data['loanBalance'] = this._loanBalance;
    data['ytdRevenue'] = this._ytdRevenue;
    data['prevMonthRevenue'] = this._prevMonthRevenue;
    return data;
  }
}
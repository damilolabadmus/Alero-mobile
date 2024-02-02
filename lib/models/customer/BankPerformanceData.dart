

class BankPerformanceData{
  double? _customerCount;
  double? _ytdCustomerCount;
  double? _accountCount;
  double? _ytdAccountCount;

  BankPerformanceData(
      {double? customerCount,
        double? ytdCustomerCount,
        double? accountCount,
        double? ytdAccountCount}) {
    this._customerCount = customerCount;
    this._ytdCustomerCount = ytdCustomerCount;
    this._accountCount = accountCount;
    this._ytdAccountCount = ytdAccountCount;
  }

  double? get customerCount => _customerCount;
  set customerCount(double? customerCount) => _customerCount = customerCount;
  double? get ytdCustomerCount => _ytdCustomerCount;
  set ytdCustomerCount(double? ytdCustomerCount) => _ytdCustomerCount = ytdCustomerCount;
  double? get accountCount => _accountCount;
  set accountCount(double? accountCount) => _accountCount = accountCount;
  double? get ytdAccountCount => _ytdAccountCount;
  set ytdAccountCount(double? ytdAccountCount) => _ytdAccountCount = ytdAccountCount;

  BankPerformanceData.fromJson(Map<String, dynamic> json) {
    _customerCount = json['customerCount'];
    _ytdCustomerCount = json['ytdCustomerCount'];
    _accountCount = json['accountCount'];
    _ytdAccountCount = json['ytdAccountCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerCount'] = this._customerCount;
    data['ytdCustomerCount'] = this._ytdCustomerCount;
    data['accountCount'] = this._accountCount;
    data['ytdAccountCount'] = this._ytdAccountCount;
    return data;
  }
}

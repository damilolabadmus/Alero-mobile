class TransactionFlow {
  double _totalSpend;
  String _transactionDate;
  int _transactionCount;
  double _averageSpend;

  TransactionFlow(
      {double totalSpend,
        String transactionDate,
        int transactionCount,
        double averageSpend}) {
    this._totalSpend = totalSpend;
    this._transactionDate = transactionDate;
    this._transactionCount = transactionCount;
    this._averageSpend = averageSpend;
  }

  double get totalSpend => _totalSpend;
  set totalSpend(double totalSpend) => _totalSpend = totalSpend;
  String get transactionDate => _transactionDate;
  set transactionDate(String transactionDate) =>
      _transactionDate = transactionDate;
  int get transactionCount => _transactionCount;
  set transactionCount(int transactionCount) =>
      _transactionCount = transactionCount;
  double get averageSpend => _averageSpend;
  set averageSpend(double averageSpend) => _averageSpend = averageSpend;

  TransactionFlow.fromJson(Map<String, dynamic> json) {
    _totalSpend = json['totalSpend'];
    _transactionDate = json['transactionDate'];
    _transactionCount = json['transactionCount'];
    _averageSpend = json['averageSpend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSpend'] = this._totalSpend;
    data['transactionDate'] = this._transactionDate;
    data['transactionCount'] = this._transactionCount;
    data['averageSpend'] = this._averageSpend;
    return data;
  }
}

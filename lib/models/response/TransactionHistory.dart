class TransactionHistory {
  bool _inflow;
  String _transactionDescription;
  String _transactionDate;
  double _amount;

  TransactionHistory({bool inflow,
    String transactionDescription,
    String transactionDate,
    double amount}) {
    this._inflow = inflow;
    this._transactionDescription = transactionDescription;
    this._transactionDate = transactionDate;
    this._amount = amount;
  }

  bool get inflow => _inflow;

  set inflow(bool inflow) => _inflow = inflow;

  String get transactionDescription => _transactionDescription;

  set transactionDescription(String transactionDescription) =>
      _transactionDescription = transactionDescription;

  String get transactionDate => _transactionDate;

  set transactionDate(String transactionDate) =>
      _transactionDate = transactionDate;

  double get amount => _amount;

  set amount(double amount) => _amount = amount;

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    _inflow = json['inflow'];
    _transactionDescription = json['transactionDescription'];
    _transactionDate = json['transactionDate'];
    _amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflow'] = this._inflow;
    data['transactionDescription'] = this._transactionDescription;
    data['transactionDate'] = this._transactionDate;
    data['amount'] = this._amount;
    return data;
  }
}
class AccountList {
  String _accountType;
  String _accountNumber;
  String _createdAddress;
  String _createdDate;
  double _balance;
  String _active;
  String _currency;

  AccountList(
      {String accountType,
        String accountNumber,
        String createdAddress,
        String createdDate,
        double balance,
        String active,
        String currency}) {
    this._accountType = accountType;
    this._accountNumber = accountNumber;
    this._createdAddress = createdAddress;
    this._createdDate = createdDate;
    this._balance = balance;
    this._active = active;
    this._currency = currency;
  }

  String get accountType => _accountType;
  set accountType(String accountType) => _accountType = accountType;
  String get accountNumber => _accountNumber;
  set accountNumber(String accountNumber) => _accountNumber = accountNumber;
  String get createdAddress => _createdAddress;
  set createdAddress(String createdAddress) => _createdAddress = createdAddress;
  String get createdDate => _createdDate;
  set createdDate(String createdDate) => _createdDate = createdDate;
  double get balance => _balance;
  set balance(double balance) => _balance = balance;
  String get active => _active;
  set active(String active) => _active = active;
  String get currency => _currency;
  set currency(String currency) => _currency = currency;

  AccountList.fromJson(Map<String, dynamic> json) {
    _accountType = json['accountType'];
    _accountNumber = json['accountNumber'];
    _createdAddress = json['createdAddress'];
    _createdDate = json['createdDate'];
    _balance = json['balance'];
    _active = json['active'];
    _currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountType'] = this._accountType;
    data['accountNumber'] = this._accountNumber;
    data['createdAddress'] = this._createdAddress;
    data['createdDate'] = this._createdDate;
    data['balance'] = this._balance;
    data['active'] = this._active;
    data['currency'] = this._currency;
    return data;
  }
}

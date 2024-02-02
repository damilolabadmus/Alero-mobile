

class InvestmentDataResponse {
  String? _groupId;
  String? _customerId;
  String? _accountNumber;
  String? _contractReferenceNumber;
  String? _currency;
  int? _ccyAmount;
  int? _lcyAmount;
  String? _productCode;
  String? _productName;
  String? _bookingDate;
  String? _expiryDate;
  String? _investmentTenor;
  String? _investmentStatus;

  InvestmentDataResponse(
      {String? groupId,
        String? customerId,
        String? accountNumber,
        String? contractReferenceNumber,
        String? currency,
        int? ccyAmount,
        int? lcyAmount,
        String? productCode,
        String? productName,
        String? bookingDate,
        String? expiryDate,
        String? investmentTenor,
        String? investmentStatus}) {
    this._groupId = groupId;
    this._customerId = customerId;
    this._accountNumber = accountNumber;
    this._contractReferenceNumber = contractReferenceNumber;
    this._currency = currency;
    this._ccyAmount = ccyAmount;
    this._lcyAmount = lcyAmount;
    this._productCode = productCode;
    this._productName = productName;
    this._bookingDate = bookingDate;
    this._expiryDate = expiryDate;
    this._investmentTenor = investmentTenor;
    this._investmentStatus = investmentStatus;
  }

  String? get groupId => _groupId;
  set groupId(String? groupId) => _groupId = groupId;
  String? get customerId => _customerId;
  set customerId(String? customerId) => _customerId = customerId;
  String? get accountNumber => _accountNumber;
  set accountNumber(String? accountNumber) => _accountNumber = accountNumber;
  String? get contractReferenceNumber => _contractReferenceNumber;
  set contractReferenceNumber(String? contractReferenceNumber) =>
      _contractReferenceNumber = contractReferenceNumber;
  String? get currency => _currency;
  set currency(String? currency) => _currency = currency;
  int? get ccyAmount => _ccyAmount;
  set ccyAmount(int? ccyAmount) => _ccyAmount = ccyAmount;
  int? get lcyAmount => _lcyAmount;
  set lcyAmount(int? lcyAmount) => _lcyAmount = lcyAmount;
  String? get productCode => _productCode;
  set productCode(String? productCode) => _productCode = productCode;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  String? get expiryDate => _expiryDate;
  set expiryDate(String? expiryDate) => _expiryDate = expiryDate;
  String? get investmentTenor => _investmentTenor;
  set investmentTenor(String? investmentTenor) =>
      _investmentTenor = investmentTenor;
  String? get investmentStatus => _investmentStatus;
  set investmentStatus(String? investmentStatus) =>
      _investmentStatus = investmentStatus;

  InvestmentDataResponse.fromJson(Map<String, dynamic> json) {
    _groupId = json['groupId'];
    _customerId = json['customerId'];
    _accountNumber = json['accountNumber'];
    _contractReferenceNumber = json['contractReferenceNumber'];
    _currency = json['currency'];
    _ccyAmount = json['ccyAmount'];
    _lcyAmount = json['lcyAmount'];
    _productCode = json['productCode'];
    _productName = json['productName'];
    _bookingDate = json['bookingDate'];
    _expiryDate = json['expiryDate'];
    _investmentTenor = json['investmentTenor'];
    _investmentStatus = json['investmentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this._groupId;
    data['customerId'] = this._customerId;
    data['accountNumber'] = this._accountNumber;
    data['contractReferenceNumber'] = this._contractReferenceNumber;
    data['currency'] = this._currency;
    data['ccyAmount'] = this._ccyAmount;
    data['lcyAmount'] = this._lcyAmount;
    data['productCode'] = this._productCode;
    data['productName'] = this._productName;
    data['bookingDate'] = this._bookingDate;
    data['expiryDate'] = this._expiryDate;
    data['investmentTenor'] = this._investmentTenor;
    data['investmentStatus'] = this._investmentStatus;
    return data;
  }
}
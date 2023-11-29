class BankingDataResponse {
  String _groupId;
  String _customerId;
  String _accountNumber;
  String _branchCode;
  String _branchName;
  String _accountClassCode;
  String _accountClassName;
  String _tsp;
  String _currency;
  double _ccyBalance;
  String _acctOpeningDate;
  String _dormantStatus;
  String _pndStatus;
  String _pndReason;
  String _pndDate;
  String _activeStatus;
  String _bankState;
  String _bankRegion;

  BankingDataResponse(
      {String groupId,
        String customerId,
        String accountNumber,
        String branchCode,
        String branchName,
        String accountClassCode,
        String accountClassName,
        String tsp,
        String currency,
        double ccyBalance,
        String acctOpeningDate,
        String dormantStatus,
        String pndStatus,
        String pndReason,
        String pndDate,
        String activeStatus,
        String bankState,
        String bankRegion}) {
    this._groupId = groupId;
    this._customerId = customerId;
    this._accountNumber = accountNumber;
    this._branchCode = branchCode;
    this._branchName = branchName;
    this._accountClassCode = accountClassCode;
    this._accountClassName = accountClassName;
    this._tsp = tsp;
    this._currency = currency;
    this._ccyBalance = ccyBalance;
    this._acctOpeningDate = acctOpeningDate;
    this._dormantStatus = dormantStatus;
    this._pndStatus = pndStatus;
    this._pndReason = pndReason;
    this._pndDate = pndDate;
    this._activeStatus = activeStatus;
    this._bankState = bankState;
    this._bankRegion = bankRegion;
  }

  String get groupId => _groupId;
  set groupId(String groupId) => _groupId = groupId;
  String get customerId => _customerId;
  set customerId(String customerId) => _customerId = customerId;
  String get accountNumber => _accountNumber;
  set accountNumber(String accountNumber) => _accountNumber = accountNumber;
  String get branchCode => _branchCode;
  set branchCode(String branchCode) => _branchCode = branchCode;
  String get branchName => _branchName;
  set branchName(String branchName) => _branchName = branchName;
  String get accountClassCode => _accountClassCode;
  set accountClassCode(String accountClassCode) =>
      _accountClassCode = accountClassCode;
  String get accountClassName => _accountClassName;
  set accountClassName(String accountClassName) =>
      _accountClassName = accountClassName;
  String get tsp => _tsp;
  set tsp(String tsp) => _tsp = tsp;
  String get currency => _currency;
  set currency(String currency) => _currency = currency;
  double get ccyBalance => _ccyBalance;
  set ccyBalance(double ccyBalance) => _ccyBalance = ccyBalance;
  String get acctOpeningDate => _acctOpeningDate;
  set acctOpeningDate(String acctOpeningDate) =>
      _acctOpeningDate = acctOpeningDate;
  String get dormantStatus => _dormantStatus;
  set dormantStatus(String dormantStatus) => _dormantStatus = dormantStatus;
  String get pndStatus => _pndStatus;
  set pndStatus(String pndStatus) => _pndStatus = pndStatus;
  String get pndReason => _pndReason;
  set pndReason(String pndReason) => _pndReason = pndReason;
  String get pndDate => _pndDate;
  set pndDate(String pndDate) => _pndDate = pndDate;
  String get activeStatus => _activeStatus;
  set activeStatus(String activeStatus) => _activeStatus = activeStatus;
  String get bankState => _bankState;
  set bankState(String bankState) => _bankState = bankState;
  String get bankRegion => _bankRegion;
  set bankRegion(String bankRegion) => _bankRegion = bankRegion;

  BankingDataResponse.fromJson(Map<String, dynamic> json) {
    _groupId = json['groupId'];
    _customerId = json['customerId'];
    _accountNumber = json['accountNumber'];
    _branchCode = json['branchCode'];
    _branchName = json['branchName'];
    _accountClassCode = json['accountClassCode'];
    _accountClassName = json['accountClassName'];
    _tsp = json['tsp'];
    _currency = json['currency'];
    _ccyBalance = json['ccyBalance'];
    _acctOpeningDate = json['acctOpeningDate'];
    _dormantStatus = json['dormantStatus'];
    _pndStatus = json['pndStatus'];
    _pndReason = json['pndReason'];
    _pndDate = json['pndDate'];
    _activeStatus = json['activeStatus'];
    _bankState = json['bankState'];
    _bankRegion = json['bankRegion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this._groupId;
    data['customerId'] = this._customerId;
    data['accountNumber'] = this._accountNumber;
    data['branchCode'] = this._branchCode;
    data['branchName'] = this._branchName;
    data['accountClassCode'] = this._accountClassCode;
    data['accountClassName'] = this._accountClassName;
    data['tsp'] = this._tsp;
    data['currency'] = this._currency;
    data['ccyBalance'] = this._ccyBalance;
    data['acctOpeningDate'] = this._acctOpeningDate;
    data['dormantStatus'] = this._dormantStatus;
    data['pndStatus'] = this._pndStatus;
    data['pndReason'] = this._pndReason;
    data['pndDate'] = this._pndDate;
    data['activeStatus'] = this._activeStatus;
    data['bankState'] = this._bankState;
    data['bankRegion'] = this._bankRegion;
    return data;
  }
}
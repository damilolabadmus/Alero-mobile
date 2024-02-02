

class CustomerList {
  String? _customerId;
  String? _customerName;
  String? _businessSegment;
  int? _activeYear;
  bool? _active;

  CustomerList(
      {String? customerId,
        String? customerName,
        String? businessSegment,
        int? activeYear,
        bool? active}) {
    this._customerId = customerId;
    this._customerName = customerName;
    this._businessSegment = businessSegment;
    this._activeYear = activeYear;
    this._active = active;
  }

  String? get customerId => _customerId;
  set customerId(String? customerId) => _customerId = customerId;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get businessSegment => _businessSegment;
  set businessSegment(String? businessSegment) =>
      _businessSegment = businessSegment;
  int? get activeYear => _activeYear;
  set activeYear(int? activeYear) => _activeYear = activeYear;
  bool? get active => _active;
  set active(bool? active) => _active = active;

  CustomerList.fromJson(Map<String, dynamic> json) {
    _customerId = json['customerId'];
    _customerName = json['customerName'];
    _businessSegment = json['businessSegment'];
    _activeYear = json['activeYear'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this._customerId;
    data['customerName'] = this._customerName;
    data['businessSegment'] = this._businessSegment;
    data['activeYear'] = this._activeYear;
    data['active'] = this._active;
    return data;
  }
}

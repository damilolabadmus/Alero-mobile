class LifestyleCount {
  String _groupId;
  String _customerId;
  String _lifestyleType;
  double _lifestyleCount;
  double _lifestyleValue;

  LifestyleCount(
      {String groupId,
        String customerId,
        String lifestyleType,
        double lifestyleCount,
        double lifestyleValue}) {
    this._groupId = groupId;
    this._customerId = customerId;
    this._lifestyleType = lifestyleType;
    this._lifestyleCount = lifestyleCount;
    this._lifestyleValue = lifestyleValue;
  }

  String get groupId => _groupId;
  set groupId(String groupId) => _groupId = groupId;
  String get customerId => _customerId;
  set customerId(String customerId) => _customerId = customerId;
  String get lifestyleType => _lifestyleType;
  set lifestyleType(String lifestyleType) => _lifestyleType = lifestyleType;
  double get lifestyleCount => _lifestyleCount;
  set lifestyleCount(double lifestyleCount) => _lifestyleCount = lifestyleCount;
  double get lifestyleValue => _lifestyleValue;
  set lifestyleValue(double lifestyleValue) => _lifestyleValue = lifestyleValue;

  LifestyleCount.fromJson(Map<String, dynamic> json) {
    _groupId = json['groupId'];
    _customerId = json['customerId'];
    _lifestyleType = json['lifestyleType'];
    _lifestyleCount = json['lifestyleCount'];
    _lifestyleValue = json['lifestyleValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this._groupId;
    data['customerId'] = this._customerId;
    data['lifestyleType'] = this._lifestyleType;
    data['lifestyleCount'] = this._lifestyleCount;
    data['lifestyleValue'] = this._lifestyleValue;
    return data;
  }
}

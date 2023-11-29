class DataExceptionResponse {
  String _groupId;
  String _customerId;
  String _incompleteData;
  String _invalidData;

  DataExceptionResponse(
      {String groupId,
        String customerId,
        String incompleteData,
        String invalidData}) {
    this._groupId = groupId;
    this._customerId = customerId;
    this._incompleteData = incompleteData;
    this._invalidData = invalidData;
  }

  String get groupId => _groupId;
  set groupId(String groupId) => _groupId = groupId;
  String get customerId => _customerId;
  set customerId(String customerId) => _customerId = customerId;
  String get incompleteData => _incompleteData;
  set incompleteData(String incompleteData) => _incompleteData = incompleteData;
  String get invalidData => _invalidData;
  set invalidData(String invalidData) => _invalidData = invalidData;

  DataExceptionResponse.fromJson(Map<String, dynamic> json) {
    _groupId = json['groupId'];
    _customerId = json['customerId'];
    _incompleteData = json['incompleteData'];
    _invalidData = json['invalidData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this._groupId;
    data['customerId'] = this._customerId;
    data['incompleteData'] = this._incompleteData;
    data['invalidData'] = this._invalidData;
    return data;
  }
}
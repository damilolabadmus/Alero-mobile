class CompletenessAndValidityData {
  String _workflowStatus;
  int _incompleteDataCount;
  int _invalidDataCount;

  CompletenessAndValidityData (
      {String workflowStatus,
        int incompleteDataCount,
        int invalidDataCount,}) {
    this._workflowStatus = workflowStatus;
    this._incompleteDataCount = incompleteDataCount;
    this._invalidDataCount = invalidDataCount;
  }

  String get workflowStatus => _workflowStatus;
  set workflowStatus(String workflowStatus) => _workflowStatus = workflowStatus;
  int get incompleteDataCount => _incompleteDataCount;
  set incompleteDataCount(int incompleteDataCount) => _incompleteDataCount = incompleteDataCount;
  int get invalidDataCount => _invalidDataCount;
  set invalidDataCount(int invalidDataCount) => _invalidDataCount = invalidDataCount;

  CompletenessAndValidityData.fromJson(Map<String, dynamic> json) {
    _workflowStatus = json['workflowStatus'];
    _incompleteDataCount = json['incompleteDataCount'];
    _invalidDataCount = json['invalidDataCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workflowStatus'] = this._workflowStatus;
    data['incompleteDataCount'] = this._incompleteDataCount;
    data['invalidDataCount'] = this._invalidDataCount;
    return data;
  }

  factory CompletenessAndValidityData.fromMap(Map<String, dynamic> map) {
    return CompletenessAndValidityData(
      workflowStatus: map['workflowStatus'] ?? '',
      incompleteDataCount: map['incompleteDataCount']?.toInt() ?? 0,
      invalidDataCount: map['invalidDataCount']?.toInt() ?? 0,
    );
  }
}
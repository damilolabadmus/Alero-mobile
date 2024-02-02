

class ComplaintCategory {
  String? _customerGroupId;
  String? _customerId;
  String? _accountNumber;
  int? _ytdComplaintCount;
  int? _mtdComplaintCount;
  String? _complaintCategory;
  String? _complaintDescription;
  String? _complaintCreatedDate;
  String? _complaintReslvedDate;
  String? _complaintStatus;
  int? _complaintCategoryCount;

  ComplaintCategory(
      {String? customerGroupId,
        String? customerId,
        String? accountNumber,
        int? ytdComplaintCount,
        int? mtdComplaintCount,
        String? complaintCategory,
        String? complaintDescription,
        String? complaintCreatedDate,
        String? complaintReslvedDate,
        String? complaintStatus,
        int? complaintCategoryCount}) {
    this._customerGroupId = customerGroupId;
    this._customerId = customerId;
    this._accountNumber = accountNumber;
    this._ytdComplaintCount = ytdComplaintCount;
    this._mtdComplaintCount = mtdComplaintCount;
    this._complaintCategory = complaintCategory;
    this._complaintDescription = complaintDescription;
    this._complaintCreatedDate = complaintCreatedDate;
    this._complaintReslvedDate = complaintReslvedDate;
    this._complaintStatus = complaintStatus;
    this._complaintCategoryCount = complaintCategoryCount;
  }

  String? get customerGroupId => _customerGroupId;
  set customerGroupId(String? customerGroupId) =>
      _customerGroupId = customerGroupId;
  String? get customerId => _customerId;
  set customerId(String? customerId) => _customerId = customerId;
  String? get accountNumber => _accountNumber;
  set accountNumber(String? accountNumber) => _accountNumber = accountNumber;
  int? get ytdComplaintCount => _ytdComplaintCount;
  set ytdComplaintCount(int? ytdComplaintCount) =>
      _ytdComplaintCount = ytdComplaintCount;
  int? get mtdComplaintCount => _mtdComplaintCount;
  set mtdComplaintCount(int? mtdComplaintCount) =>
      _mtdComplaintCount = mtdComplaintCount;
  String? get complaintCategory => _complaintCategory;
  set complaintCategory(String? complaintCategory) =>
      _complaintCategory = complaintCategory;
  String? get complaintDescription => _complaintDescription;
  set complaintDescription(String? complaintDescription) =>
      _complaintDescription = complaintDescription;
  String? get complaintCreatedDate => _complaintCreatedDate;
  set complaintCreatedDate(String? complaintCreatedDate) =>
      _complaintCreatedDate = complaintCreatedDate;
  String? get complaintReslvedDate => _complaintReslvedDate;
  set complaintReslvedDate(String? complaintReslvedDate) =>
      _complaintReslvedDate = complaintReslvedDate;
  String? get complaintStatus => _complaintStatus;
  set complaintStatus(String? complaintStatus) =>
      _complaintStatus = complaintStatus;
  int? get complaintCategoryCount => _complaintCategoryCount;
  set complaintCategoryCount(int? complaintCategoryCount) =>
      _complaintCategoryCount = complaintCategoryCount;

  ComplaintCategory.fromJson(Map<String, dynamic> json) {
    _customerGroupId = json['customerGroupId'];
    _customerId = json['customerId'];
    _accountNumber = json['accountNumber'];
    _ytdComplaintCount = json['ytdComplaintCount'];
    _mtdComplaintCount = json['mtdComplaintCount'];
    _complaintCategory = json['complaintCategory'];
    _complaintDescription = json['complaintDescription'];
    _complaintCreatedDate = json['complaintCreatedDate'];
    _complaintReslvedDate = json['complaintReslvedDate'];
    _complaintStatus = json['complaintStatus'];
    _complaintCategoryCount = json['complaintCategoryCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerGroupId'] = this._customerGroupId;
    data['customerId'] = this._customerId;
    data['accountNumber'] = this._accountNumber;
    data['ytdComplaintCount'] = this._ytdComplaintCount;
    data['mtdComplaintCount'] = this._mtdComplaintCount;
    data['complaintCategory'] = this._complaintCategory;
    data['complaintDescription'] = this._complaintDescription;
    data['complaintCreatedDate'] = this._complaintCreatedDate;
    data['complaintReslvedDate'] = this._complaintReslvedDate;
    data['complaintStatus'] = this._complaintStatus;
    data['complaintCategoryCount'] = this._complaintCategoryCount;
    return data;
  }
}

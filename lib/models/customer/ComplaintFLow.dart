

class ComplaintFlow {
  String? customerGroupId;
  String? customerId;
  String? periodCode;
  String? periodName;
  int? complaintCount;

  ComplaintFlow(
      {this.customerGroupId,
        this.customerId,
        this.periodCode,
        this.periodName,
        this.complaintCount});

  ComplaintFlow.fromJson(Map<String, dynamic> json) {
    customerGroupId = json['customerGroupId'];
    customerId = json['customerId'];
    periodCode = json['periodCode'];
    periodName = json['periodName'];
    complaintCount = json['complaintCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerGroupId'] = this.customerGroupId;
    data['customerId'] = this.customerId;
    data['periodCode'] = this.periodCode;
    data['periodName'] = this.periodName;
    data['complaintCount'] = this.complaintCount;
    return data;
  }
}

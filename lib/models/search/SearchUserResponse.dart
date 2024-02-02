

class SearchUserResponse {
  String? groupId;
  String? customerId;
  String? customerName;
  double? depositBalance;
  double? loanBalance;
  double? ytdRevenue;
  double? prevMonthRevenue;
  int? customerRelationshipAge;
  String? businessSegment;
  String? subBusinessSegment;
  String? rmCode;
  String? rmName;
  String? activeStat;


  SearchUserResponse(
      this.groupId,
      this.customerId,
      this.customerName,
      this.depositBalance,
      this.loanBalance,
      this.ytdRevenue,
      this.prevMonthRevenue,
      this.customerRelationshipAge,
      this.businessSegment,
      this.subBusinessSegment,
      this.rmCode,
      this.rmName,
      this.activeStat);


  SearchUserResponse.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    depositBalance = json['depositBalance'];
    loanBalance = json['loanBalance'];
    ytdRevenue = json['ytdRevenue'];
    prevMonthRevenue = json['prevMonthRevenue'];
    customerRelationshipAge = json['customerRelationshipAge'];
    businessSegment = json['businessSegment'];
    subBusinessSegment = json['subBusinessSegment'];
    rmCode = json['rmCode'];
    rmName = json['rmName'];
    activeStat = json['activeStat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['depositBalance'] = this.depositBalance;
    data['loanBalance'] = this.loanBalance;
    data['ytdRevenue'] = this.ytdRevenue;
    data['prevMonthRevenue'] = this.prevMonthRevenue;
    data['customerRelationshipAge'] = this.customerRelationshipAge;
    data['businessSegment'] = this.businessSegment;
    data['subBusinessSegment'] = this.subBusinessSegment;
    data['rmCode'] = this.rmCode;
    data['rmName'] = this.rmName;
    data['activeStat'] = this.activeStat;
    return data;
  }
}
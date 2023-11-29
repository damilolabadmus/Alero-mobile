class Rights {

  String roleRightId;
  String rightId;
  String rightName;
  String roleId;
  String makerId;
  String makerDateTime;

  Rights.fromJsonMap(Map<String, dynamic> map):
        roleRightId = map["roleRightId"],
        rightId = map["rightId"],
        rightName = map["rightName"],
        roleId = map["roleId"],
        makerId = map["makerId"],
        makerDateTime = map["makerDateTime"];

  Rights.fromJson(Map<String, dynamic> json) {
    roleRightId = json['roleRightId'];
    rightId = json['rightId'];
    rightName = json['rightName'];
    roleId = json['roleId'];
    makerId = json['makerId'];
    makerDateTime = json['makerDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleRightId'] = roleRightId;
    data['rightId'] = rightId;
    data['rightName'] = rightName;
    data['roleId'] = roleId;
    data['makerId'] = makerId;
    data['makerDateTime'] = makerDateTime;
    return data;
  }
}

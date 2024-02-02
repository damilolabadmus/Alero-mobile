

import 'rights.dart';

class UserRoles {
  String? userRoleId;
  String? userId;
  String? appUser;
  String? roleId;
  String? roleName;
  String? role;
  String? roleFilter;
  List<Rights> rights = [];
  String? activeStat;
  String? makerId;
  String? makerDatetime;
  String? modifierId;
  String? modifierDatetime;
  String? expiryDate;
  bool? updateRelated;

  UserRoles.fromJson(Map<String, dynamic> json) {
    userRoleId = json['userRoleId'];
    userId = json['userId'];
    appUser = json['appUser'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    role = json['role'];
    roleFilter = json['roleFilter'];
    if (json['rights'] != null) {
      rights = <Rights>[];
      json['rights'].forEach((v) {
        rights.add(new Rights.fromJson(v));
      });
    }
    activeStat = json['activeStat'];
    makerId = json['makerId'];
    makerDatetime = json['makerDatetime'];
    modifierId = json['modifierId'];
    modifierDatetime = json['modifierDatetime'];
    expiryDate = json['expiryDate'];
    updateRelated = json['updateRelated'];
  }

  UserRoles.fromJsonMap(Map<String, dynamic> map)
      : userRoleId = map["userRoleId"],
        userId = map["userId"],
        appUser = map["appUser"],
        roleId = map["roleId"],
        roleName = map["roleName"],
        role = map["role"],
        roleFilter = map["roleFilter"],
        rights = List<Rights>.from(
            map["rights"].map((it) => Rights.fromJsonMap(it))),
        activeStat = map["activeStat"],
        makerId = map["makerId"],
        makerDatetime = map["makerDatetime"],
        modifierId = map["modifierId"],
        modifierDatetime = map["modifierDatetime"],
        expiryDate = map["expiryDate"],
        updateRelated = map["updateRelated"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userRoleId'] = userRoleId;
    data['userId'] = userId;
    data['appUser'] = appUser;
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    data['role'] = role;
    data['roleFilter'] = roleFilter;
    data['rights'] =
    rights != null ? this.rights.map((v) => v.toJson()).toList() : null;
    data['activeStat'] = activeStat;
    data['makerId'] = makerId;
    data['makerDatetime'] = makerDatetime;
    data['modifierId'] = modifierId;
    data['modifierDatetime'] = modifierDatetime;
    data['expiryDate'] = expiryDate;
    data['updateRelated'] = updateRelated;
    return data;
  }
}

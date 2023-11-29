import 'rights.dart';
import 'user_roles.dart';

class GetStaffInformation {
  String id;
  String username;
  String staffId;
  String fullName;
  String firstName;
  String lastName;
  String password;
  String makerId;
  String maker;
  String makerDatetime;
  String modifierId;
  String modifier;
  String modifierDatetime;
  String lastLogin;
  String recordStat;
  List<UserRoles> userRoles = [];
  List<Object> userAttributes = [];
  List<Rights> rights = [];

  GetStaffInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    staffId = json['staffId'];
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    makerId = json['makerId'];
    maker = json['maker'];
    makerDatetime = json['makerDatetime'];
    modifierId = json['modifierId'];
    modifier = json['modifier'];
    modifierDatetime = json['modifierDatetime'];
    lastLogin = json['lastLogin'];
    recordStat = json['recordStat'];
    if (json['userRoles'] != null) {
      // ignore: deprecated_member_use
      userRoles = new List<UserRoles>();
      json['userRoles'].forEach((v) {
        userRoles.add(new UserRoles.fromJson(v));
      });
    }
    if (json['userAttributes'] != null) {
      // ignore: deprecated_member_use
      userAttributes = new List<Null>();
      json['userAttributes'].forEach((v) {
        userAttributes.add(new Object());
      });
    }
    if (json['rights'] != null) {
      // ignore: deprecated_member_use
      rights = new List<Rights>();
      json['rights'].forEach((v) {
        rights.add(new Rights.fromJson(v));
      });
    }
  }

  GetStaffInformation.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"],
        staffId = map["staffId"],
        fullName = map["fullName"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        password = map["password"],
        makerId = map["makerId"],
        maker = map["maker"],
        makerDatetime = map["makerDatetime"],
        modifierId = map["modifierId"],
        modifier = map["modifier"],
        modifierDatetime = map["modifierDatetime"],
        lastLogin = map["lastLogin"],
        recordStat = map["recordStat"],
        userRoles = List<UserRoles>.from(
            map["userRoles"].map((it) => UserRoles.fromJsonMap(it))),
        userAttributes = map["userAttributes"],
        rights = List<Rights>.from(
            map["rights"].map((it) => Rights.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['staffId'] = staffId;
    data['fullName'] = fullName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['password'] = password;
    data['makerId'] = makerId;
    data['maker'] = maker;
    data['makerDatetime'] = makerDatetime;
    data['modifierId'] = modifierId;
    data['modifier'] = modifier;
    data['modifierDatetime'] = modifierDatetime;
    data['lastLogin'] = lastLogin;
    data['recordStat'] = recordStat;
    data['userRoles'] = userRoles != null
        ? this.userRoles.map((v) => v.toJson()).toList()
        : null;
    data['userAttributes'] = userAttributes;
    data['rights'] =
    rights != null ? this.rights.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

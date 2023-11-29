class LoginResponse {
  String token;
  int slideTimeout;

  LoginResponse({this.token, this.slideTimeout});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    slideTimeout = json['slideTimeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['slideTimeout'] = this.slideTimeout;
    return data;
  }
}

class LoginResponseForPm {
  String token2;
  int slideTimeout;

  LoginResponseForPm({this.token2, this.slideTimeout});

  LoginResponseForPm.fromJson(Map<String, dynamic> json) {
    token2 = json['token2'];
    slideTimeout = json['slideTimeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token2'] = this.token2;
    data['slideTimeout'] = this.slideTimeout;
    return data;
  }
}

import 'dart:convert';

TurnaroundTimeCompletedResponse turnaroundTimeCompletedResponseFromJson(String str) => TurnaroundTimeCompletedResponse.fromJson(json.decode(str));

String turnaroundTimeCompletedResponseToJson(TurnaroundTimeCompletedResponse data) => json.encode(data.toJson());

class TurnaroundTimeCompletedResponse {
  TurnaroundTimeCompletedResponse({
    this.responseCode,
    this.responseDescription,
    this.result,
  });

  String responseCode;
  String responseDescription;
  List<TurnAroundTimeResponse> result;

  factory TurnaroundTimeCompletedResponse.fromJson(Map<String, dynamic> json) => TurnaroundTimeCompletedResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    result: List<TurnAroundTimeResponse>.from(json["result"].map((x) => TurnAroundTimeResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class TurnAroundTimeResponse {
  int _count;
  String _turnAroundTime;


  TurnAroundTimeResponse({
    int count,
    String turnAroundTime})
  {
    this._count = count;
    this._turnAroundTime = turnAroundTime;
  }

  int get count => _count;
  set count(int count) => _count = count;
  String get turnAroundTime => _turnAroundTime;
  set turnAroundTime(String turnAroundTime) => _turnAroundTime = turnAroundTime;

  TurnAroundTimeResponse.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _turnAroundTime = json['turnAroundTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['turnAroundTime'] = this._turnAroundTime;
    return data;
  }

  factory TurnAroundTimeResponse.fromMap(Map<String, dynamic> map) {
    return TurnAroundTimeResponse(
      count: map['count']?.toInt() ?? 0,
      turnAroundTime: map['turnAroundTime'] ?? '',
    );
  }
}

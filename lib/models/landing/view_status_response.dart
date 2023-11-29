/// canView : false

class ViewStatusResponse {
  bool _canView;

  bool get canView => _canView;

  ViewStatusResponse({
    bool canView}){
    _canView = canView;
  }

  ViewStatusResponse.fromJson(dynamic json) {
    _canView = json["canView"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["canView"] = _canView;
    return map;
  }
}

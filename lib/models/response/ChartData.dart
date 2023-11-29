class ChartData {
  String _month;
  double _sales;

  ChartData({String month, double sales}) {
    this._month = month;
    this._sales = sales;
  }

  String get month => _month;
  set month(String month) => _month = month;
  double get sales => _sales;
  set sales(double sales) => _sales = sales;

  ChartData.fromJson(Map<String, dynamic> json) {
    _month = json['month'];
    _sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this._month;
    data['sales'] = this._sales;
    return data;
  }
}
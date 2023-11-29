class TouchPointData {
  String _channel;
  double _averageSpend;
  double _volumeSpend;
  int _transactionChannelCount;

  TouchPointData(
      {String channel,
        double averageSpend,
        double volumeSpend,
        int transactionChannelCount}) {
    this._channel = channel;
    this._averageSpend = averageSpend;
    this._volumeSpend = volumeSpend;
    this._transactionChannelCount = transactionChannelCount;
  }

  String get channel => _channel;
  set channel(String channel) => _channel = channel;
  double get averageSpend => _averageSpend;
  set averageSpend(double averageSpend) => _averageSpend = averageSpend;
  double get volumeSpend => _volumeSpend;
  set volumeSpend(double volumeSpend) => _volumeSpend = volumeSpend;
  int get transactionChannelCount => _transactionChannelCount;
  set transactionChannelCount(int transactionChannelCount) =>
      _transactionChannelCount = transactionChannelCount;

  TouchPointData.fromJson(Map<String, dynamic> json) {
    _channel = json['channel'];
    _averageSpend = json['averageSpend'];
    _volumeSpend = json['volumeSpend'];
    _transactionChannelCount = json['transactionChannelCount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel'] = this._channel;
    data['averageSpend'] = this._averageSpend;
    data['volumeSpend'] = this._volumeSpend;
    data['transactionChannelCount'] = this._transactionChannelCount;
    return data;
  }

  factory TouchPointData.fromMap(Map<String, dynamic> map) {
    return TouchPointData(
      channel: map['channel'] ?? '',
      averageSpend: map['averageSpend']?.toDouble() ?? 0.0,
      volumeSpend: map['volumeSpend']?.toDouble() ?? 0.0,
      transactionChannelCount: map['transactionChannelCount']?.toInt() ?? 0,
    );
  }
}

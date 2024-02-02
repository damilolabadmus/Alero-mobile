

class CardList {
  String? _cardPan;
  String? _cardType;

  CardList({String? cardPan, String? cardType}) {
    this._cardPan = cardPan;
    this._cardType = cardType;
  }

  String? get cardPan => _cardPan;
  set cardPan(String? cardPan) => _cardPan = cardPan;
  String? get cardType => _cardType;
  set cardType(String? cardType) => _cardType = cardType;

  CardList.fromJson(Map<String, dynamic> json) {
    _cardPan = json['cardPan'];
    _cardType = json['cardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardPan'] = this._cardPan;
    data['cardType'] = this._cardType;
    return data;
  }
}


class CprDataSingleton {
  static final CprDataSingleton _singleton = CprDataSingleton._internal();

  factory CprDataSingleton() {
    return _singleton;
  }

  CprDataSingleton._internal();

  dynamic cprData;
}

class AprDataSingleton {
  static final AprDataSingleton _singleton = AprDataSingleton._internal();

  factory AprDataSingleton() {
    return _singleton;
  }

  AprDataSingleton._internal();

  dynamic aprData;
}


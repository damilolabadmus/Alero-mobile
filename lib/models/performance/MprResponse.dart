import 'package:flutter/cupertino.dart';

class MprResponse {
  String categoryName;
  List<MprResponse> rowObjectSubList;
  Map<String, double> rowMonthsItem;
  dynamic currentBudgetValue;
  dynamic ytdBudgetValue;
  dynamic currentActualValue;
  dynamic ytdActualValue;
  dynamic currentVariance;
  dynamic currentAchieved;
  dynamic ytdVariance;
  dynamic ytdAchieved;
  dynamic fyBudget;
  dynamic runRate;
  dynamic mprResponseCurrentBudgetValue;

  MprResponse({
    this.categoryName,
    this.rowObjectSubList,
    this.rowMonthsItem,
    this.currentBudgetValue,
    this.ytdBudgetValue,
    this.currentActualValue,
    this.ytdActualValue,
    this.currentVariance,
    this.currentAchieved,
    this.ytdVariance,
    this.ytdAchieved,
    this.fyBudget,
    this.runRate,
    this.mprResponseCurrentBudgetValue,
  });

  List<MprResponse> subList = [];


  factory MprResponse.fromJson(Map<String, dynamic> json) {

    return MprResponse(
      categoryName: json["CategoryName"] == null ? '' : json["CategoryName"],
      rowObjectSubList: List<MprResponse>.from(json["rowObjectSubList"].map((x) => MprResponse.fromJson(x))) == null ? ''
          : List<MprResponse>.from(json["rowObjectSubList"].map((x) => MprResponse.fromJson(x))),
      rowMonthsItem: Map.from(json["RowMonthsItem"])?.map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      currentBudgetValue: json["CurrentBudgetValue"] == null ? 0 : json["CurrentBudgetValue"],
      ytdBudgetValue: json["YtdBudgetValue"] == null ? 0 : json["YtdBudgetValue"],
      currentActualValue: json["CurrentActualValue"] == null ? 0 : json["CurrentActualValue"],
      ytdActualValue: json["YtdActualValue"] == null ? 0 : json["YtdActualValue"],
      currentVariance: json["CurrentVariance"] == null ? 0 : json["CurrentVariance"],
      currentAchieved: json["CurrentAchieved"] == null ? 0 : json["CurrentAchieved"],
      ytdVariance: json["YtdVariance"] == null ? 0 : json["YtdVariance"],
      ytdAchieved: json["YtdAchieved"] == null ? 0 : json["YtdAchieved"],
      fyBudget: json["FyBudget"] == null ? 0 : json["FyBudget"],
      runRate: json["RunRate"] == null ? 0 : json["RunRate"],
      mprResponseCurrentBudgetValue: json["currentBudgetValue"] == null ? 0 : json["currentBudgetValue"],
    );
  }


  Map<String, dynamic> toJson() => {
    "CategoryName": categoryName,
    "rowObjectSubList": List<dynamic>.from(rowObjectSubList.map((x) => x.toJson())),
    "RowMonthsItem": Map.from(rowMonthsItem).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "CurrentBudgetValue": currentBudgetValue,
    "YtdBudgetValue": ytdBudgetValue,
    "CurrentActualValue": currentActualValue,
    "YtdActualValue": ytdActualValue,
    "CurrentVariance": currentVariance,
    "CurrentAchieved": currentAchieved,
    "YtdVariance": ytdVariance,
    "YtdAchieved": ytdAchieved,
    "FyBudget": fyBudget,
    "RunRate": runRate,
    "currentBudgetValue": mprResponseCurrentBudgetValue,
  };
}


/*
class MprResponse {
  final String categoryName;
  // final List<MprSubCategory> rowObjectSubList;
  final List<Map<String, dynamic>> rowObjectSubList;
  final Map<String, double> rowMonthsItem;
  final double currentBudgetValue;
  final double ytdBudgetValue;
  final double currentActualValue;
  final double ytdActualValue;
  final double currentVariance;
  final double currentAchieved;
  final double ytdVariance;
  final double ytdAchieved;
  final double fyBudget;
  final double runRate;

  MprResponse({
    @required this.categoryName,
    this.rowObjectSubList,
    this.rowMonthsItem,
    @required this.currentBudgetValue,
    @required this.ytdBudgetValue,
    @required this.currentActualValue,
    @required this.ytdActualValue,
    @required this.currentVariance,
    @required this.currentAchieved,
    @required this.ytdVariance,
    @required this.ytdAchieved,
    @required this.fyBudget,
    @required this.runRate,
  });

  factory MprResponse.fromJson(Map<String, dynamic> json) {
    return MprResponse(
      categoryName: json['CategoryName'] ?? '',
      rowObjectSubList: (json['rowObjectSubList'] as List<dynamic>)
          ?.map((subCategory) => MprSubCategory.fromJson(subCategory))
          ?.toList(),

      rowObjectSubList: List<Map<String, dynamic>>.from(
        json['rowObjectSubList']
        .map((subItem) => subItem['rowObjectSubClass'])
        .expand((i) => i)
        .toList()),
      rowMonthsItem: (json['RowMonthsItem'] as Map<String, dynamic>)?.map(
            (key, value) => MapEntry(key, value.toDouble()),
      ),
      currentBudgetValue: (json['CurrentBudgetValue'] as num)?.toDouble() ?? 0.0,
      ytdBudgetValue: (json['YtdBudgetValue'] as num)?.toDouble() ?? 0.0,
      currentActualValue:
      (json['CurrentActualValue'] as num)?.toDouble() ?? 0.0,
      ytdActualValue: (json['YtdActualValue'] as num)?.toDouble() ?? 0.0,
      currentVariance: (json['CurrentVariance'] as num)?.toDouble() ?? 0.0,
      currentAchieved: (json['CurrentAchieved'] as num)?.toDouble() ?? 0.0,
      ytdVariance: (json['YtdVariance'] as num)?.toDouble() ?? 0.0,
      ytdAchieved: (json['YtdAchieved'] as num)?.toDouble() ?? 0.0,
      fyBudget: (json['FyBudget'] as num)?.toDouble() ?? 0.0,
      runRate: (json['RunRate'] as num)?.toDouble() ?? 0,
    );
  }
}

class MprSubCategory {
  final String categoryName;
  final List<Map<String, dynamic>> rowObjectSubList;
  final Map<String, double> rowMonthsItem;
  final double currentBudgetValue;
  final double ytdBudgetValue;
  final double currentActualValue;
  final double ytdActualValue;
  final double currentVariance;
  final double currentAchieved;
  final double ytdVariance;
  final double ytdAchieved;
  final double fyBudget;
  final double runRate;

  MprSubCategory({
    @required this.categoryName,
    this.rowObjectSubList,
    this.rowMonthsItem,
    @required this.currentBudgetValue,
    @required this.ytdBudgetValue,
    @required this.currentActualValue,
    @required this.ytdActualValue,
    @required this.currentVariance,
    @required this.currentAchieved,
    @required this.ytdVariance,
    @required this.ytdAchieved,
    @required this.fyBudget,
    @required this.runRate,
  });

  factory MprSubCategory.fromJson(Map<String, dynamic> json) {
    return MprSubCategory(
      categoryName: json['CategoryName'] ?? '',
      rowObjectSubList: List<Map<String, dynamic>>.from(
          json['rowObjectSubList']
              .map((subItem) => subItem['rowObjectSubClass'])
              .expand((i) => i)
              .toList()),
      rowMonthsItem: (json['RowMonthsItem'] as Map<String, dynamic>)
          ?.map((key, value) => MapEntry(key, value.toDouble())),
      currentBudgetValue: (json['CurrentBudgetValue'] as num)?.toDouble() ?? 0,
      ytdBudgetValue: (json['YtdBudgetValue'] as num)?.toDouble() ?? 0,
      currentActualValue:
      (json['CurrentActualValue'] as num)?.toDouble() ?? 0,
      ytdActualValue: (json['YtdActualValue'] as num)?.toDouble() ?? 0,
      currentVariance: (json['CurrentVariance'] as num)?.toDouble() ?? 0,
      currentAchieved: (json['CurrentAchieved'] as num)?.toDouble() ?? 0,
      ytdVariance: (json['YtdVariance'] as num)?.toDouble() ?? 0,
      ytdAchieved: (json['YtdAchieved'] as num)?.toDouble() ?? 0,
      fyBudget: (json['FyBudget'] as num)?.toDouble() ?? 0,
      runRate: (json['RunRate'] as num)?.toDouble() ?? 0,
    );
  }
}
*/

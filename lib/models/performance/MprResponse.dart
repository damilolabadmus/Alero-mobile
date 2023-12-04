import 'package:flutter/cupertino.dart';

/// The bottom nav of mpr
///


class MprResponse {
  String categoryName;
  List<SubCategory> rowObjectSubList;
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
  // dynamic mprResponseCurrentBudgetValue;

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
    // this.mprResponseCurrentBudgetValue,
  });

  factory MprResponse.fromJson(Map<String, dynamic> json) {
      return MprResponse(
        categoryName: json["CategoryName"] == null ? '' : json["CategoryName"],
        rowObjectSubList: json["rowObjectSubList"] != null
            ? List<SubCategory>.from(json["rowObjectSubList"].map((x) => SubCategory.fromJson(x)))
            : [],
        rowMonthsItem: Map.from(json["RowMonthsItem"])?.map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        currentBudgetValue: json["CurrentBudgetValue"] == null ? 0.0 : json["CurrentBudgetValue"],
        ytdBudgetValue: json["YtdBudgetValue"] == null ? 0.0 : json["YtdBudgetValue"],
        currentActualValue: json["CurrentActualValue"] == null ? 0.0 : json["CurrentActualValue"],
        ytdActualValue: json["YtdActualValue"] == null ? 0.0 : json["YtdActualValue"],
        currentVariance: json["CurrentVariance"] == null ? 0.0 : json["CurrentVariance"],
        currentAchieved: json["CurrentAchieved"] == null ? 0.0 : json["CurrentAchieved"],
        ytdVariance: json["YtdVariance"] == null ? 0.0 : json["YtdVariance"],
        ytdAchieved: json["YtdAchieved"] == null ? 0.0 : json["YtdAchieved"],
        fyBudget: json["FyBudget"] == null ? 0.0 : json["FyBudget"],
        runRate: json["RunRate"] == null ? 0.0 : json["RunRate"],
        // mprResponseCurrentBudgetValue: json["currentBudgetValue"] == null ? 0 : json["currentBudgetValue"],
      );
    }


  Map<String, dynamic> toJson() => {
    "CategoryName": categoryName,
    "rowObjectSubList": rowObjectSubList != null
        ? List<dynamic>.from(rowObjectSubList.map((x) => x.toJson()))
        : [],
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
    // "currentBudgetValue": mprResponseCurrentBudgetValue,
  };
}
class SubCategory {
  String categoryName;
  List<SubClass> rowObjectSubClass;
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

  SubCategory({
    this.categoryName,
    this.rowObjectSubClass,
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
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      categoryName: json["CategoryName"] == null ? '' : json["CategoryName"],
      rowObjectSubClass: json["rowObjectSubClass"] != null
          ? List<SubClass>.from(json["rowObjectSubClass"].map((x) => SubClass.fromJson(x)))
          : [],
      rowMonthsItem: Map.from(json["RowMonthsItem"])?.map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      currentBudgetValue: json["CurrentBudgetValue"] == null ? 0.0 : json["CurrentBudgetValue"],
      ytdBudgetValue: json["YtdBudgetValue"] == null ? 0.0 : json["YtdBudgetValue"],
      currentActualValue: json["CurrentActualValue"] == null ? 0.0 : json["CurrentActualValue"],
      ytdActualValue: json["YtdActualValue"] == null ? 0.0 : json["YtdActualValue"],
      currentVariance: json["CurrentVariance"] == null ? 0.0 : json["CurrentVariance"],
      currentAchieved: json["CurrentAchieved"] == null ? 0.0 : json["CurrentAchieved"],
      ytdVariance: json["YtdVariance"] == null ? 0.0 : json["YtdVariance"],
      ytdAchieved: json["YtdAchieved"] == null ? 0.0 : json["YtdAchieved"],
      fyBudget: json["FyBudget"] == null ? 0.0 : json["FyBudget"],
      runRate: json["RunRate"] == null ? 0.0 : json["RunRate"],
    );
  }


  Map<String, dynamic> toJson() => {
    "CategoryName": categoryName,
    "rowObjectSubClass": rowObjectSubClass != null
        ? List<dynamic>.from(rowObjectSubClass.map((x) => x.toJson()))
        : [],
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
  };
}
class SubClass {
  String categoryName;
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

  SubClass({
    this.categoryName,
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
  });

  factory SubClass.fromJson(Map<String, dynamic> json) {
    return SubClass(
      categoryName: json["CategoryName"] == null ? '' : json["CategoryName"],
      rowMonthsItem: Map.from(json["RowMonthsItem"])?.map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      currentBudgetValue: json["CurrentBudgetValue"] == null ? 0.0 : json["CurrentBudgetValue"],
      ytdBudgetValue: json["YtdBudgetValue"] == null ? 0.0 : json["YtdBudgetValue"],
      currentActualValue: json["CurrentActualValue"] == null ? 0 : json["CurrentActualValue"],
      ytdActualValue: json["YtdActualValue"] == null ? 0.0 : json["YtdActualValue"],
      currentVariance: json["CurrentVariance"] == null ? 0.0 : json["CurrentVariance"],
      currentAchieved: json["CurrentAchieved"] == null ? 0.0 : json["CurrentAchieved"],
      ytdVariance: json["YtdVariance"] == null ? 0.0 : json["YtdVariance"],
      ytdAchieved: json["YtdAchieved"] == null ? 0.0 : json["YtdAchieved"],
      fyBudget: json["FyBudget"] == null ? 0.0 : json["FyBudget"],
      runRate: json["RunRate"] == null ? 0.0 : json["RunRate"],
    );
  }


  Map<String, dynamic> toJson() => {
    "CategoryName": categoryName,
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
  };
}



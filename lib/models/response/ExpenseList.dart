

import 'dart:convert';

List<ExpenseList> expenseListFromJson(String str) => List<ExpenseList>.from(json.decode(str).map((x) => ExpenseList.fromJson(x)));

String expenseListToJson(List<ExpenseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseList {
  String? period;
  String? periodCode;

  ExpenseList({
    this.period,
    this.periodCode,
  });

  factory ExpenseList.fromJson(Map<String, dynamic> json) => ExpenseList(
    period: json["period"],
    periodCode: json["periodCode"],
  );

  Map<String, dynamic> toJson() => {
    "period": period,
    "periodCode": periodCode,
  };
}

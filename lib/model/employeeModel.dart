// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  String? name;
  String? position;
  String? status;
  String? fromDate;
  String? toDate;

  EmployeeModel({
    this.name,
    this.position,
    this.status,
    this.fromDate,
    this.toDate,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        name: json["name"],
        position: json["position"],
        status: json["status"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "position": position,
        "status": status,
        "fromDate": fromDate,
        "toDate" : toDate
      };
}

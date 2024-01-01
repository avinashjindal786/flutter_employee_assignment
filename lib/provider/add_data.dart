import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/employeeModel.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeProvider() {
    getEmployeeData();
  }
  List<EmployeeModel> _list = [];
  List<EmployeeModel> get list => _list;

  getEmployeeData() async {
    log("calling.....");
    SharedPreferences instance = await SharedPreferences.getInstance();
    final value = instance.getStringList("list");
    if (value != null) {
      _list = value.map((e) => EmployeeModel.fromJson(jsonDecode(e))).toList();
    }
    log(_list.length.toString());
    notifyListeners();
  }

  deleteFunc(int index) async {
    _list.removeAt(index);
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setStringList("list", _list.map((e) => jsonEncode(e)).toList());
    notifyListeners();
  }

  savedataInLocalDatabase(EmployeeModel model) async {
    _list.add(model);
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (_list.isNotEmpty) {
      await instance.setStringList("list", _list.map((e) => jsonEncode(e)).toList());
    } else {
      await instance.setStringList("list", [jsonEncode(model)]);
    }
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/employeeModel.dart';
import 'package:flutter_assignment/provider/add_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/customTextButton.dart';
import 'AddEmployee.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  // List<EmployeeModel>? list;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Employee List", style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20))),
          backgroundColor: Colors.blue,
        ),
        body: provider.list.isEmpty
            ? (Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: Image.asset('assets/images/boarding.jpg'))],
              ))
            : Column(
                children: [
                  Container(padding: const EdgeInsets.fromLTRB(20, 13, 0, 0), width: double.infinity, height: 50, color: Colors.grey.withOpacity(.1), child: const Text("Current employees", style: TextStyle(color: Colors.blue, fontSize: 16))),
                  Column(
                    children: List.generate(provider.list.length, (index) {
                      log(provider.list[index].toDate ?? "mjb,jbk,");
                      return provider.list[index].status == "Yes"
                          ? Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      provider.deleteFunc(index);
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListItem(name: provider.list[index].name ?? "", position: provider.list[index].position ?? "", date: "${provider.list[index].fromDate ?? ""} - ${provider.list[index].toDate ?? ""}"),
                            )
                          : const SizedBox();
                    }),
                  ),
                  Container(padding: const EdgeInsets.fromLTRB(20, 13, 0, 0), width: double.infinity, height: 50, color: Colors.grey.withOpacity(.1), child: const Text("Previous employees", style: TextStyle(color: Colors.blue, fontSize: 16))),
                  Column(
                    children: List.generate(provider.list.length, (index) {
                      return provider.list[index].status == "No"
                          ? Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      provider.deleteFunc(index);
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListItem(name: provider.list[index].name ?? "", position: provider.list[index].position ?? "", date: "${provider.list[index].fromDate ?? ""} - ${provider.list[index].toDate ?? ""}"),
                            )
                          : const SizedBox();
                    }),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEmployee()),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      )),
    );
  }
}

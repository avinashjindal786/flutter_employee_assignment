import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/employeeModel.dart';
import 'package:flutter_assignment/provider/add_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/customBottomSheet.dart';
import '../widgets/customDialog.dart';
import 'employeeList.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController textcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController currrentEmployeeFiled = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final provider = Provider.of<EmployeeProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Add Employee Details ", style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20))),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Employee name",
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                        prefixIcon: const Icon(
                          Icons.person_4_outlined,
                          color: Colors.blue,
                        ),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      showCursor: false,
                      readOnly: true,
                      controller: textcontroller,
                      decoration: InputDecoration(
                          hintText: "Select role",
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                          prefixIcon: const Icon(
                            Icons.work_outline,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          // suffixIcon: IconButton(
                          //   icon: const Icon(Icons.arrow_drop_down),
                          //   color: Colors.blue,
                          //   onPressed: () {
                          //     showMyModalBottomSheet(context,textcontroller);
                          //   },
                          // ),
                          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0),
                          )),
                      onTap: () {
                        showMyModalBottomSheet(context, textcontroller);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      showCursor: false,
                      readOnly: true,
                      controller: currrentEmployeeFiled,
                      decoration: InputDecoration(
                          hintText: "Current Employee",
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                          prefixIcon: const Icon(
                            Icons.work_outline,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          // suffixIcon: IconButton(
                          //   icon: const Icon(Icons.arrow_drop_down),
                          //   color: Colors.blue,
                          //   onPressed: () {
                          //     showMyModalBottomSheet(context,textcontroller);
                          //   },
                          // ),
                          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0),
                          )),
                      onTap: () {
                        showMyModalBottomSheetForCurrentEmployee(context, currrentEmployeeFiled);
                      },
                    ),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 15, 0),
                    child: Container(
                      width: 150,
                      height: 60,
                      child: TextField(
                        controller: textEditingController1,
                        showCursor: false,
                        readOnly: true,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "No date",
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                          prefixIcon: const Icon(
                            Icons.event,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                        ),
                        onTap: () async {
                          await showMyDialog(context, "Today", "Next Monday", true).then((value) {
                            if (value != null) {
                              textEditingController1.text = value.toString();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_right_alt_rounded, color: Colors.blue, size: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17.0, 0, 0, 0),
                    child: Container(
                      width: 150,
                      height: 60,
                      child: TextField(
                        controller: textEditingController2,
                        showCursor: false,
                        readOnly: true,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "No date",
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                          prefixIcon: const Icon(
                            Icons.event,
                            color: Colors.blue,
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0), borderRadius: BorderRadius.circular(5)),
                        ),
                        onTap: () async {
                          await showMyDialog(context, "No date", "Today", false).then((value) {
                            if (value != null) {
                              print(value);
                              textEditingController2.text = value.toString();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ]),
                iskeyboard
                    ? (Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.withOpacity(.3),
                          width: 1.0,
                        ))),
                        height: 190,
                      ))
                    : (Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey.withOpacity(.3),
                            width: 1.0,
                          ))),
                        ),
                      )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(.2),
                            ),
                            child: TextButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: TextButton(
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (nameController.text != "" && currrentEmployeeFiled.text != "") {
                                  EmployeeModel model = EmployeeModel(name: nameController.text, position: textcontroller.text, status: currrentEmployeeFiled.text, fromDate: textEditingController1.text, toDate: textEditingController2.text);
                                  provider.savedataInLocalDatabase(model);
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EmployeeListScreen()), (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Please Add All Value..."),
                                  ));
                                }
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

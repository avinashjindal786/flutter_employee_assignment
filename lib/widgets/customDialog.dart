import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../screens/employeeList.dart';
import 'functions.dart';

showMyDialog(
  context,
  String text1,
  String text2,
  bool enable,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      DateTime _focusday = DateTime.now();
      DateTime _selectedday = DateTime.now();
      int _day = 0;
      int? _month;
      int? _year;
      bool flag = false;
      bool afterOneWeek = false;
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
              insetPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: text1 == "Today"
                            ? Container(
                                width: 160,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (_selectedday.month == DateTime.now().month && _selectedday.day == DateTime.now().day) ? Colors.blue : Colors.blue.withOpacity(.1),
                                ),
                                child: TextButton(
                                  child: Text(
                                    text1,
                                    style: (_selectedday.month == DateTime.now().month && _selectedday.day == DateTime.now().day) ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      afterOneWeek = false;
                                      _selectedday = DateTime.now();
                                      _day = _selectedday.day;
                                      _month = _selectedday.month;
                                      _year = _selectedday.year;
                                      _focusday = _selectedday;
                                      flag = true;
                                    });
                                  },
                                ))
                            : Container(
                                width: 160,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue.withOpacity(.1),
                                ),
                                child: TextButton(
                                  child: Text(
                                    text1,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {},
                                )),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                            width: 160,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:afterOneWeek ? Colors.blue: Colors.blue.withOpacity(.1),
                            ),
                            child: TextButton(
                              child: Text(
                                'After one week',
                                style: afterOneWeek ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                setState(() {
                                  afterOneWeek = true;
                                  _selectedday = DateTime(_selectedday.year, _selectedday.month, _selectedday.day + 7);
                                  _day = _selectedday.day;
                                  _month = _selectedday.month;
                                  _year = _selectedday.year;
                                  _focusday = _selectedday;
                                  flag = true;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 450,
                    child: TableCalendar(
                      availableGestures: AvailableGestures.all,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusday,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekHeight: 40,
                      headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false, titleTextStyle: TextStyle(fontSize: 20), leftChevronIcon: Icon(Icons.arrow_left_rounded, color: Colors.grey, size: 50), rightChevronIcon: Icon(Icons.arrow_right_rounded, color: Colors.grey, size: 50)),
                      calendarBuilders: CalendarBuilders(
                        outsideBuilder: (context, day, focusedDay) => Container(),
                      ),
                      calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(.3), border: Border.all(color: Colors.blue)),
                          selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          )),
                      onDaySelected: (selectedDay, focusedDay) => {
                        if (!isSameDay(_selectedday, selectedDay))
                          {
                            setState(() {
                              afterOneWeek = false;
                              _selectedday = selectedDay;
                              _day = selectedDay.day;
                              _month = selectedDay.month;
                              _year = selectedDay.year;
                              _focusday = selectedDay;
                              flag = true;
                            })
                          }
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedday, day);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.event_outlined, color: Colors.blue),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: 150,
                            child: Text(
                              (flag) ? ("$_day ${monthToString(_month)} $_year") : "No date",
                              style: TextStyle(color: Colors.black),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                              width: 80,
                              height: 50,
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
                                  Navigator.pop(context, null);
                                },
                              )),
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: TextButton(
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                 if(_day != 0){
                                   Navigator.pop(context, "$_day ${monthToString(_month)} $_year");
                                 }else{
                                  Navigator.pop(context, null);
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
              ));
        },
      );
    },
  );
}

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/main.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/exchangePage.dart';
import 'package:endproject/page/loginPage.dart';
import 'package:endproject/page/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:endproject/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> {
  List<Users> user = [];
  List<ClassTeacher> classes = [];
  List<ClassTime> time = [];
  List<Requests> requests = [];
  List<Confirms> confirms = [];

  void removeRequest(BuildContext context, var i, List teacherrequests) async {
    final request = requests[i];

    await ClassSheetsApi.deleteByID(request.id!);

    setState(() {
      teacherrequests.remove(i);
      getRequests();
    });

    Navigator.of(context).pop();
  }

  void addConfirm(BuildContext context, var i, List teacherrequests) async {
    final confirm = Confirms(
        teachername1: requests[teacherrequests[i]].teachername1,
        teacherlastname1: requests[teacherrequests[i]].teacherlastname1,
        day1: requests[teacherrequests[i]].day1,
        date1: requests[teacherrequests[i]].date1,
        month1: requests[teacherrequests[i]].month1,
        year1: requests[teacherrequests[i]].year1,
        period1: requests[teacherrequests[i]].period1,
        periodname1: requests[teacherrequests[i]].periodname1,
        teachername2: requests[teacherrequests[i]].teachername2,
        teacherlastname2: requests[teacherrequests[i]].teacherlastname2,
        day2: requests[teacherrequests[i]].day2,
        date2: requests[teacherrequests[i]].date2,
        month2: requests[teacherrequests[i]].month2,
        year2: requests[teacherrequests[i]].year2,
        period2: requests[teacherrequests[i]].period2,
        periodname2: requests[teacherrequests[i]].periodname2);
    final id = await ClassSheetsApi.getRowCountConfirm() + 1;
    final newConfirm = confirm.copy(id: id);

    await ClassSheetsApi.insertConfirm([newConfirm.toJson()]);

    final request = requests[i];

    await ClassSheetsApi.deleteByID(request.id!);

    setState(() {
      teacherrequests.remove(i);
      getRequests();
    });

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    getUsers();
    getClass();
    getClassTime();
    getRequests();
    getConfirms();

    if (now.weekday == DateTime.monday) {
      setState(() {
        select[0] = false;
        select[1] = true;
        select[2] = true;
        select[3] = true;
        select[4] = true;
      });
    } else if (now.weekday == DateTime.tuesday) {
      setState(() {
        select[0] = true;
        select[1] = false;
        select[2] = true;
        select[3] = true;
        select[4] = true;
      });
    } else if (now.weekday == DateTime.wednesday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = false;
        select[3] = true;
        select[4] = true;
      });
    } else if (now.weekday == DateTime.thursday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = true;
        select[3] = false;
        select[4] = true;
      });
    } else if (now.weekday == DateTime.friday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = true;
        select[3] = true;
        select[4] = false;
      });
    }
  }

  Future getUsers() async {
    final user = await ClassSheetsApi.getUser();

    setState(() {
      this.user = user;
    });
    //print(classess.length);
  }

  Future getClass() async {
    final classes = await ClassSheetsApi.getAlls();

    setState(() {
      this.classes = classes;
    });
  }

  Future getClassTime() async {
    final time = await ClassSheetsApi.getTime();

    setState(() {
      this.time = time;
    });
  }

  Future getRequests() async {
    final requests = await ClassSheetsApi.getRequests();

    setState(() {
      this.requests = requests;
    });
  }

  Future getConfirms() async {
    final confirms = await ClassSheetsApi.getConfirms();

    setState(() {
      this.confirms = confirms;
    });
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  DateTime timeBackPressed = DateTime.now();

  //bool Tap12 = false;

  var list = ["Mon".tr, "Tue".tr, "Wed".tr, "Thu".tr, "Fri".tr];
  var select = [false, true, true, true, true];
  var colorbutton = "0xFF187FD7";
  var now = DateTime.now();
  var week = DateTime.now().weekday;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  bool read = false;

  @override
  Widget build(BuildContext context) {
    var number;

    int daysInlastMonth;
    if (month != 1) {
      daysInlastMonth =
          getDaysInMonth(DateTime.now().year, DateTime.now().month - 1);
    } else {
      daysInlastMonth = getDaysInMonth(DateTime.now().year - 1, 12);
    }

    try {
      number = ModalRoute.of(context)!.settings.arguments as int;
      globals.userNumber = number;
    } catch (e) {
      number = globals.userNumber;
    }

    List confirmday1list = [];
    for (var i = confirms.length - 1; i >= 0; i--) {
      if (confirms[i].day1 == 'Mon') {
        confirmday1list.add(1);
      }
      if (confirms[i].day1 == 'Tue') {
        confirmday1list.add(2);
      }
      if (confirms[i].day1 == 'Wed') {
        confirmday1list.add(3);
      }
      if (confirms[i].day1 == 'Thu') {
        confirmday1list.add(4);
      }
      if (confirms[i].day1 == 'Fri') {
        confirmday1list.add(5);
      }
    }
    List confirmday2list = [];
    for (var i = confirms.length - 1; i >= 0; i--) {
      if (confirms[i].day2 == 'Mon') {
        confirmday2list.add(1);
      }
      if (confirms[i].day2 == 'Tue') {
        confirmday2list.add(2);
      }
      if (confirms[i].day2 == 'Wed') {
        confirmday2list.add(3);
      }
      if (confirms[i].day2 == 'Thu') {
        confirmday2list.add(4);
      }
      if (confirms[i].day2 == 'Fri') {
        confirmday2list.add(5);
      }
    }

    List alldayinconfirm = [];
    for (var i = confirms.length - 1; i >= 0; i--) {
      var sunday = int.parse(confirms[i].date1);
      if (confirms[i].day1 == 'Mon') {
        if (sunday - 1 <= 0) {
          alldayinconfirm.add(daysInlastMonth);
        } else {
          alldayinconfirm.add(sunday - 1);
        }
      }
      if (confirms[i].day1 == 'Tue') {
        if (sunday - 2 <= 0) {
          alldayinconfirm.add(daysInlastMonth - 1);
        } else {
          alldayinconfirm.add(sunday - 2);
        }
      }
      if (confirms[i].day1 == 'Wed') {
        if (sunday - 3 <= 0) {
          alldayinconfirm.add(daysInlastMonth - 2);
        } else {
          alldayinconfirm.add(sunday - 3);
        }
      }
      if (confirms[i].day1 == 'Thu') {
        if (sunday - 4 <= 0) {
          alldayinconfirm.add(daysInlastMonth - 3);
        } else {
          alldayinconfirm.add(sunday - 4);
        }
      }
      if (confirms[i].day1 == 'Fri') {
        if (sunday - 5 <= 0) {
          alldayinconfirm.add(daysInlastMonth - 4);
        } else {
          alldayinconfirm.add(sunday - 5);
        }
      }
    }

    List name1 = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirms[j].teachername1 == classes[i].name) {
          name1.add(i);
        }
      }
    }
    List name2 = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirms[j].teachername2 == classes[i].name) {
          name2.add(i);
        }
      }
    }

    List mondayclass = [];
    try {
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday1 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday1 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday1);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday2 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday2 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday2);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday3 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday3 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday3);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday4 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday4 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday4);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday5 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday5 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday5);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday6 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday6 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday6);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].monday7 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].monday7 != "" &&
              read == false) {
            mondayclass.add(classes[globals.userNumber].monday7);
            read = true;
          }
        }
      }
      read = false;
    } catch (e) {}

    List thesdayclass = [];
    try {
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday1 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday1 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday1);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday2 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday2 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday2);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday3 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday3 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday3);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday4 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday4 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday4);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday5 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday5 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday5);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday6 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday6 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday6);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thesday7 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thesday7 != "" &&
              read == false) {
            thesdayclass.add(classes[globals.userNumber].thesday7);
            read = true;
          }
        }
      }
      read = false;
    } catch (e) {}

    List wednesdayclass = [];
    try {
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday1 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday1 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday1);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday2 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday2 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday2);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday3 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday3 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday3);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday4 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday4 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday4);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday5 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday5 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday5);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday6 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday6 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday6);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].wednesday7 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].wednesday7 != "" &&
              read == false) {
            wednesdayclass.add(classes[globals.userNumber].wednesday7);
            read = true;
          }
        }
      }
      read = false;
    } catch (e) {}

    List thursdayclass = [];
    try {
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday1 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday1 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday1);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday2 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday2 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday2);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday3 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday3 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday3);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday4 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday4 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday4);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday5 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday5 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday5);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday6 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday6 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday6);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].thursday7 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].thursday7 != "" &&
              read == false) {
            thursdayclass.add(classes[globals.userNumber].thursday7);
            read = true;
          }
        }
      }
      read = false;
    } catch (e) {}

    List fridayclass = [];
    try {
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday1 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday1 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday1);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday2 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday2 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday2);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday3 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday3 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday3);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday4 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday4 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday4);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday5 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday5 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday5);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday6 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday6 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday6);
            read = true;
          }
        }
      }
      read = false;
      for (var j = confirms.length - 1; j >= 0; j--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7' &&
            classes[globals.userNumber].name == classes[name1[j]].name &&
            read == false) {
          if (confirms[j].periodname2 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname2);
          }
          read = true;
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7' &&
            classes[globals.userNumber].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[globals.userNumber].friday7 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[globals.userNumber].friday7 != "" &&
              read == false) {
            fridayclass.add(classes[globals.userNumber].friday7);
            read = true;
          }
        }
      }
    } catch (e) {}

    List teacherrequests = [];
    try {
      for (var i = 0; i < requests.length; i++) {
        if (requests[i].teachername2 == classes[globals.userNumber].name) {
          teacherrequests.add(i);
        }
      }
    } catch (e) {}
    print(teacherrequests);

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();

          try {
            SystemNavigator.pop();
            return false;
          } catch (e) {
            return exit(0);
          }
        }
      },
      child: Scaffold(
        key: _globalKey,
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: classes.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8, right: 5, left: 5),
                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              _globalKey.currentState!.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              openDialog(teacherrequests);
                            },
                            icon: //Icon(Icons.notifications, color: Colors.black87,),
                                addBadgeCount(
                              widget: Icon(Icons.notifications, color: Theme.of(context).colorScheme.shadow,),
                              badgeCount: teacherrequests.length,
                              badgeColor: Colors.red,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Welcome'.tr,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${classes[number].name}\t${classes[number].lastname}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Table(
                              border:
                                  TableBorder.all(color: Colors.transparent),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text(
                                        'Status'.tr,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text(
                                        'Subject'.tr,
                                      ),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text(
                                        '\t\t\t\t${classes[number].rank}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.scrim),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text(
                                        '\t\t\t\t${classes[number].subject}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.scrim),
                                      ),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select[0] = false;
                                          select[1] = true;
                                          select[2] = true;
                                          select[3] = true;
                                          select[4] = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: select[0]
                                            ? null
                                            : BoxDecoration(
                                                color: Color(
                                                    int.parse(colorbutton)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              list[0],
                                              style: TextStyle(
                                                fontWeight: select[0]
                                                    ? FontWeight.normal
                                                    : FontWeight.bold,
                                                color: select[0]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 4.0,
                                              height: 4.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: select[0]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select[0] = true;
                                          select[1] = false;
                                          select[2] = true;
                                          select[3] = true;
                                          select[4] = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: select[1]
                                            ? null
                                            : BoxDecoration(
                                                color: Color(
                                                    int.parse(colorbutton)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              list[1],
                                              style: TextStyle(
                                                fontWeight: select[1]
                                                    ? FontWeight.normal
                                                    : FontWeight.bold,
                                                color: select[1]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 4.0,
                                              height: 4.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: select[1]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select[0] = true;
                                          select[1] = true;
                                          select[2] = false;
                                          select[3] = true;
                                          select[4] = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: select[2]
                                            ? null
                                            : BoxDecoration(
                                                color: Color(
                                                    int.parse(colorbutton)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              list[2],
                                              style: TextStyle(
                                                fontWeight: select[2]
                                                    ? FontWeight.normal
                                                    : FontWeight.bold,
                                                color: select[2]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 4.0,
                                              height: 4.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: select[2]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select[0] = true;
                                          select[1] = true;
                                          select[2] = true;
                                          select[3] = false;
                                          select[4] = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: select[3]
                                            ? null
                                            : BoxDecoration(
                                                color: Color(
                                                    int.parse(colorbutton)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              list[3],
                                              style: TextStyle(
                                                fontWeight: select[3]
                                                    ? FontWeight.normal
                                                    : FontWeight.bold,
                                                color: select[3]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 4.0,
                                              height: 4.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: select[3]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select[0] = true;
                                          select[1] = true;
                                          select[2] = true;
                                          select[3] = true;
                                          select[4] = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: select[4]
                                            ? null
                                            : BoxDecoration(
                                                color: Color(
                                                    int.parse(colorbutton)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0),
                                                ),
                                              ),
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              list[4],
                                              style: TextStyle(
                                                fontWeight: select[4]
                                                    ? FontWeight.normal
                                                    : FontWeight.bold,
                                                color: select[4]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 4.0,
                                              height: 4.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: select[4]
                                                    ? Theme.of(context).colorScheme.tertiary
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            if (select[0] == false && time.length != 0 && mondayclass.length >=7)
                              for (var x = 0; x < 7; x++)
                                cardWidget('${mondayclass[x]}', x + 1,
                                    '${time[x + 1].time}', select),
                            if (select[1] == false && time.length != 0 && thesdayclass.length >=7)
                              for (var x = 0; x < 7; x++)
                                cardWidget('${thesdayclass[x]}', x + 1,
                                    '${time[x + 1].time}', select),
                            if (select[2] == false && time.length != 0 && wednesdayclass.length >=7)
                              for (var x = 0; x < 7; x++)
                                cardWidget('${wednesdayclass[x]}', x + 1,
                                    '${time[x + 1].time}', select),
                            if (select[3] == false && time.length != 0 && thursdayclass.length >=7)
                              for (var x = 0; x < 7; x++)
                                cardWidget('${thursdayclass[x]}', x + 1,
                                    '${time[x + 1].time}', select),
                            if (select[4] == false && time.length != 0 && fridayclass.length >=7)
                              for (var x = 0; x < 7; x++)
                                cardWidget('${fridayclass[x]}', x + 1,
                                    '${time[x + 1].time}', select),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        drawer: Drawer(
          width: 275,
          elevation: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                    color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 120),
              child: Column(
                children: [
                  DrawerItem(
                    title: 'Home'.tr,
                    icon: Icons.home_outlined,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  if (globals.isLoggedIn == true)
                    DrawerItem(
                      title: 'User'.tr,
                      icon: Icons.person_outline,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage()));
                      },
                    ),
                  SizedBox(
                    height: 4,
                  ),
                  DrawerItem(
                    title: 'Setting'.tr,
                    icon: Icons.settings_outlined,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingPage()));
                    },
                  ),
                  //Spacer(),
                  Divider(
                    height: 45,
                    color: Colors.blueGrey,
                  ),
                  //Spacer(),
                  DrawerItem(
                    title: 'Logout'.tr,
                    icon: Icons.logout_outlined,
                    onTap: () {
                      globals.isLoggedIn = false;
                      globals.userNumber = null;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  /*SizedBox(
                    height: 60,
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWidget(classroom, classnum, time, day) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 100.0,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              //color: Color(0xff2F50F3),
              color: Theme.of(context).colorScheme.secondaryContainer,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  //offset: Offset(8, 8),
                  color: Color(0xFFA7A9AF),
                ),
              ],
              //border: Border(),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  padding: EdgeInsets.only(
                    left: 16.0,
                    top: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 21.0,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${time}',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            /*VerticalDivider(
                              color: Colors.black,
                            ),*/
                            Text(
                              "\t|\t",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Period".tr + " " + '${classnum}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "   " + '${classroom}',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: 60,
                  margin: EdgeInsets.only(right: 18),
                  decoration: BoxDecoration(
                    //color: Color(0xFF187FD7),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExchangePage(),
                            settings: RouteSettings(
                                arguments: [classnum, classroom, day])),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.rotate_right,
                          color: Theme.of(context).colorScheme.scrim,
                        ),
                        Text(
                          'Exchange'.tr,
                          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.scrim),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 18,
        )
      ],
    );
  }

  Widget addBadgeCount(
      {required Widget widget,
      required int badgeCount,
      Color badgeColor = Colors.green,
      badges.BadgeShape badgeShape = badges.BadgeShape.circle}) {
    return badges.Badge(
      showBadge: badgeCount != 0,
      badgeContent: Text(
        badgeCount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      badgeStyle: badges.BadgeStyle(badgeColor: badgeColor, shape: badgeShape),
      child: widget,
    );
  }

  Future openDialog(List teacherrequests) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(child: Text("Notification".tr)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 350,
                width: 400,
                child: teacherrequests.length == 0
                    ? Center(
                        child: Text(
                          'No Notification now.'.tr,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var i = 0; i < teacherrequests.length; i++)
                              requestsTeacher(
                                  tap12,
                                  requests[i].teachername1,
                                  requests[i].teacherlastname1,
                                  requests[i].period1,
                                  requests[i].period2,
                                  requests[i].day1,
                                  requests[i].day2,
                                  requests[i].date1,
                                  requests[i].date2,
                                  requests[i].month1,
                                  requests[i].month2,
                                  requests[i].year1,
                                  requests[i].year2,
                                  requests[i].periodname1,
                                  requests[i].periodname2,
                                  i,
                                  teacherrequests),
                          ],
                        ),
                      ),
              );
            }),
            actions: [
              TextButton(
                child: Text('CLOSE',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ));
  bool tap12 = false;
  Widget requestsTeacher(
      tap12,
      name,
      lastname,
      period1,
      period2,
      day1,
      day2,
      date1,
      date2,
      month1,
      month2,
      year1,
      year2,
      periodname1,
      periodname2,
      i,
      teacherrequests) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (tap12 == false) {
                    tap12 = true;
                  } else {
                    tap12 = false;
                  }
                });
              },
              child: Container(
                alignment: AlignmentDirectional.topStart,
                height: tap12 ? 210 : 110,
                width: double.infinity,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                //padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${name}\t${lastname}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100,
                              child: AutoSizeText(
                                "want exchange ".tr +
                                    "Period".tr +
                                    "${period1}" +
                                    ' ' +
                                    "in ".tr +
                                    "${day1}".tr +
                                    ". with your ".tr +
                                    "Period".tr +
                                    "${period2}" +
                                    ' ' +
                                    "in ".tr +
                                    "${day2}".tr +
                                    ".",
                                minFontSize: 12,
                                maxFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: tap12 ? 5 : 3,
                                //textScaleFactor: 0.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () =>
                                  addConfirm(context, i, teacherrequests),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            InkWell(
                              //removeRequest(context, i, teacherrequests)
                              onTap: () =>
                                  removeRequest(context, i, teacherrequests)
                              /*setState(() {
                                    final request = requests[i];

                                    teacherrequests.remove(i);
                                    ClassSheetsApi.deleteByID(request.id!);
                                    getRequests();
                                  });*/
                              ,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    tap12
                        // ignore: dead_code
                        ? FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Period'.tr + '-' + '${period1}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context).colorScheme.tertiaryContainer),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\t\t\t\t${periodname1}',
                                        style: TextStyle(
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\t' +
                                            '${day1}'.tr +
                                            '.' +
                                            ' ' +
                                            '${date1}' +
                                            ' ' +
                                            '${month1}' +
                                            ' ' +
                                            '${year1}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context).colorScheme.tertiaryContainer),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(Icons.swap_horiz)),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Period'.tr + '-' + '${period2}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context).colorScheme.tertiaryContainer),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\t\t\t\t${periodname2}',
                                        style: TextStyle(
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\t' +
                                            '${day2}'.tr +
                                            '.' +
                                            ' ' +
                                            '${date2}' +
                                            ' ' +
                                            '${month2}' +
                                            ' ' +
                                            '${year2}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context).colorScheme.tertiaryContainer),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Row()
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 18.0, top: 18.0, left: 8, right: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 25,
            ),
            SizedBox(
              width: 31,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

getDaysInMonth(int year, int month) {
  if (month < 1 || month > 12) {
    throw ArgumentError(
        "Invalid month: $month. Month should be between 1 and 12.");
  }

  if (month == 2) {
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
      return 29; // Leap year
    } else {
      return 28; // Non-leap year
    }
  } else if (month == 4 || month == 6 || month == 9 || month == 11) {
    return 30;
  } else {
    return 31;
  }
}

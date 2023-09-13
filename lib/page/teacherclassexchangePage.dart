import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/BottomSheetSelectDate.dart';
import 'package:endproject/page/exchangePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherclassexchangePage extends StatefulWidget {
  @override
  _TeacherclassexchangePage createState() => _TeacherclassexchangePage();
}

class _TeacherclassexchangePage extends State<TeacherclassexchangePage> {
  List<ClassTeacher> classes = [];
  List<ClassTime> time = [];
  List<Confirms> confirms = [];

  var list = ["Mon".tr, "Tue".tr, "Wed".tr, "Thu".tr, "Fri".tr];
  var select = [false, true, true, true, true];
  var colorbutton = "0xFF187FD7";
  var now = DateTime.now();
  var week = DateTime.now().weekday;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  bool read = false;

  @override
  void initState() {
    super.initState();

    getClass();
    getClassTime();
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

  Future getConfirms() async {
    final confirms = await ClassSheetsApi.getConfirms();

    setState(() {
      this.confirms = confirms;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listdayname =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final days = listdayname[0];
    final name = listdayname[1];
    final classnum = listdayname[2];
    final classroom = listdayname[3];
    var id = 0;

    int daysInlastMonth;
    if (month != 1) {
      daysInlastMonth =
          getDaysInMonth(DateTime.now().year, DateTime.now().month - 1);
    } else {
      daysInlastMonth = getDaysInMonth(DateTime.now().year - 1, 12);
    }

    try {
      for (var i = 0; i < classes.length; i++) {
        if (classes[i].name == name) {
          id = i;
        }
      }
      //print('${classes[id].name}');
    } catch (e) {}

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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday1 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday1 != "" && read == false) {
            mondayclass.add(classes[id].monday1);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday2 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday2 != "" && read == false) {
            mondayclass.add(classes[id].monday2);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday3 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday3 != "" && read == false) {
            mondayclass.add(classes[id].monday3);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday4 == "" && read == false) {
            mondayclass.add("Free".tr);
          } else if (classes[id].monday4 != "" && read == false) {
            mondayclass.add(classes[id].monday4);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday5 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday5 != "" && read == false) {
            mondayclass.add(classes[id].monday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday6 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday6 != "" && read == false) {
            mondayclass.add(classes[id].monday6);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday5 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday5 != "" && read == false) {
            mondayclass.add(classes[id].monday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            mondayclass.add("Free".tr);
          } else {
            mondayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].monday7 == "" && read == false) {
            mondayclass.add("Free".tr);
            read = true;
          } else if (classes[id].monday7 != "" && read == false) {
            mondayclass.add(classes[id].monday7);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday1 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday1 != "" && read == false) {
            thesdayclass.add(classes[id].thesday1);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday2 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday2 != "" && read == false) {
            thesdayclass.add(classes[id].thesday2);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday3 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday3 != "" && read == false) {
            thesdayclass.add(classes[id].thesday3);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday4 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday4 != "" && read == false) {
            thesdayclass.add(classes[id].thesday4);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday5 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday5 != "" && read == false) {
            thesdayclass.add(classes[id].thesday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday6 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday6 != "" && read == false) {
            thesdayclass.add(classes[id].thesday6);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thesdayclass.add("Free".tr);
          } else {
            thesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thesday7 == "" && read == false) {
            thesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thesday7 != "" && read == false) {
            thesdayclass.add(classes[id].thesday7);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday1 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday1 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday1);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday2 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday2 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday2);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday3 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday3 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday3);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday4 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday4 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday4);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday5 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday5 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday6 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday6 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday6);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            wednesdayclass.add("Free".tr);
          } else {
            wednesdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].wednesday7 == "" && read == false) {
            wednesdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].wednesday7 != "" && read == false) {
            wednesdayclass.add(classes[id].wednesday7);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday1 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday1 != "" && read == false) {
            thursdayclass.add(classes[id].thursday1);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday2 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday2 != "" && read == false) {
            thursdayclass.add(classes[id].thursday2);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday3 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday3 != "" && read == false) {
            thursdayclass.add(classes[id].thursday3);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday4 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday4 != "" && read == false) {
            thursdayclass.add(classes[id].thursday4);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday5 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday5 != "" && read == false) {
            thursdayclass.add(classes[id].thursday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday6 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday6 != "" && read == false) {
            thursdayclass.add(classes[id].thursday6);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            thursdayclass.add("Free".tr);
          } else {
            thursdayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].thursday7 == "" && read == false) {
            thursdayclass.add("Free".tr);
            read = true;
          } else if (classes[id].thursday7 != "" && read == false) {
            thursdayclass.add(classes[id].thursday7);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday1 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday1 != "" && read == false) {
            fridayclass.add(classes[id].friday1);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday2 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday2 != "" && read == false) {
            fridayclass.add(classes[id].friday2);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday3 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday3 != "" && read == false) {
            fridayclass.add(classes[id].friday3);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday4 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday4 != "" && read == false) {
            fridayclass.add(classes[id].friday4);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday5 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday5 != "" && read == false) {
            fridayclass.add(classes[id].friday5);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday6 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday6 != "" && read == false) {
            fridayclass.add(classes[id].friday6);
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
            classes[id].name == classes[name1[j]].name &&
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
            classes[id].name == classes[name2[j]].name &&
            read == false) {
          if (confirms[j].periodname1 == "Free") {
            fridayclass.add("Free".tr);
          } else {
            fridayclass.add(confirms[j].periodname1);
          }
          read = true;
        } else {
          if (classes[id].friday7 == "" && read == false) {
            fridayclass.add("Free".tr);
            read = true;
          } else if (classes[id].friday7 != "" && read == false) {
            fridayclass.add(classes[id].friday7);
            read = true;
          }
        }
      }
      read = false;
    } catch (e) {}

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          'Replace'.tr,
          style: TextStyle(color: Theme.of(context).colorScheme.shadow),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.shadow,
          ),
          onPressed: () {
            Navigator.pop(context, ExchangePage());
          },
        ),
      ),
      body: classes.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            '${classes[id].name}\t\t${classes[id].lastname}',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Table(
                            border: TableBorder.all(color: Colors.transparent),
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
                                      '\t\t\t\t${classes[id].rank}',
                                      style: TextStyle(color: Theme.of(context).colorScheme.scrim),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      '\t\t\t\t${classes[id].subject}',
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
                                              color:
                                                  Color(int.parse(colorbutton)),
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
                                              color:
                                                  Color(int.parse(colorbutton)),
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
                                              color:
                                                  Color(int.parse(colorbutton)),
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
                                              color:
                                                  Color(int.parse(colorbutton)),
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
                                              color:
                                                  Color(int.parse(colorbutton)),
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
                          if (select[0] == false && time.length != 0)
                            for (var x = 0; x < 7; x++)
                              cardWidget(
                                  '${mondayclass[x]}',
                                  x + 1,
                                  '${time[x + 1].time}',
                                  select,
                                  days,
                                  classnum,
                                  id,
                                  classroom),
                          if (select[1] == false && time.length != 0)
                            for (var x = 0; x < 7; x++)
                              cardWidget(
                                  '${thesdayclass[x]}',
                                  x + 1,
                                  '${time[x + 1].time}',
                                  select,
                                  days,
                                  classnum,
                                  id,
                                  classroom),
                          if (select[2] == false && time.length != 0)
                            for (var x = 0; x < 7; x++)
                              cardWidget(
                                  '${wednesdayclass[x]}',
                                  x + 1,
                                  '${time[x + 1].time}',
                                  select,
                                  days,
                                  classnum,
                                  id,
                                  classroom),
                          if (select[3] == false && time.length != 0)
                            for (var x = 0; x < 7; x++)
                              cardWidget(
                                  '${thursdayclass[x]}',
                                  x + 1,
                                  '${time[x + 1].time}',
                                  select,
                                  days,
                                  classnum,
                                  id,
                                  classroom),
                          if (select[4] == false && time.length != 0)
                            for (var x = 0; x < 7; x++)
                              cardWidget(
                                  '${fridayclass[x]}',
                                  x + 1,
                                  '${time[x + 1].time}',
                                  select,
                                  days,
                                  classnum,
                                  id,
                                  classroom),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget cardWidget(
      classroom2, classnum, time, day, days, classnumber, id, classroom1) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 100.0,
            margin: EdgeInsets.all(8.0),
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
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
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
                              "  |  ",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Period".tr + ' ' + '${classnum}',
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
                        "   " + '${classroom2}',
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
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0))),
                          builder: (context) => MyBottomSheet(),
                          routeSettings: RouteSettings(arguments: [
                            days,
                            classnumber,
                            classes[id].name,
                            classes[id].lastname,
                            day,
                            classnum,
                            classroom1,
                            classroom2
                          ]));
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.scrim,
                        ),
                        Text(
                          'Select'.tr,
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

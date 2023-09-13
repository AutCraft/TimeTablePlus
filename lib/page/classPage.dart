import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

int j = 1;

class ClassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClassPage();
  }
}

class _ClassPage extends State<ClassPage> {
  List<ClassTeacher> classes = [];
  List<ClassNum> classess = [];
  List<ClassTime> time = [];
  List<Confirms> confirms = [];

  @override
  void initState() {
    getClass();
    getAllClass();
    getClassTime();
    getConfirms();
    super.initState();

    if (now.weekday == DateTime.monday) {
      setState(() {
        select[0] = false;
        select[1] = true;
        select[2] = true;
        select[3] = true;
        select[4] = true;
      });
      //select = [false, true, true, true, true];
    } else if (now.weekday == DateTime.tuesday) {
      setState(() {
        select[0] = true;
        select[1] = false;
        select[2] = true;
        select[3] = true;
        select[4] = true;
      });
      //select = [true, false, true, true, true];
    } else if (now.weekday == DateTime.wednesday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = false;
        select[3] = true;
        select[4] = true;
      });
      //select = [true, true, false, true, true];
    } else if (now.weekday == DateTime.thursday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = true;
        select[3] = false;
        select[4] = true;
      });
      //select = [true, true, true, false, true];
    } else if (now.weekday == DateTime.friday) {
      setState(() {
        select[0] = true;
        select[1] = true;
        select[2] = true;
        select[3] = true;
        select[4] = false;
      });
      //select = [true, true, true, true, false];
    }
  }

  Future getClass() async {
    final classes = await ClassSheetsApi.getAlls();

    setState(() {
      this.classes = classes;
    });
  }

  Future getAllClass() async {
    final classess = await ClassSheetsApi.getAll();

    setState(() {
      this.classess = classess;
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

  //int currentPageIndex = 0;
  var list = ["Mon".tr, "Tue".tr, "Wed".tr, "Thu".tr, "Fri".tr];
  var select = [false, true, true, true, true];
  var colorbutton = "0xFFF44336";
  bool read = false;

  var now = DateTime.now();
  var week = DateTime.now().weekday;
  var month = DateTime.now().month;
  var year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final nameclass = ModalRoute.of(context)!.settings.arguments as String;
    //int daysInMonth = getDaysInMonth(DateTime.now().year, DateTime.now().month);
    int daysInlastMonth;
    if (month != 1) {
      daysInlastMonth =
          getDaysInMonth(DateTime.now().year, DateTime.now().month - 1);
    } else {
      daysInlastMonth = getDaysInMonth(DateTime.now().year - 1, 12);
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
    print(confirmday1list);
    print(confirmday2list);

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
    print(alldayinconfirm);

    List mondaynum = [];
    //List monday = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday1list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          if (classes[i].monday1 != "") {
            if (classes[i].monday1 == nameclass && read == false) {
              mondaynum.add(i);
              read = true;
            } else if (classes[i].monday1[0] == nameclass[0] &&
                classes[i].monday1[2] == '0' &&
                read == false) {
              mondaynum.add(i);
              read = true;
            } else if (classes[i].monday1 == "All" && read == false) {
              mondaynum.add(i);
              read = true;
            }
          }
        }
      }
    }

    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday2 != "") {
              if (classes[i].monday2 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday2[0] == nameclass[0] &&
                  classes[i].monday2[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday2 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday3 != "") {
              if (classes[i].monday3 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday3[0] == nameclass[0] &&
                  classes[i].monday3[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday3 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday4 != "") {
              if (classes[i].monday4 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday4[0] == nameclass[0] &&
                  classes[i].monday4[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday4 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday5 != "") {
              if (classes[i].monday5 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday5[0] == nameclass[0] &&
                  classes[i].monday5[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday5 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday6 != "") {
              if (classes[i].monday6 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday6[0] == nameclass[0] &&
                  classes[i].monday6[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday6 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 1 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 1 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            mondaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].monday7 != "") {
              if (classes[i].monday7 == nameclass && read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday7[0] == nameclass[0] &&
                  classes[i].monday7[2] == '0' &&
                  read == false) {
                mondaynum.add(i);
                read = true;
              } else if (classes[i].monday7 == "All" && read == false) {
                mondaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    //print(mondaynum);
    List thesdaynum = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday1 != "") {
              if (classes[i].thesday1 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday1[0] == nameclass[0] &&
                  classes[i].thesday1[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday1 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday2 != "") {
              if (classes[i].thesday2 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday2[0] == nameclass[0] &&
                  classes[i].thesday2[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday2 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday3 != "") {
              if (classes[i].thesday3 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday3[0] == nameclass[0] &&
                  classes[i].thesday3[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday3 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday4 != "") {
              if (classes[i].thesday4 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday4[0] == nameclass[0] &&
                  classes[i].thesday4[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday4 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday5 != "") {
              if (classes[i].thesday5 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday5[0] == nameclass[0] &&
                  classes[i].thesday5[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday5 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday6 != "") {
              if (classes[i].thesday6 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday6[0] == nameclass[0] &&
                  classes[i].thesday6[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday6 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 2 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 2 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thesday7 != "") {
              if (classes[i].thesday7 == nameclass && read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday7[0] == nameclass[0] &&
                  classes[i].thesday7[2] == '0' &&
                  read == false) {
                thesdaynum.add(i);
                read = true;
              } else if (classes[i].thesday7 == "All" && read == false) {
                thesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;

    List wednesdaynum = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday1 != "") {
              if (classes[i].wednesday1 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday1[0] == nameclass[0] &&
                  classes[i].wednesday1[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday1 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday2 != "") {
              if (classes[i].wednesday2 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday2[0] == nameclass[0] &&
                  classes[i].wednesday2[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday2 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday3 != "") {
              if (classes[i].wednesday3 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday3[0] == nameclass[0] &&
                  classes[i].wednesday3[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday3 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday4 != "") {
              if (classes[i].wednesday4 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday4[0] == nameclass[0] &&
                  classes[i].wednesday4[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday4 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday5 != "") {
              if (classes[i].wednesday5 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday5[0] == nameclass[0] &&
                  classes[i].wednesday5[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday5 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday6 != "") {
              if (classes[i].wednesday6 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday6[0] == nameclass[0] &&
                  classes[i].wednesday6[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday6 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 3 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 3 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            wednesdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].wednesday7 != "") {
              if (classes[i].wednesday7 == nameclass && read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday7[0] == nameclass[0] &&
                  classes[i].wednesday7[2] == '0' &&
                  read == false) {
                wednesdaynum.add(i);
                read = true;
              } else if (classes[i].wednesday7 == "All" && read == false) {
                wednesdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;

    List thursdaynum = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday1 != "") {
              if (classes[i].thursday1 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday1[0] == nameclass[0] &&
                  classes[i].thursday1[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday1 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday2 != "") {
              if (classes[i].thursday2 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday2[0] == nameclass[0] &&
                  classes[i].thursday2[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday2 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday3 != "") {
              if (classes[i].thursday3 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday3[0] == nameclass[0] &&
                  classes[i].thursday3[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday3 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday4 != "") {
              if (classes[i].thursday4 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday4[0] == nameclass[0] &&
                  classes[i].thursday4[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday4 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday5 != "") {
              if (classes[i].thursday5 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday5[0] == nameclass[0] &&
                  classes[i].thursday5[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday5 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday6 != "") {
              if (classes[i].thursday6 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday6[0] == nameclass[0] &&
                  classes[i].thursday6[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday6 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 4 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 4 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            thursdaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].thursday7 != "") {
              if (classes[i].thursday7 == nameclass && read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday7[0] == nameclass[0] &&
                  classes[i].thursday7[2] == '0' &&
                  read == false) {
                thursdaynum.add(i);
                read = true;
              } else if (classes[i].thursday7 == "All" && read == false) {
                thursdaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;

    List fridaynum = [];
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '1') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '1') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday1 != "") {
              if (classes[i].friday1 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday1[0] == nameclass[0] &&
                  classes[i].friday1[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday1 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '2') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '2') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday2 != "") {
              if (classes[i].friday2 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday2[0] == nameclass[0] &&
                  classes[i].friday2[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday2 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '3') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '3') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday3 != "") {
              if (classes[i].friday3 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday3[0] == nameclass[0] &&
                  classes[i].friday3[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday3 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '4') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '4') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday4 != "") {
              if (classes[i].friday4 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday4[0] == nameclass[0] &&
                  classes[i].friday4[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday4 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '5') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '5') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday5 != "") {
              if (classes[i].friday5 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday5[0] == nameclass[0] &&
                  classes[i].friday5[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday5 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '6') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '6') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday6 != "") {
              if (classes[i].friday6 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday6[0] == nameclass[0] &&
                  classes[i].friday6[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday6 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    for (var j = confirms.length - 1; j >= 0; j--) {
      for (var i = classes.length - 1; i >= 0; i--) {
        if (confirmday1list[j] == 5 &&
            now.day >= alldayinconfirm[j] &&
            now.day <= int.parse(confirms[j].date1) &&
            month == int.parse(confirms[j].month1) &&
            year == int.parse(confirms[j].year1) &&
            confirms[j].period1 == '7') {
          if (classes[i].name == confirms[j].teachername2 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else if (confirmday2list[j] == 5 &&
            now.day >= int.parse(confirms[j].date1) &&
            now.day <= int.parse(confirms[j].date2) &&
            month == int.parse(confirms[j].month2) &&
            year == int.parse(confirms[j].year2) &&
            confirms[j].period2 == '7') {
          if (classes[i].name == confirms[j].teachername1 && read == false) {
            fridaynum.add(i);
            read = true;
          }
        } else {
          for (var i = classes.length - 1; i >= 0; i--) {
            if (classes[i].friday7 != "") {
              if (classes[i].friday7 == nameclass && read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday7[0] == nameclass[0] &&
                  classes[i].friday7[2] == '0' &&
                  read == false) {
                fridaynum.add(i);
                read = true;
              } else if (classes[i].friday7 == "All" && read == false) {
                fridaynum.add(i);
                read = true;
              }
            }
          }
        }
      }
    }
    read = false;
    j = 1;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.shadow,
          ),
          onPressed: () {
            Navigator.pop(context, HomePage());

            //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
            j = 1;
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: classes.length == 0 && time.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30))),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'TimeTable'.tr,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${nameclass}',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          /*TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                              "Mo",
                              style: TextStyle(
                                color: _selectDate ? Color(0xff8e7daf) : Colors.white,
                              ),
                            )
                        )
                      ],
                    ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              /*children: List.generate(5, (index) => 
                          dateWidget(
                            index: index,
                          ),
                        ),*/
                              children: <Widget>[
                                InkWell(
                                  //Monday
                                  onTap: () {
                                    setState(() {
                                      //select = [true,true,true,true,true];
                                      select[0] = false;
                                      select[1] = true;
                                      select[2] = true;
                                      select[3] = true;
                                      select[4] = true;
                                      j = 1;
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  //Thuday
                                  onTap: () {
                                    setState(() {
                                      //select = [true,true,true,true,true];
                                      select[0] = true;
                                      select[1] = false;
                                      select[2] = true;
                                      select[3] = true;
                                      select[4] = true;
                                      j = 1;
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  // Wesday
                                  onTap: () {
                                    setState(() {
                                      //select = [true,true,true,true,true];
                                      select[0] = true;
                                      select[1] = true;
                                      select[2] = false;
                                      select[3] = true;
                                      select[4] = true;
                                      j = 1;
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  //Thr
                                  onTap: () {
                                    setState(() {
                                      //select = [true,true,true,true,true];
                                      select[0] = true;
                                      select[1] = true;
                                      select[2] = true;
                                      select[3] = false;
                                      select[4] = true;
                                      j = 1;
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  // Friday
                                  onTap: () {
                                    setState(() {
                                      //select = [true,true,true,true,true];
                                      select[0] = true;
                                      select[1] = true;
                                      select[2] = true;
                                      select[3] = true;
                                      select[4] = false;
                                      j = 1;
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
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
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .scrim
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    if (select[0] == false && j == 1 && time.length != 0)
                      for (var x in mondaynum)
                        cardWidget('${classes[x].subject}',
                            '${classes[x].name}', j++, '${time[j - 1].time}'),
                    if (select[1] == false && j == 1 && time.length != 0)
                      for (var x in thesdaynum)
                        cardWidget('${classes[x].subject}',
                            '${classes[x].name}', j++, '${time[j - 1].time}'),
                    if (select[2] == false && j == 1 && time.length != 0)
                      for (var x in wednesdaynum)
                        cardWidget('${classes[x].subject}',
                            '${classes[x].name}', j++, '${time[j - 1].time}'),
                    if (select[3] == false && j == 1 && time.length != 0)
                      for (var x in thursdaynum)
                        cardWidget('${classes[x].subject}',
                            '${classes[x].name}', j++, '${time[j - 1].time}'),
                    if (select[4] == false && j == 1 && time.length != 0)
                      for (var x in fridaynum)
                        cardWidget('${classes[x].subject}',
                            '${classes[x].name}', j++, '${time[j - 1].time}'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget cardWidget(subject, nameteacher, classnum, time) {
    /*List times = [];
  if(classnum >= 1 && classnum <= 7) {
    times.add(time[classnum].time);
  } else {
    j=1;
    classnum=1;
  }*/
    print(classnum);
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 100.0,
            margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              //color: Color(0xfffcf9f5),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 12.0),
              color: Theme.of(context).colorScheme.primaryContainer,
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
                          ),
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
                          "Period".tr + " " + '${classnum}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "  " + '${subject}',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subject != nameteacher ? Text(
                        " - " + '${nameteacher}',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : Text(''),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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

/*class dateWidget extends StatefulWidget {
  final index;

  const dateWidget({super.key, required this.index});

  @override
  State<dateWidget> createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
  /*bool _selectMo = true;
  bool _selectTu = true;
  bool _selectWe = true;
  bool _selectTh = true;
  bool _selectFr = true;*/
  var list = ["Mo","Tu","We","Th","Fr"];
  var select = [false, false, false, false, false];

  void _handleButtonTap(int index) {
    setState(() {
      for (int i = 0; i < select.length; i++) {
        select[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          //select = [true,true,true,true,true];
          //select[widget.index] = !select[widget.index];
          _handleButtonTap(widget.index);
        });
      },
      child: Container(
        decoration: select[widget.index]
          ? null 
          : BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              list[widget.index],
              style: TextStyle(
                fontWeight: select[widget.index] ? FontWeight.normal : FontWeight.bold,
                color: select[widget.index] ? Color(0xff8e7daf) : Colors.white,
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
                color: select[widget.index] ? Color(0xff8e7daf) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
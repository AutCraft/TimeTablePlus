import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/userPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endproject/globals.dart' as globals;

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  List<ClassTeacher> classes = [];
  List<Requests> requests = [];
  List select = [false, false, false, false];

  @override
  void initState() {
    super.initState();

    getClass();
    getRequests();
  }

  Future getClass() async {
    final classes = await ClassSheetsApi.getAlls();

    setState(() {
      this.classes = classes;
    });
  }

  Future getRequests() async {
    final requests = await ClassSheetsApi.getRequests();

    setState(() {
      this.requests = requests;
    });
  }

  var now = DateTime.now();
  var week = DateTime.now().weekday;
  var month = DateTime.now().month;
  var year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    int daysInMonth = getDaysInMonth(DateTime.now().year, DateTime.now().month);
    int daysInlastMonth;
    if (month != 1) {
      daysInlastMonth =
          getDaysInMonth(DateTime.now().year, DateTime.now().month - 1);
    } else {
      daysInlastMonth = getDaysInMonth(DateTime.now().year - 1, 12);
    }
    print(daysInMonth);
    print(daysInlastMonth);
    final route = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final day = route[0];
    final classnum = route[1];
    final teachername2 = route[2];
    final teacherlastname2 = route[3];
    final day2 = route[4];
    final period2 = route[5];
    final classroom1 = route[6];
    final classroom2 = route[7];
    var daytext;
    var daytexttr;
    List datenum = [0, 0, 0, 0, 0];
    List datemonth = [0, 0, 0, 0, 0];
    List datemonthText = ['', '', '', '', ''];
    List dateyear = ['', '', '', '', ''];
    var daytext2;
    List datenum2 = [0, 0, 0, 0, 0];
    List datemonth2 = [0, 0, 0, 0, 0];
    List datemonthText2 = ['', '', '', '', ''];
    List dateyear2 = ['', '', '', '', ''];
    print(week);
    try {
      if (day[0] == false) {
        daytext = 'Mon';
        daytexttr = 'Mon'.tr;
        if (week == 1) {
          select[0] = false;
          datenum[0] = now.day;
        } else if (week == 2) {
          select[0] = false;
          datenum[0] = now.day - 1;
        } else if (week == 3) {
          select[0] = false;
          datenum[0] = now.day - 2;
        } else if (week == 4) {
          select[0] = false;
          datenum[0] = now.day - 3;
        } else if (week == 5) {
          select[0] = false;
          datenum[0] = now.day - 4;
        } else if (week == 6) {
          select[0] = false;
          datenum[0] = now.day - 5;
        } else if (week == 7) {
          //select[0] = false;
          datenum[0] = now.day + 1;
        }
      }
      if (day[1] == false) {
        daytext = 'Tue';
        daytexttr = 'Tue'.tr;
        if (week == 1) {
          //select[0] = false;
          datenum[0] = now.day + 1;
        } else if (week == 2) {
          select[0] = false;
          datenum[0] = now.day;
        } else if (week == 3) {
          select[0] = false;
          datenum[0] = now.day - 1;
        } else if (week == 4) {
          select[0] = false;
          datenum[0] = now.day - 2;
        } else if (week == 5) {
          select[0] = false;
          datenum[0] = now.day - 3;
        } else if (week == 6) {
          select[0] = false;
          datenum[0] = now.day - 4;
        } else if (week == 7) {
          //select[0] = false;
          datenum[0] = now.day + 2;
        }
      }
      if (day[2] == false) {
        daytext = 'Wed';
        daytexttr = 'Wed'.tr;
        if (week == 1) {
          //select[0] = false;
          datenum[0] = now.day + 2;
        } else if (week == 2) {
          //select[0] = false;
          datenum[0] = now.day + 1;
        } else if (week == 3) {
          select[0] = false;
          datenum[0] = now.day;
        } else if (week == 4) {
          select[0] = false;
          datenum[0] = now.day - 1;
        } else if (week == 5) {
          select[0] = false;
          datenum[0] = now.day - 2;
        } else if (week == 6) {
          select[0] = false;
          datenum[0] = now.day - 3;
        } else if (week == 7) {
          datenum[0] = now.day + 3;
        }
      }
      if (day[3] == false) {
        daytext = 'Thu';
        daytexttr = 'Thu'.tr;
        if (week == 1) {
          //select[0] = false;
          datenum[0] = now.day + 3;
        } else if (week == 2) {
          //select[0] = false;
          datenum[0] = now.day + 4;
        } else if (week == 3) {
          //select[0] = false;
          datenum[0] = now.day + 1;
        } else if (week == 4) {
          select[0] = false;
          datenum[0] = now.day;
        } else if (week == 5) {
          select[0] = false;
          datenum[0] = now.day - 1;
        } else if (week == 6) {
          select[0] = false;
          datenum[0] = now.day - 2;
        } else if (week == 7) {
          //select[0] = false;
          datenum[0] = now.day + 4;
        }
      }
      if (day[4] == false) {
        daytext = 'Fri';
        daytexttr = 'Fri'.tr;
        if (week == 1) {
          //select[0] = false;
          datenum[0] = now.day + 4;
        } else if (week == 2) {
          //select[0] = false;
          datenum[0] = now.day + 3;
        } else if (week == 3) {
          //select[0] = false;
          datenum[0] = now.day + 2;
        } else if (week == 4) {
          //select[0] = false;
          datenum[0] = now.day + 1;
        } else if (week == 5) {
          select[0] = false;
          datenum[0] = now.day;
        } else if (week == 6) {
          select[0] = false;
          datenum[0] = now.day - 1;
        } else if (week == 7) {
          //select[0] = false;
          datenum[0] = now.day + 5;
        }
      }
      if (week == 6) {
        select[0] = false;
      }

      for (var i = 0; i < 5; i++) {
        if (month == 1) {
          datemonth[i] = 1;
        } else if (month == 2) {
          datemonth[i] = 2;
        } else if (month == 3) {
          datemonth[i] = 3;
        } else if (month == 4) {
          datemonth[i] = 4;
        } else if (month == 5) {
          datemonth[i] = 5;
        } else if (month == 6) {
          datemonth[i] = 6;
        } else if (month == 7) {
          datemonth[i] = 7;
        } else if (month == 8) {
          datemonth[i] = 8;
        } else if (month == 9) {
          datemonth[i] = 9;
        } else if (month == 10) {
          datemonth[i] = 10;
        } else if (month == 11) {
          datemonth[i] = 11;
        } else if (month == 12) {
          datemonth[i] = 12;
        }
      }

      for (var i = 0; i < 5; i++) {
        dateyear[i] = year;
      }

      if (datenum[0] > daysInMonth) {
        datenum[0] = datenum[0] - daysInMonth;
        if (datemonth[0] != 12) {
          datemonth[0] = datemonth[0] + 1;
          datemonth[1] = datemonth[1] + 1;
          datemonth[2] = datemonth[2] + 1;
          datemonth[3] = datemonth[3] + 1;
        } else {
          datemonth[0] = 1;
          datemonth[1] = 1;
          datemonth[2] = 1;
          datemonth[3] = 1;

          dateyear[0] = dateyear[0] + 1;
          dateyear[1] = dateyear[1] + 1;
          dateyear[2] = dateyear[2] + 1;
          dateyear[3] = dateyear[3] + 1;
        }
      } else if (datenum[0] <= 0) {
        print('${datenum[0]} + ${daysInlastMonth}');
        datenum[0] = datenum[0] + daysInlastMonth;
        if (datemonth[0] != 1) {
          datemonth[0] = datemonth[0] - 1;
          datemonth[1] = datemonth[1] - 1;
          datemonth[2] = datemonth[2] - 1;
          datemonth[3] = datemonth[3] - 1;
        } else {
          datemonth[0] = 12;
          datemonth[1] = 12;
          datemonth[2] = 12;
          datemonth[3] = 12;

          dateyear[0] = dateyear[0] - 1;
          dateyear[1] = dateyear[1] - 1;
          dateyear[2] = dateyear[2] - 1;
          dateyear[3] = dateyear[3] - 1;
        }
      }

      for (var i = 1; i < 5; i++) {
        datenum[i] = datenum[0] + (7 * i);

        if (datenum[i] > daysInMonth) {
          datenum[i] = datenum[i] - daysInMonth;
          if (datemonth[0] != 12) {
            datemonth[i] = datemonth[i] + 1;
          } else {
            datemonth[i] = 1;
            dateyear[i] = year + 1;
          }
        } else if (datenum[i] < 0) {
          datenum[i] = datenum[i] + daysInlastMonth;
          if (datemonth[0] != 1) {
            datemonth[i] = datemonth[i] - 1;
          } else {
            datemonth[i] = 12;
            dateyear[i] = year - 1;
          }
        }
      }
      //print(DateTime.utc(dateyear[1], datemonth[1], datenum[1]).weekday);
      if (DateTime.utc(dateyear[0], datemonth[0], datenum[0]).weekday !=
          DateTime.utc(dateyear[1], datemonth[1], datenum[1]).weekday) {
        for (var i = 1; i < 5; i++) {
          datenum[i] = datenum[0] + (7 * i) - 1;

          if (datenum[i] > daysInMonth) {
            datenum[i] = datenum[i] - daysInMonth;
            if (datemonth[0] != 12) {
              datemonth[i] = datemonth[i] + 1;
            } else {
              datemonth[i] = 1;
              dateyear[i] = year + 1;
            }
          } else if (datenum[i] < 0) {
            datenum[i] = datenum[i] + daysInlastMonth;
            if (datemonth[0] != 1) {
              datemonth[i] = datemonth[i] - 1;
            } else {
              datemonth[i] = 12;
              dateyear[i] = year - 1;
            }
          }
        }
      }

      for (var i = 0; i < 5; i++) {
        if (datemonth[i] == 1) {
          datemonthText[i] = 'Jan'.tr;
        } else if (datemonth[i] == 2) {
          datemonthText[i] = 'Feb'.tr;
        } else if (datemonth[i] == 3) {
          datemonthText[i] = 'Mar'.tr;
        } else if (datemonth[i] == 4) {
          datemonthText[i] = 'Apr'.tr;
        } else if (datemonth[i] == 5) {
          datemonthText[i] = 'May'.tr;
        } else if (datemonth[i] == 6) {
          datemonthText[i] = 'Jun'.tr;
        } else if (datemonth[i] == 7) {
          datemonthText[i] = 'Jul'.tr;
        } else if (datemonth[i] == 8) {
          datemonthText[i] = 'Aug'.tr;
        } else if (datemonth[i] == 9) {
          datemonthText[i] = 'Sep'.tr;
        } else if (datemonth[i] == 10) {
          datemonthText[i] = 'Oct'.tr;
        } else if (datemonth[i] == 11) {
          datemonthText[i] = 'Nov'.tr;
        } else if (datemonth[i] == 12) {
          datemonthText[i] = 'Dec'.tr;
        }
      }
    } catch (e) {}





    try {
      if (day2[0] == false) {
        daytext2 = 'Mon';
        if (week == 1) {
          //select[0] = false;
          datenum2[0] = now.day;
        } else if (week == 2) {
          //select[0] = false;
          datenum2[0] = now.day - 1;
        } else if (week == 3) {
          //select[0] = false;
          datenum2[0] = now.day - 2;
        } else if (week == 4) {
          //select[0] = false;
          datenum2[0] = now.day - 3;
        } else if (week == 5) {
          //select[0] = false;
          datenum2[0] = now.day - 4;
        } else if (week == 6) {
          //select[0] = false;
          datenum2[0] = now.day - 5;
        } else if (week == 7) {
          //select[0] = false;
          datenum2[0] = now.day + 1;
        }
      }
      if (day2[1] == false) {
        daytext2 = 'Tue';
        if (week == 1) {
          //select[0] = false;
          datenum2[0] = now.day + 1;
        } else if (week == 2) {
          //select[0] = false;
          datenum2[0] = now.day;
        } else if (week == 3) {
          //select[0] = false;
          datenum2[0] = now.day - 1;
        } else if (week == 4) {
          //select[0] = false;
          datenum2[0] = now.day - 2;
        } else if (week == 5) {
          //select[0] = false;
          datenum2[0] = now.day - 3;
        } else if (week == 6) {
          //select[0] = false;
          datenum2[0] = now.day - 4;
        } else if (week == 7) {
          //select[0] = false;
          datenum2[0] = now.day + 2;
        }
      }
      if (day2[2] == false) {
        daytext2 = 'Wed';
        if (week == 1) {
          //select[0] = false;
          datenum2[0] = now.day + 2;
        } else if (week == 2) {
          //select[0] = false;
          datenum2[0] = now.day + 1;
        } else if (week == 3) {
          //select[0] = false;
          datenum2[0] = now.day;
        } else if (week == 4) {
          //select[0] = false;
          datenum2[0] = now.day - 1;
        } else if (week == 5) {
          //select[0] = false;
          datenum2[0] = now.day - 2;
        } else if (week == 6) {
          //select[0] = false;
          datenum2[0] = now.day - 3;
        } else if (week == 7) {
          datenum2[0] = now.day + 3;
        }
      }
      if (day2[3] == false) {
        daytext2 = 'Thu';
        if (week == 1) {
          //select[0] = false;
          datenum2[0] = now.day + 3;
        } else if (week == 2) {
          //select[0] = false;
          datenum2[0] = now.day + 4;
        } else if (week == 3) {
          //select[0] = false;
          datenum2[0] = now.day + 1;
        } else if (week == 4) {
          //select[0] = false;
          datenum[0] = now.day;
        } else if (week == 5) {
          //select[0] = false;
          datenum2[0] = now.day - 1;
        } else if (week == 6) {
          //select[0] = false;
          datenum2[0] = now.day - 2;
        } else if (week == 7) {
          //select[0] = false;
          datenum2[0] = now.day + 4;
        }
      }
      if (day2[4] == false) {
        daytext2 = 'Fri';
        if (week == 1) {
          //select[0] = false;
          datenum2[0] = now.day + 4;
        } else if (week == 2) {
          //select[0] = false;
          datenum2[0] = now.day + 3;
        } else if (week == 3) {
          //select[0] = false;
          datenum2[0] = now.day + 2;
        } else if (week == 4) {
          //select[0] = false;
          datenum2[0] = now.day + 1;
        } else if (week == 5) {
          //select[0] = false;
          datenum2[0] = now.day;
        } else if (week == 6) {
          //select[0] = false;
          datenum2[0] = now.day - 1;
        } else if (week == 7) {
          //select[0] = false;
          datenum2[0] = now.day + 5;
        }
      }

      for (var i = 0; i < 5; i++) {
        if (month == 1) {
          datemonth2[i] = 1;
        } else if (month == 2) {
          datemonth2[i] = 2;
        } else if (month == 3) {
          datemonth2[i] = 3;
        } else if (month == 4) {
          datemonth2[i] = 4;
        } else if (month == 5) {
          datemonth2[i] = 5;
        } else if (month == 6) {
          datemonth2[i] = 6;
        } else if (month == 7) {
          datemonth2[i] = 7;
        } else if (month == 8) {
          datemonth2[i] = 8;
        } else if (month == 9) {
          datemonth2[i] = 9;
        } else if (month == 10) {
          datemonth2[i] = 10;
        } else if (month == 11) {
          datemonth2[i] = 11;
        } else if (month == 12) {
          datemonth2[i] = 12;
        }
      }

      for (var i = 0; i < 5; i++) {
        dateyear2[i] = year;
      }

      if (datenum2[0] > daysInMonth) {
        datenum2[0] = datenum2[0] - daysInMonth;
        if (datemonth2[0] != 12) {
          datemonth2[0] = datemonth2[0] + 1;
          datemonth2[1] = datemonth2[1] + 1;
          datemonth2[2] = datemonth2[2] + 1;
          datemonth2[3] = datemonth2[3] + 1;
        } else {
          datemonth2[0] = 1;
          datemonth2[1] = 1;
          datemonth2[2] = 1;
          datemonth2[3] = 1;

          dateyear2[0] = dateyear2[0] + 1;
          dateyear2[1] = dateyear2[1] + 1;
          dateyear2[2] = dateyear2[2] + 1;
          dateyear2[3] = dateyear2[3] + 1;
        }
      } else if (datenum2[0] <= 0) {
        datenum2[0] = datenum2[0] + daysInlastMonth;
        if (datemonth2[0] != 1) {
          datemonth2[0] = datemonth2[0] - 1;
          datemonth2[1] = datemonth2[1] - 1;
          datemonth2[2] = datemonth2[2] - 1;
          datemonth2[3] = datemonth2[3] - 1;
        } else {
          datemonth2[0] = 12;
          datemonth2[1] = 12;
          datemonth2[2] = 12;
          datemonth2[3] = 12;

          dateyear2[0] = dateyear2[0] - 1;
          dateyear2[1] = dateyear2[1] - 1;
          dateyear2[2] = dateyear2[2] - 1;
          dateyear2[3] = dateyear2[3] - 1;
        }
      }

      for (var i = 1; i < 5; i++) {
        datenum2[i] = datenum2[0] + (7 * i);

        if (datenum2[i] > daysInMonth) {
          datenum2[i] = datenum2[i] - daysInMonth;
          if (datemonth2[0] != 12) {
            datemonth2[i] = datemonth2[i] + 1;
          } else {
            datemonth2[i] = 1;
            dateyear2[i] = year + 1;
          }
        } else if (datenum2[i] < 0) {
          datenum2[i] = datenum2[i] + daysInlastMonth;
          if (datemonth2[0] != 1) {
            datemonth2[i] = datemonth2[i] - 1;
          } else {
            datemonth2[i] = 12;
            dateyear2[i] = year - 1;
          }
        }
      }
      //print(DateTime.utc(dateyear[1], datemonth[1], datenum[1]).weekday);
      if (DateTime.utc(dateyear2[0], datemonth2[0], datenum2[0]).weekday !=
          DateTime.utc(dateyear2[1], datemonth2[1], datenum2[1]).weekday) {
        for (var i = 1; i < 5; i++) {
          datenum2[i] = datenum2[0] + (7 * i) - 1;

          if (datenum2[i] > daysInMonth) {
            datenum2[i] = datenum2[i] - daysInMonth;
            if (datemonth2[0] != 12) {
              datemonth2[i] = datemonth2[i] + 1;
            } else {
              datemonth2[i] = 1;
              dateyear2[i] = year + 1;
            }
          } else if (datenum2[i] < 0) {
            datenum2[i] = datenum2[i] + daysInlastMonth;
            if (datemonth2[0] != 1) {
              datemonth2[i] = datemonth2[i] - 1;
            } else {
              datemonth2[i] = 12;
              dateyear2[i] = year - 1;
            }
          }
        }
      }

      for (var i = 0; i < 5; i++) {
        if (datemonth2[i] == 1) {
          datemonthText2[i] = 'Jan'.tr;
        } else if (datemonth2[i] == 2) {
          datemonthText2[i] = 'Feb'.tr;
        } else if (datemonth2[i] == 3) {
          datemonthText2[i] = 'Mar'.tr;
        } else if (datemonth2[i] == 4) {
          datemonthText2[i] = 'Apr'.tr;
        } else if (datemonth2[i] == 5) {
          datemonthText2[i] = 'May'.tr;
        } else if (datemonth2[i] == 6) {
          datemonthText2[i] = 'Jun'.tr;
        } else if (datemonth2[i] == 7) {
          datemonthText2[i] = 'Jul'.tr;
        } else if (datemonth2[i] == 8) {
          datemonthText2[i] = 'Aug'.tr;
        } else if (datemonth2[i] == 9) {
          datemonthText2[i] = 'Sep'.tr;
        } else if (datemonth2[i] == 10) {
          datemonthText2[i] = 'Oct'.tr;
        } else if (datemonth2[i] == 11) {
          datemonthText2[i] = 'Nov'.tr;
        } else if (datemonth2[i] == 12) {
          datemonthText2[i] = 'Dec'.tr;
        }
      }
    } catch (e) {}

    return datenum.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 1000,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Choose a date'.tr,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                select[0] = true;
                                select[1] = false;
                                select[2] = false;
                                select[3] = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 200,
                              height: 60,
                              decoration: select[0]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: select[0]
                                          ? Colors.amber
                                          : Colors.white)
                                  : null,
                              child: Center(
                                child: Text(
                                  '${daytexttr}' +' ' +
                                      '${datenum[0]} ' +
                                      '${datemonthText[0]} ' +
                                      '${dateyear[0]}',
                                  style: TextStyle(
                                      color: select[0]
                                          ? Theme.of(context).colorScheme.shadow
                                          : Theme.of(context).colorScheme.scrim),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                select[0] = false;
                                select[1] = true;
                                select[2] = false;
                                select[3] = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              width: 200,
                              height: 60,
                              decoration: select[1]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: select[1]
                                          ? Colors.amber
                                          : Colors.white)
                                  : null,
                              child: Center(
                                child: Text(
                                  '${daytexttr}' +' ' +
                                      '${datenum[1]} ' +
                                      '${datemonthText[1]} ' +
                                      '${dateyear[1]}',
                                  style: TextStyle(
                                      color: select[1]
                                          ? Theme.of(context).colorScheme.shadow
                                          : Theme.of(context).colorScheme.scrim),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                select[0] = false;
                                select[1] = false;
                                select[2] = true;
                                select[3] = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              width: 200,
                              height: 60,
                              decoration: select[2]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: select[2]
                                          ? Colors.amber
                                          : Colors.white)
                                  : null,
                              child: Center(
                                child: Text(
                                  '${daytexttr}' +' ' +
                                      '${datenum[2]} ' +
                                      '${datemonthText[2]} ' +
                                      '${dateyear[2]}',
                                  style: TextStyle(
                                      color: select[2]
                                          ? Theme.of(context).colorScheme.shadow
                                          : Theme.of(context).colorScheme.scrim),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                select[0] = false;
                                select[1] = false;
                                select[2] = false;
                                select[3] = true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              width: 200,
                              height: 60,
                              decoration: select[3]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: select[3]
                                          ? Colors.amber
                                          : Colors.white)
                                  : null,
                              child: Center(
                                child: Text(
                                  '${daytexttr}' +' ' +
                                      '${datenum[3]} ' +
                                      '${datemonthText[3]} ' +
                                      '${dateyear[3]}',
                                  style: TextStyle(
                                      color: select[3]
                                          ? Theme.of(context).colorScheme.shadow
                                          : Theme.of(context).colorScheme.scrim),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Center(
                      child: MaterialButton(
                        color: const Color(0xFF32C65F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          if (select[0] == true) {
                            //print(day2);
                            final request = Requests(
                                teachername1: classes[globals.userNumber].name,
                                teacherlastname1:
                                    classes[globals.userNumber].lastname,
                                day1: daytext,
                                date1: '${datenum[0]}',
                                month1: '${datemonth[0]}',
                                year1: '${dateyear[0]}',
                                period1: '${classnum}',
                                periodname1: '${classroom1}',
                                teachername2: teachername2,
                                teacherlastname2: teacherlastname2,
                                day2: daytext2,
                                date2: '${datenum2[1]}',
                                month2: '${datemonth2[1]}',
                                year2: '${dateyear2[1]}',
                                period2: '${period2}',
                                periodname2: '${classroom2}'
                            );
                            final id = await ClassSheetsApi.getRowCount() + 1;
                            final newRequest = request.copy(id: id);

                            await ClassSheetsApi.insert([newRequest.toJson()]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                          }
                          if (select[1] == true) {
                            //print(day2);
                            final request = Requests(
                                teachername1: classes[globals.userNumber].name,
                                teacherlastname1:
                                    classes[globals.userNumber].lastname,
                                day1: daytext,
                                date1: '${datenum[1]}',
                                month1: '${datemonth[1]}',
                                year1: '${dateyear[1]}',
                                period1: '${classnum}',
                                periodname1: '${classroom1}',
                                teachername2: teachername2,
                                teacherlastname2: teacherlastname2,
                                day2: daytext2,
                                date2: '${datenum2[2]}',
                                month2: '${datemonth2[2]}',
                                year2: '${dateyear2[2]}',
                                period2: '${period2}',
                                periodname2: '${classroom2}',
                            );
                            final id = await ClassSheetsApi.getRowCount() + 1;
                            final newRequest = request.copy(id: id);

                            await ClassSheetsApi.insert([newRequest.toJson()]);
                           Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                          }
                          if (select[2] == true) {
                            //print(day2);
                            final request = Requests(
                                teachername1: classes[globals.userNumber].name,
                                teacherlastname1:
                                    classes[globals.userNumber].lastname,
                                day1: daytext,
                                date1: '${datenum[2]}',
                                month1: '${datemonth[2]}',
                                year1: '${dateyear[2]}',
                                period1: '${classnum}',
                                periodname1: '${classroom1}',
                                teachername2: teachername2,
                                teacherlastname2: teacherlastname2,
                                day2: daytext2,
                                date2: '${datenum2[3]}',
                                month2: '${datemonth2[3]}',
                                year2: '${dateyear2[3]}',
                                period2: '${period2}',
                                periodname2: '${classroom2}',
                            );
                            final id = await ClassSheetsApi.getRowCount() + 1;
                            final newRequest = request.copy(id: id);

                            await ClassSheetsApi.insert([newRequest.toJson()]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                          }
                          if (select[3] == true) {
                            //print(day2);
                            final request = Requests(
                                teachername1: classes[globals.userNumber].name,
                                teacherlastname1:
                                    classes[globals.userNumber].lastname,
                                day1: daytext,
                                date1: '${datenum[3]}',
                                month1: '${datemonth[3]}',
                                year1: '${dateyear[3]}',
                                period1: '${classnum}',
                                periodname1: '${classroom1}',
                                teachername2: teachername2,
                                teacherlastname2: teacherlastname2,
                                day2: daytext2,
                                date2: '${datenum2[4]}',
                                month2: '${datemonth2[4]}',
                                year2: '${dateyear2[4]}',
                                period2: '${period2}',
                                periodname2: '${classroom2}',
                            );
                            final id = await ClassSheetsApi.getRowCount() + 1;
                            final newRequest = request.copy(id: id);

                            await ClassSheetsApi.insert([newRequest.toJson()]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          child: Text(
                            "Confirm".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

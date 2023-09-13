import 'dart:convert';

class ClassFields {
  static final String id = 'ที่';
  static final String name = 'ชื่อ';
  static final String lastname = 'สกุล';
  static final String rank = 'ตำแหน่ง';
  static final String grade = 'ชั้น';
  static final String subject = 'วิชา';
//Monday
  static final String monday1 = 'จ1';
  static final String monday2 = 'จ2';
  static final String monday3 = 'จ3';
  static final String monday4 = 'จ4';
  static final String monday5 = 'จ5';
  static final String monday6 = 'จ6';
  static final String monday7 = 'จ7';
//Thesday
  static final String thesday1 = 'อ1';
  static final String thesday2 = 'อ2';
  static final String thesday3 = 'อ3';
  static final String thesday4 = 'อ4';
  static final String thesday5 = 'อ5';
  static final String thesday6 = 'อ6';
  static final String thesday7 = 'อ7';
//Wednesday
  static final String wednesday1 = 'พ1';
  static final String wednesday2 = 'พ2';
  static final String wednesday3 = 'พ3';
  static final String wednesday4 = 'พ4';
  static final String wednesday5 = 'พ5';
  static final String wednesday6 = 'พ6';
  static final String wednesday7 = 'พ7';
//Thursday
  static final String thursday1 = 'พฤ1';
  static final String thursday2 = 'พฤ2';
  static final String thursday3 = 'พฤ3';
  static final String thursday4 = 'พฤ4';
  static final String thursday5 = 'พฤ5';
  static final String thursday6 = 'พฤ6';
  static final String thursday7 = 'พฤ7';
//Friday
  static final String friday1 = 'ศ1';
  static final String friday2 = 'ศ2';
  static final String friday3 = 'ศ3';
  static final String friday4 = 'ศ4';
  static final String friday5 = 'ศ5';
  static final String friday6 = 'ศ6';
  static final String friday7 = 'ศ7';

  static final String content = 'สาระ';

  static List<String> getFields() => [id, name, lastname, rank, grade, subject, 
                                      monday1, monday2, monday3, monday4, monday5, monday6, monday7,
                                      thesday1, thesday2, thesday3, thesday4, thesday5, thesday6, thesday7,
                                      wednesday1, wednesday2, wednesday3, wednesday4, wednesday5, wednesday6, wednesday7,
                                      thursday1, thursday2, thursday3, thursday4, thursday5, thursday6, thursday7,
                                      friday1, friday2, friday3, friday4, friday5, friday6, friday7, content,];
}

class ClassTeacher {
  final int? id;
  final String name;
  final String lastname;
  final String rank;
  final String grade;
  final String subject;
//Monday
  final String monday1;
  final String monday2;
  final String monday3;
  final String monday4;
  final String monday5;
  final String monday6;
  final String monday7;
//Thesday
  final String thesday1;
  final String thesday2;
  final String thesday3;
  final String thesday4;
  final String thesday5;
  final String thesday6;
  final String thesday7;
//Wednesday
  final String wednesday1;
  final String wednesday2;
  final String wednesday3;
  final String wednesday4;
  final String wednesday5;
  final String wednesday6;
  final String wednesday7;
//Thursday
  final String thursday1;
  final String thursday2;
  final String thursday3;
  final String thursday4;
  final String thursday5;
  final String thursday6;
  final String thursday7;
//Friday
  final String friday1;
  final String friday2;
  final String friday3;
  final String friday4;
  final String friday5;
  final String friday6;
  final String friday7;

  final String content;
  
  const ClassTeacher({
    this.id,
    required this.name,
    required this.lastname,
    required this.rank,
    required this.grade,
    required this.subject,
    //Monday
    required this.monday1,
    required this.monday2,
    required this.monday3,
    required this.monday4,
    required this.monday5,
    required this.monday6,
    required this.monday7,
    //Thesday
    required this.thesday1,
    required this.thesday2,
    required this.thesday3,
    required this.thesday4,
    required this.thesday5,
    required this.thesday6,
    required this.thesday7,
    //Wednesday
    required this.wednesday1,
    required this.wednesday2,
    required this.wednesday3,
    required this.wednesday4,
    required this.wednesday5,
    required this.wednesday6,
    required this.wednesday7,
    //Thursday
    required this.thursday1,
    required this.thursday2,
    required this.thursday3,
    required this.thursday4,
    required this.thursday5,
    required this.thursday6,
    required this.thursday7,
    //Friday
    required this.friday1,
    required this.friday2,
    required this.friday3,
    required this.friday4,
    required this.friday5,
    required this.friday6,
    required this.friday7,
    
    required this.content,
  });

  static ClassTeacher fromJson(Map<String, dynamic> json) => ClassTeacher(
        id: jsonDecode(json[ClassFields.id]),
        name: json[ClassFields.name],
        lastname: json[ClassFields.lastname],
        rank: json[ClassFields.rank],
        grade: json[ClassFields.grade],
        subject: json[ClassFields.subject],
        //Monday
        monday1: json[ClassFields.monday1],
        monday2: json[ClassFields.monday2],
        monday3: json[ClassFields.monday3],
        monday4: json[ClassFields.monday4],
        monday5: json[ClassFields.monday5],
        monday6: json[ClassFields.monday6],
        monday7: json[ClassFields.monday7],
        //Thesday
        thesday1: json[ClassFields.thesday1],
        thesday2: json[ClassFields.thesday2],
        thesday3: json[ClassFields.thesday3],
        thesday4: json[ClassFields.thesday4],
        thesday5: json[ClassFields.thesday5],
        thesday6: json[ClassFields.thesday6],
        thesday7: json[ClassFields.thesday7],
        //Wednesday
        wednesday1: json[ClassFields.wednesday1],
        wednesday2: json[ClassFields.wednesday2],
        wednesday3: json[ClassFields.wednesday3],
        wednesday4: json[ClassFields.wednesday4],
        wednesday5: json[ClassFields.wednesday5],
        wednesday6: json[ClassFields.wednesday6],
        wednesday7: json[ClassFields.wednesday7],
        //Thursday
        thursday1: json[ClassFields.thursday1],
        thursday2: json[ClassFields.thursday2],
        thursday3: json[ClassFields.thursday3],
        thursday4: json[ClassFields.thursday4],
        thursday5: json[ClassFields.thursday5],
        thursday6: json[ClassFields.thursday6],
        thursday7: json[ClassFields.thursday7],
        //Friday
        friday1: json[ClassFields.friday1],
        friday2: json[ClassFields.friday2],
        friday3: json[ClassFields.friday3],
        friday4: json[ClassFields.friday4],
        friday5: json[ClassFields.friday5],
        friday6: json[ClassFields.friday6],
        friday7: json[ClassFields.friday7],

        content: json[ClassFields.content],
      );

  Map<String, dynamic> toJson() => {
        ClassFields.id: id,
        ClassFields.name: name,
        ClassFields.lastname: lastname,
        ClassFields.rank: rank,
        ClassFields.grade: grade,
        ClassFields.subject: subject,
        //Monday
        ClassFields.monday1: monday1,
        ClassFields.monday2: monday2,
        ClassFields.monday3: monday3,
        ClassFields.monday4: monday4,
        ClassFields.monday5: monday5,
        ClassFields.monday6: monday6,
        ClassFields.monday7: monday7,
        //Thesday
        ClassFields.thesday1: thesday1,
        ClassFields.thesday2: thesday2,
        ClassFields.thesday3: thesday3,
        ClassFields.thesday4: thesday4,
        ClassFields.thesday5: thesday5,
        ClassFields.thesday6: thesday6,
        ClassFields.thesday7: thesday7,
        //Wednesday
        ClassFields.wednesday1: wednesday1,
        ClassFields.wednesday2: wednesday2,
        ClassFields.wednesday3: wednesday3,
        ClassFields.wednesday4: wednesday4,
        ClassFields.wednesday5: wednesday5,
        ClassFields.wednesday6: wednesday6,
        ClassFields.wednesday7: wednesday7,
        //Thursday
        ClassFields.thursday1: thursday1,
        ClassFields.thursday2: thursday2,
        ClassFields.thursday3: thursday3,
        ClassFields.thursday4: thursday4,
        ClassFields.thursday5: thursday5,
        ClassFields.thursday6: thursday6,
        ClassFields.thursday7: thursday7,
        //Friday
        ClassFields.friday1: friday1,
        ClassFields.friday2: friday2,
        ClassFields.friday3: friday3,
        ClassFields.friday4: friday4,
        ClassFields.friday5: friday5,
        ClassFields.friday6: friday6,
        ClassFields.friday7: friday7,

        ClassFields.content: content,
      };
}











class ClassNumFields {
  static final String number = 'ลำดับ';
  static final String allclass = 'ห้อง';
  static final String colorBg = 'สีหลัง';
  static final String colorText = 'สีตัวหนังสือ';

  static List<String> getFields() => [number, allclass, colorBg, colorText];
}

class ClassNum {
  final int? number;
  final String allclass;
  final String colorBg;
  final String colorText;
  
  const ClassNum({
    this.number,
    required this.allclass,
    required this.colorBg,
    required this.colorText,
  });

  static ClassNum fromJson(Map<String, dynamic> json) => ClassNum(
        number: jsonDecode(json[ClassNumFields.number]),
        allclass: json[ClassNumFields.allclass],
        colorBg: json[ClassNumFields.colorBg],
        colorText: json[ClassNumFields.colorText],
      );

  Map<String, dynamic> toJson() => {
        ClassNumFields.number: number,
        ClassNumFields.allclass: allclass,
        ClassNumFields.colorBg: colorBg,
        ClassNumFields.colorText: colorText,
      };
}





class ClassTimeFields {
  static final String number = 'คาบเรียน';
  static final String time = 'เวลา';

  static List<String> getFields() => [number, time];
}

class ClassTime {
  final int? number;
  final String time;
  
  const ClassTime({
    this.number,
    required this.time,
  });

  static ClassTime fromJson(Map<String, dynamic> json) => ClassTime(
        number: jsonDecode(json[ClassTimeFields.number]),
        time: json[ClassTimeFields.time],
      );

  Map<String, dynamic> toJson() => {
        ClassTimeFields.number: number,
        ClassTimeFields.time: time,
      };
}





class RequestFields {
  static final String id = 'ที่';
  static final String teachername1 = 'ชื่อ1';
  static final String teacherlastname1 = 'สกุล1';
  static final String day1 = 'วัน1';
  static final String date1 = 'วันที่1';
  static final String month1 = 'เดือน1';
  static final String year1 = 'ปี1';
  static final String period1 = 'คาบ1';
  static final String periodname1 = 'ชื่อคาบ1';
  static final String teachername2 = 'ชื่อ2';
  static final String teacherlastname2 = 'สกุล2';
  static final String day2 = 'วัน2';
  static final String date2 = 'วันที่2';
  static final String month2 = 'เดือน2';
  static final String year2 = 'ปี2';
  static final String period2 = 'คาบ2';
  static final String periodname2 = 'ชื่อคาบ2';

  static List<String> getFields() => [id, teachername1, teacherlastname1, day1, date1, month1, year1, period1, periodname1, teachername2, teacherlastname2, day2, date2, month2, year2, period2, periodname2];
}

class Requests {
  final int? id;
  final String teachername1;
  final String teacherlastname1;
  final String day1;
  final String date1;
  final String month1;
  final String year1;
  final String period1;
  final String periodname1;
  final String teachername2;
  final String teacherlastname2;
  final String day2;
  final String date2;
  final String month2;
  final String year2;
  final String period2;
  final String periodname2;
  
  const Requests({
    this.id,
    required this.teachername1,
    required this.teacherlastname1,
    required this.day1,
    required this.date1,
    required this.month1,
    required this.year1,
    required this.period1,
    required this.periodname1,
    required this.teachername2,
    required this.teacherlastname2,
    required this.day2,
    required this.date2,
    required this.month2,
    required this.year2,
    required this.period2,
    required this.periodname2,
  });

  Requests copy({
    int? id,
    String? teachername1,
    String? teacherlastname1,
    String? day1,
    String? date1,
    String? month1,
    String? year1,
    String? period1,
    String? periodname1,
    String? teachername2,
    String? teacherlastname2,
    String? day2,
    String? date2,
    String? month2,
    String? year2,
    String? period2,
    String? periodname2,
  }) => Requests(
    id: id ?? this.id,
    teachername1: teachername1 ?? this.teachername1, 
    teacherlastname1: teacherlastname1 ?? this.teacherlastname1, 
    day1: day1 ?? this.day1, 
    date1: date1 ?? this.date1, 
    month1: month1 ?? this.month1, 
    year1: year1 ?? this.year1, 
    period1: period1 ?? this.period1, 
    periodname1: periodname1 ?? this.periodname1, 
    teachername2: teachername2 ?? this.teachername2, 
    teacherlastname2: teacherlastname2 ?? this.teacherlastname2, 
    day2: day2 ?? this.day2, 
    date2: date2 ?? this.date2, 
    month2: month2 ?? this.month2, 
    year2: year2 ?? this.year2, 
    period2: period2 ?? this.period2,
    periodname2: periodname2 ?? this.periodname2, 
  );

  static Requests fromJson(Map<String, dynamic> json) => Requests(
        id: jsonDecode(json[RequestFields.id]),
        teachername1: json[RequestFields.teachername1],
        teacherlastname1: json[RequestFields.teacherlastname1],
        day1: json[RequestFields.day1],
        date1: json[RequestFields.date1],
        month1: json[RequestFields.month1],
        year1: json[RequestFields.year1],
        period1: json[RequestFields.period1],
        periodname1: json[RequestFields.periodname1],
        teachername2: json[RequestFields.teachername2],
        teacherlastname2: json[RequestFields.teacherlastname2],
        day2: json[RequestFields.day2],
        date2: json[RequestFields.date2],
        month2: json[RequestFields.month2],
        year2: json[RequestFields.year2],
        period2: json[RequestFields.period2],
        periodname2: json[RequestFields.periodname2],
      );

  Map<String, dynamic> toJson() => {
        RequestFields.id: id,
        RequestFields.teachername1: teachername1,
        RequestFields.teacherlastname1: teacherlastname1,
        RequestFields.day1: day1,
        RequestFields.date1: date1,
        RequestFields.month1: month1,
        RequestFields.year1: year1,
        RequestFields.period1: period1,
        RequestFields.periodname1: periodname1,
        RequestFields.teachername2: teachername2,
        RequestFields.teacherlastname2: teacherlastname2,
        RequestFields.day2: day2,
        RequestFields.date2: date2,
        RequestFields.month2: month2,
        RequestFields.year2: year2,
        RequestFields.period2: period2,
        RequestFields.periodname2: periodname2,
      };
}





class UsersFields {
  static final String id = 'ที่';
  static final String name = 'ชื่อ';
  static final String lastname = 'สกุล';
  static final String email = 'Email';
  static final String password = 'Password';

  static List<String> getFields() => [id, name, lastname, email, password];
}

class Users {
  final int? id;
  final String name;
  final String lastname;
  final String email;
  final String password;
  
  const Users({
    this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
  });

  static Users fromJson(Map<String, dynamic> json) => Users(
        id: jsonDecode(json[UsersFields.id]),
        name: json[UsersFields.name],
        lastname: json[UsersFields.lastname],
        email: json[UsersFields.email],
        password: json[UsersFields.password],
      );

  Map<String, dynamic> toJson() => {
        UsersFields.id: id,
        UsersFields.name: name,
        UsersFields.lastname: lastname,
        UsersFields.email: email,
        UsersFields.password: password,
      };
}





class ConfirmFields {
  static final String id = 'ที่';
  static final String teachername1 = 'ชื่อ1';
  static final String teacherlastname1 = 'สกุล1';
  static final String day1 = 'วัน1';
  static final String date1 = 'วันที่1';
  static final String month1 = 'เดือน1';
  static final String year1 = 'ปี1';
  static final String period1 = 'คาบ1';
  static final String periodname1 = 'ชื่อคาบ1';
  static final String teachername2 = 'ชื่อ2';
  static final String teacherlastname2 = 'สกุล2';
  static final String day2 = 'วัน2';
  static final String date2 = 'วันที่2';
  static final String month2 = 'เดือน2';
  static final String year2 = 'ปี2';
  static final String period2 = 'คาบ2';
  static final String periodname2 = 'ชื่อคาบ2';

  static List<String> getFields() => [id, teachername1, teacherlastname1, day1, date1, month1, year1, period1, periodname1, teachername2, teacherlastname2, day2, date2, month2, year2, period2, periodname2];
}

class Confirms {
  final int? id;
  final String teachername1;
  final String teacherlastname1;
  final String day1;
  final String date1;
  final String month1;
  final String year1;
  final String period1;
  final String periodname1;
  final String teachername2;
  final String teacherlastname2;
  final String day2;
  final String date2;
  final String month2;
  final String year2;
  final String period2;
  final String periodname2;
  
  const Confirms({
    this.id,
    required this.teachername1,
    required this.teacherlastname1,
    required this.day1,
    required this.date1,
    required this.month1,
    required this.year1,
    required this.period1,
    required this.periodname1,
    required this.teachername2,
    required this.teacherlastname2,
    required this.day2,
    required this.date2,
    required this.month2,
    required this.year2,
    required this.period2,
    required this.periodname2,
  });

  Confirms copy({
    int? id,
    String? teachername1,
    String? teacherlastname1,
    String? day1,
    String? date1,
    String? month1,
    String? year1,
    String? period1,
    String? periodname1,
    String? teachername2,
    String? teacherlastname2,
    String? day2,
    String? date2,
    String? month2,
    String? year2,
    String? period2,
    String? periodname2,
  }) => Confirms(
    id: id ?? this.id,
    teachername1: teachername1 ?? this.teachername1, 
    teacherlastname1: teacherlastname1 ?? this.teacherlastname1, 
    day1: day1 ?? this.day1, 
    date1: date1 ?? this.date1, 
    month1: month1 ?? this.month1, 
    year1: year1 ?? this.year1, 
    period1: period1 ?? this.period1, 
    periodname1: periodname1 ?? this.periodname1, 
    teachername2: teachername2 ?? this.teachername2, 
    teacherlastname2: teacherlastname2 ?? this.teacherlastname2, 
    day2: day2 ?? this.day2, 
    date2: date2 ?? this.date2, 
    month2: month2 ?? this.month2, 
    year2: year2 ?? this.year2, 
    period2: period2 ?? this.period2,
    periodname2: periodname2 ?? this.periodname2, 
  );

  static Confirms fromJson(Map<String, dynamic> json) => Confirms(
        id: jsonDecode(json[ConfirmFields.id]),
        teachername1: json[ConfirmFields.teachername1],
        teacherlastname1: json[ConfirmFields.teacherlastname1],
        day1: json[ConfirmFields.day1],
        date1: json[ConfirmFields.date1],
        month1: json[ConfirmFields.month1],
        year1: json[ConfirmFields.year1],
        period1: json[ConfirmFields.period1],
        periodname1: json[ConfirmFields.periodname1],
        teachername2: json[ConfirmFields.teachername2],
        teacherlastname2: json[ConfirmFields.teacherlastname2],
        day2: json[ConfirmFields.day2],
        date2: json[ConfirmFields.date2],
        month2: json[ConfirmFields.month2],
        year2: json[ConfirmFields.year2],
        period2: json[ConfirmFields.period2],
        periodname2: json[ConfirmFields.periodname2],
      );

  Map<String, dynamic> toJson() => {
        ConfirmFields.id: id,
        ConfirmFields.teachername1: teachername1,
        ConfirmFields.teacherlastname1: teacherlastname1,
        ConfirmFields.day1: day1,
        ConfirmFields.date1: date1,
        ConfirmFields.month1: month1,
        ConfirmFields.year1: year1,
        ConfirmFields.period1: period1,
        ConfirmFields.periodname1: periodname1,
        ConfirmFields.teachername2: teachername2,
        ConfirmFields.teacherlastname2: teacherlastname2,
        ConfirmFields.day2: day2,
        ConfirmFields.date2: date2,
        ConfirmFields.month2: month2,
        ConfirmFields.year2: year2,
        ConfirmFields.period2: period2,
        ConfirmFields.periodname2: periodname2,
      };
}
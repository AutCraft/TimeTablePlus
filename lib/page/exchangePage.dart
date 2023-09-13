import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/model/class.dart';
//import 'package:endproject/page/BottomSheetSelectDate.dart';
import 'package:endproject/page/teacherclassexchangePage.dart';
import 'package:endproject/page/userPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:endproject/globals.dart' as globals;
import 'package:get/get.dart';

class ExchangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return _ExchangePage();
  }
}

class _ExchangePage extends State<ExchangePage> {
  //List select = [false,false,false,false];
  List<ClassTeacher> classes = [];

  @override
  void initState(){
    super.initState();

    getClass();
  }

  Future getClass() async {
    final classes = await ClassSheetsApi.getAlls();

    setState(() {
      this.classes = classes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nameclass = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final classnum = nameclass[0];
    final classroom = nameclass[1];
    final day = nameclass[2];
    List star = [];
    //print(nameclass);
    //print(classnum);
    print(classroom);
    //print(day);

    try {
    for(var i=0;i<classes.length;i++) {
      if(day[0] == false){
        if(classnum == 1){
          if(classes[i].monday1 == ""){
            star.add(1);
          } else if(classes[i].monday1 != ""){
            star.add(0);
          } if(classes[i].monday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 2){
          if(classes[i].monday2 == ""){
            star.add(1);
          } else if(classes[i].monday2 != ""){
            star.add(0);
          } if(classes[i].monday1 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 3){
          if(classes[i].monday3 == ""){
            star.add(1);
          } else if(classes[i].monday3 != ""){
            star.add(0);
          } if(classes[i].monday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday4 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 4){
          if(classes[i].monday4 == ""){
            star.add(1);
          } else if(classes[i].monday4 != ""){
            star.add(0);
          } if(classes[i].monday3 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 5){
          if(classes[i].monday5 == ""){
            star.add(1);
          } else if(classes[i].monday5 != ""){
            star.add(0);
          } if(classes[i].monday4 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday6 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 6){
          if(classes[i].monday6 == ""){
            star.add(1);
          } else if(classes[i].monday6 != ""){
            star.add(0);
          } if(classes[i].monday5 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday7 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[0] == false){
        if(classnum == 7){
          if(classes[i].monday7 == ""){
            star.add(1);
          } else if(classes[i].monday7 != ""){
            star.add(0);
          } if(classes[i].monday6 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].monday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }



      if(day[1] == false){
        if(classnum == 1){
          if(classes[i].thesday1 == ""){
            star.add(1);
          } else if(classes[i].thesday1 != ""){
            star.add(0);
          } if(classes[i].thesday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 2){
          if(classes[i].thesday2 == ""){
            star.add(1);
          } else if(classes[i].thesday2 != ""){
            star.add(0);
          } if(classes[i].thesday1 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 3){
          if(classes[i].thesday3 == ""){
            star.add(1);
          } else if(classes[i].thesday3 != ""){
            star.add(0);
          } if(classes[i].thesday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday4 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 4){
          if(classes[i].thesday4 == ""){
            star.add(1);
          } else if(classes[i].thesday4 != ""){
            star.add(0);
          } if(classes[i].thesday3 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 5){
          if(classes[i].thesday5 == ""){
            star.add(1);
          } else if(classes[i].thesday5 != ""){
            star.add(0);
          } if(classes[i].thesday4 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday6 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 6){
          if(classes[i].thesday6 == ""){
            star.add(1);
          } else if(classes[i].thesday6 != ""){
            star.add(0);
          } if(classes[i].thesday5 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday7 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[1] == false){
        if(classnum == 7){
          if(classes[i].thesday7 == ""){
            star.add(1);
          } else if(classes[i].thesday7 != ""){
            star.add(0);
          } if(classes[i].thesday6 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thesday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }



      if(day[2] == false){
        if(classnum == 1){
          if(classes[i].wednesday1 == ""){
            star.add(1);
          } else if(classes[i].wednesday1 != ""){
            star.add(0);
          } if(classes[i].wednesday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 2){
          if(classes[i].wednesday2 == ""){
            star.add(1);
          } else if(classes[i].wednesday2 != ""){
            star.add(0);
          } if(classes[i].wednesday1 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 3){
          if(classes[i].wednesday3 == ""){
            star.add(1);
          } else if(classes[i].wednesday3 != ""){
            star.add(0);
          } if(classes[i].wednesday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday4 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 4){
          if(classes[i].wednesday4 == ""){
            star.add(1);
          } else if(classes[i].wednesday4 != ""){
            star.add(0);
          } if(classes[i].wednesday3 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 5){
          if(classes[i].wednesday5 == ""){
            star.add(1);
          } else if(classes[i].wednesday5 != ""){
            star.add(0);
          } if(classes[i].wednesday4 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday6 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 6){
          if(classes[i].wednesday6 == ""){
            star.add(1);
          } else if(classes[i].wednesday6 != ""){
            star.add(0);
          } if(classes[i].wednesday5 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday7 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[2] == false){
        if(classnum == 7){
          if(classes[i].wednesday7 == ""){
            star.add(1);
          } else if(classes[i].wednesday7 != ""){
            star.add(0);
          } if(classes[i].wednesday6 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].wednesday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      


      if(day[3] == false){
        if(classnum == 1){
          if(classes[i].thursday1 == ""){
            star.add(1);
          } else if(classes[i].thursday1 != ""){
            star.add(0);
          } if(classes[i].thursday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 2){
          if(classes[i].thursday2 == ""){
            star.add(1);
          } else if(classes[i].thursday2 != ""){
            star.add(0);
          } if(classes[i].thursday1 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 3){
          if(classes[i].thursday3 == ""){
            star.add(1);
          } else if(classes[i].thursday3 != ""){
            star.add(0);
          } if(classes[i].thursday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday4 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 4){
          if(classes[i].thursday4 == ""){
            star.add(1);
          } else if(classes[i].thursday4 != ""){
            star.add(0);
          } if(classes[i].thursday3 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 5){
          if(classes[i].thursday5 == ""){
            star.add(1);
          } else if(classes[i].thursday5 != ""){
            star.add(0);
          } if(classes[i].thursday4 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday6 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 6){
          if(classes[i].thursday6 == ""){
            star.add(1);
          } else if(classes[i].thursday6 != ""){
            star.add(0);
          } if(classes[i].thursday5 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday7 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[3] == false){
        if(classnum == 7){
          if(classes[i].thursday7 == ""){
            star.add(1);
          } else if(classes[i].thursday7 != ""){
            star.add(0);
          } if(classes[i].thursday6 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].thursday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }



      if(day[4] == false){
        if(classnum == 1){
          if(classes[i].friday1 == ""){
            star.add(1);
          } else if(classes[i].friday1 != ""){
            star.add(0);
          } if(classes[i].friday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 2){
          if(classes[i].friday2 == ""){
            star.add(1);
          } else if(classes[i].friday2 != ""){
            star.add(0);
          } if(classes[i].friday1 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday3 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 3){
          if(classes[i].friday3 == ""){
            star.add(1);
          } else if(classes[i].friday3 != ""){
            star.add(0);
          } if(classes[i].friday2 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday4 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 4){
          if(classes[i].friday4 == ""){
            star.add(1);
          } else if(classes[i].friday4 != ""){
            star.add(0);
          } if(classes[i].friday3 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 5){
          if(classes[i].friday5 == ""){
            star.add(1);
          } else if(classes[i].friday5 != ""){
            star.add(0);
          } if(classes[i].friday4 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday6 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 6){
          if(classes[i].friday6 == ""){
            star.add(1);
          } else if(classes[i].friday6 != ""){
            star.add(0);
          } if(classes[i].friday5 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday7 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
      if(day[4] == false){
        if(classnum == 7){
          if(classes[i].friday7 == ""){
            star.add(1);
          } else if(classes[i].friday7 != ""){
            star.add(0);
          } if(classes[i].friday6 == "" && star[i] == 1){
            star[i] = 2;
          } if(classes[i].friday5 == "" && star[i] == 2){
            star[i] = 3;
          }
        }
      }
    }
    } catch(e){

    }
    print(star);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text('Exchange'.tr, style: TextStyle(color: Theme.of(context).colorScheme.shadow),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.shadow,),
          onPressed: () { 
            Navigator.pop(context, UserPage());
          },
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: classes.length ==0 ? Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  children: [
                    Text('Recommend'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 6,),
                    SizedBox(
                      height: 18,
                    ),
                    for(var i=0;i<classes.length;i++)
                      if(star[i]==3 && classes[i].lastname != "" && classes[i].name != classes[globals.userNumber].name)
                        cardWidget(classes[i].name, classes[i].lastname, star[i], day, classes[i].grade, classnum, classroom),
                    for(var i=0;i<classes.length;i++)
                      if(star[i]==2 && classes[i].lastname != "" && classes[i].name != classes[globals.userNumber].name)
                        cardWidget(classes[i].name, classes[i].lastname, star[i], day, classes[i].grade, classnum, classroom),
                    for(var i=0;i<classes.length;i++)
                      if(star[i]==1 && classes[i].lastname != "" && classes[i].name != classes[globals.userNumber].name)
                        cardWidget(classes[i].name, classes[i].lastname, star[i], day, classes[i].grade, classnum, classroom),
                    SizedBox(height: 16,),
                    Text('All'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 26,),
                    for(var i=0;i<classes.length;i++)
                      if(classes[i].lastname != "" && classes[i].name != classes[globals.userNumber].name)
                        cardWidget(classes[i].name, classes[i].lastname, 0, day, classes[i].grade, classnum, classroom),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
  Widget cardWidget(name, lastname, star, days, grade, classnum, classroom) {
    return Row(
        children: <Widget>[
        Expanded(
          child: Container(
            height: 100.0,
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              //color: Color(0xff2F50F3),
              color: Theme.of(context).colorScheme.primary,
              //border: Border(),
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
                  margin: EdgeInsets.only(left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                  color: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.0,
                      ),
                      Container(
                        height: 25.0,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${name}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            /*VerticalDivider(
                              color: Colors.black,
                            ),*/
                            Text(
                             "\t",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${lastname}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      if(star == 1)
                        Row(
                          children: [
                            Text("\t\t"),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            Icon(Icons.star_outline),
                            Icon(Icons.star_outline),
                            FittedBox(child: Text("\t ${grade}")),
                          ],
                        )
                      else if(star == 2)
                        Row(
                          children: [
                            Text("\t\t"),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            Icon(Icons.star_outline),
                            FittedBox(child: Text("\t ${grade}")),
                          ],
                        )
                      else if(star == 3)
                        Row(
                          children: [
                            Text("\t\t"),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            Icon(Icons.star , color: Colors.yellow[800],),
                            FittedBox(child: Text("\t ${grade}")),
                          ],
                        )
                      else if(star == 0)
                        Row(
                          children: [
                            FittedBox(child: Text("\t ${grade}"))
                          ],
                        ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: 60,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    //color: Color(0xFF187FD7),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50)
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      //_displayBottomSheet(context);
                      /*showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
                        builder: (context) => MyBottomSheet(),
                        routeSettings: RouteSettings(arguments: days)
                      );*/
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherclassexchangePage(),settings: RouteSettings(arguments: [days, name, classnum, classroom])),);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.navigate_next,color: Theme.of(context).colorScheme.scrim,
                        ),
                        Text('Select'.tr,style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.scrim),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /*Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.white,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
      builder: (context) => Container(
        height: 1000,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose a date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            select[0] = true;
                            select[1] = false;
                            select[2] = false;
                            select[3] = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          width: 200,
                          height: 60,
                          decoration: select[0]
                                  ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: select[0] ? Colors.amber :Colors.white
                          ) : null,
                          child: Center(child: Text('${0}',style: TextStyle(color: select[0] ? Colors.black : Colors.black54),),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
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
                            color: select[1] ? Colors.amber :Colors.white
                          ) : null,
                          child: Center(child: Text('${1}',style: TextStyle(color: select[1] ? Colors.black : Colors.black54),),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
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
                            color: select[2] ? Colors.amber :Colors.white
                          ) : null,
                          child: Center(child: Text('${2}',style: TextStyle(color: select[2] ? Colors.black : Colors.black54),),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
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
                            color: select[3] ? Colors.amber :Colors.white 
                          ) : null,
                          child: Center(child: Text('${3}',style: TextStyle(color: select[3] ? Colors.black : Colors.black54),),),
                        ),
                      ),
                    ],
                  ),
                  /*Wrap(
                    children: List.generate(4, (index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            select[index] == true;
                            print(select);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: select[index] ? Colors.amber :Colors.white
                          ),
                          child: Center(child: Text('${index}',style: TextStyle(color: select[index] ? Colors.black : Colors.black54),),),
                        ),
                      );
                    }),
                  ),*/
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Text(
                        "Confirm",
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
      )
    );
  }*/
}
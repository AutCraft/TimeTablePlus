import 'dart:async';
import 'dart:io';

import 'package:endproject/model/LocaleString.dart';
import 'package:endproject/page/settingPage.dart';
import 'package:endproject/page/userPage.dart';
import 'package:endproject/theme/dark_theme.dart';
import 'package:endproject/theme/light_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'globals.dart' as globals;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/classPage.dart';
import 'package:endproject/page/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await ClassSheetsApi.init();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  ErrorWidget.builder = (error) => AppErrorWidget(error: error);

  runApp(
    ProviderScope(
      child: GetMaterialApp(
        translations: LocalString(),
        locale: Locale('en','US'),
        debugShowCheckedModeBanner: false,
        home: globals.isLoggedIn ? UserPage() : HomePage(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        //ThemeData(
          //fontFamily: 'Roboto',
          //drawerTheme: const DrawerThemeData(scrimColor:  Colors.transparent),
        //),
      ),
    )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  List<ClassTeacher> classes = [];
  List<ClassNum> classess = [];
  List<ClassNum> classesss = [];

  @override
  void initState(){
    getConnectivity();
    
    super.initState();

    getClass();
    getAllClass();
    //getsomeClass();
  }

  getConnectivity() =>
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async { 
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if(!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancal');
            setState(() => isAlertSet = false);
            isDeviceConnected =
              await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          }, 
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  
  Future getClass() async {
    final classes = await ClassSheetsApi.getAlls();

    setState(() {
      this.classes = classes;
    });
    //print(classes[0].monday1[0]);
  }

  Future getAllClass() async {
    final classess = await ClassSheetsApi.getAll();

    setState(() {
      this.classess = classess;
    });
    //print(classess.length);
  }
  /*Future getsomeClass() async {
    final classesss = await ClassSheetsApi.getById(2);
    //print(classesss!.allclass);
  }*/

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
  //getConnectivity();
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          print(isExitWarning);

          return false;
        } else {
          Fluttertoast.cancel();
          print(isExitWarning);
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
        //backgroundColor: Color.fromRGBO(244, 243, 243, 1),
        /*appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black87,),
            onPressed: () {},
          ), systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),*/
        body: classess.length==0 ? Center(
          child: CircularProgressIndicator(),
        ): SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  //Color.fromRGBO(244, 243, 243, 1)
                  //height: MediaQuery.of(context).size.height-30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //elevation: 0 ,
                        width:  double.infinity,
                        //height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          //borderRadius: BorderRadius.vertical(top: Radius.circular(24))
                        ),
                        padding: EdgeInsets.only(top: 8,right: 5,left: 5),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _globalKey.currentState!.openDrawer();
                              }, 
                              icon: Icon(Icons.menu,color: Theme.of(context).colorScheme.shadow,),
                            ),
                          ]
                        ),
                      ),
                      Container(
                        width:  double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Find Your'.tr, style: TextStyle(fontSize: 23),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Teacher/Class'.tr, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 243, 243, 1),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search, color: Colors.black87,),
                                  hintText: "Search you're looking for".tr,
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                                ),
                                readOnly: true,
                                onTap: () {
                                  showSearch(
                                    context: context, 
                                    delegate: CustomSearch(classess),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('AllClass'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15,),
                              /*Container(
                                //width: double.infinity,
                                height: MediaQuery.of(context).size.height/1.7,
                                child: ListView(
                                  //scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    for(var i=0;i<classess.length;i++) 
                                      classCard('${classess[i].allclass}','${classess[i].colorBg}','${classess[i].colorText}'),
                                 ],
                                ),
                              ),*/
                            Column(
                              children: <Widget>[
                                    for(var i=0;i<classess.length;i++) 
                                      classCard('${classess[i].allclass}','${classess[i].colorBg}','${classess[i].colorText}'),
                                 ],
                            )
                            /*SizedBox(
                              height: double.infinity,
                              child: ListView.builder(
                                  //shrinkWrap: true,
                                  itemCount: classess.length,
                                  itemBuilder: (context, index) {
                                    return classCard('${classess[index].allclass}','${classess[index].colorBg}','${classess[index].colorText}');
                                  }
                                ),
                            ),*/
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        drawer: Drawer(
          width: 275,
          elevation: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
            //borderRadius: BorderRadius.horizontal(right: Radius.circular(40))
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              //borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
              /*boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow, spreadRadius: 30, blurRadius: 20
                ),
              ],*/
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 120),
              child: Column(
                children: [
                  /*Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _globalKey.currentState!.closeDrawer();
                        }, 
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black38, size: 20,),
                      ),
                      SizedBox(
                        width: 54,
                      ),
                      Text(
                        'Setting',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                  ),*/
                  DrawerItem(
                    title: 'Home'.tr, 
                    icon: Icons.home_outlined, 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  if( globals.isLoggedIn == true)
                    DrawerItem(
                      title: 'User'.tr, 
                      icon: Icons.person_outline, 
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                      },
                    ),
                  SizedBox(
                    height: 4,
                  ),
                  DrawerItem(
                    title: 'Setting'.tr, 
                    icon: Icons.settings_outlined, 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                    },
                  ),
                  //Spacer(),
                  Divider(
                    height: 45,
                    color: Colors.blueGrey,
                  ),
                  //Spacer(),
                  globals.isLoggedIn ? DrawerItem(
                    title: 'Logout'.tr, 
                    icon: Icons.logout_outlined, 
                    onTap: () {
                      globals.isLoggedIn = false;
                      globals.userNumber = null;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ): DrawerItem(
                    title: 'Login'.tr, 
                    icon: Icons.login_outlined, 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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

  Widget classCard(text,colorbg,colortext) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.4 / 1.4,
          child: Container(
            margin: EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
              color: Color(int.parse(colorbg)),
              borderRadius: BorderRadius.circular(20),
              /*image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('')
              )*/
              //border: Border.all(color: Colors.black38, width: 5)
            ),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      stops: [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(.7),
                        Colors.black.withOpacity(.05)
                      ]
                    )

                  /*image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(''),
                  )*/
                  ),
                  child: Center(
                    child: Text(text, style: TextStyle(color: Color(int.parse(colortext)),fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassPage(), settings: RouteSettings(arguments: text)));
              },
            ),
          )
        ),
        SizedBox(
          height: 16,
        )
      ],
      
    );
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
        padding: const EdgeInsets.only(bottom: 18.0, top: 18.0, left: 8, right: 8),
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

class CustomSearch extends SearchDelegate {
  List<String> allData = [];
  List<ClassNum> classess;

  CustomSearch(this.classess) {
    for (var i = 0;i<classess.length; i++) {
      allData.add(classess[i].allclass);
    }
  }
  //print(classess);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back),
    );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          child: ListTile(
            
            title: Text(result),
          ),
          onTap: () {
            close(context, null);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassPage(), settings: RouteSettings(arguments: result)));
          },
        );
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    /*for (var i = 0;i<classess.length; i++) {
      allData.add(classess[i].allclass);
    }*/
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          child: ListTile(
            title: Text(result),
          ),
          onTap: () {
            close(context, null);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassPage(), settings: RouteSettings(arguments: result)));
          },
        );
      }
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  late final FlutterErrorDetails error;

  AppErrorWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFFAFAFA),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Icon(Icons.error_outline_sharp,color: Colors.red,size: 150,),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              child: Text(
                'Something wrong'.tr,
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Center(
                  child: Text(
                    error.exceptionAsString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
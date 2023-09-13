import 'dart:io';

import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/main.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/loginPage.dart';
import 'package:endproject/page/userPage.dart';
import 'package:endproject/theme/dark_theme.dart';
import 'package:endproject/theme/light_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:endproject/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  late TextEditingController newpasswordController;
  late TextEditingController confirmpasswordController;
  List<Users> user = [];

  @override
  void initState() {
    newpasswordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    getUsers();
    super.initState();
  }

  Future getUsers() async {
    final user = await ClassSheetsApi.getUser();

    setState(() {
      this.user = user;
    });
  }

  void submit() {
    if(newpasswordController.text!='' && confirmpasswordController.text!=''){
      if(newpasswordController.text!='' || confirmpasswordController.text!=''){
        if(newpasswordController.text == confirmpasswordController.text){
          ClassSheetsApi.updateCell(
            id: globals.userNumber+1,
            key: 'Password', 
            value: newpasswordController.text
          );
          ScaffoldMessenger.of(context).showSnackBar(
            Completeinform(),
          );
        }
      }
    }
    newpasswordController.clear();
    confirmpasswordController.clear();
    Navigator.of(context).pop();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          title: Text(
            'setting'.tr,
            style: TextStyle(color: Theme.of(context).colorScheme.shadow),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.shadow,
            ),
            onPressed: () {
              _globalKey.currentState!.openDrawer();
            },
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
              if (globals.isLoggedIn == true)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Account".tr,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Change Password".tr),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: newpasswordController,
                                            obscureText: true,
                                            autofocus: true,
                                            decoration: InputDecoration(hintText: 'Enter New Password'.tr),
                                          )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: confirmpasswordController,
                                            obscureText: true,
                                            autofocus: true,
                                            decoration: InputDecoration(hintText: 'Confirm Password'.tr),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(onPressed: submit, child: Text('SUBMIT'.tr)),
                                  ],
                                ));
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Change Password".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    //fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.tertiary)),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "General".tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Dark Mode".tr,
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary)),
                    CupertinoSwitch(
                      activeColor: Colors.black,
                      trackColor: Colors.grey,
                      value: globals.darkmode,
                      onChanged: (newValue) {
                        setState(() {
                          globals.darkmode = newValue;
                          if(globals.darkmode == false){
                            Get.changeTheme(lightTheme);
                          } else if(globals.darkmode == true) {
                            Get.changeTheme(darkTheme);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Language".tr),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            content: Container(
                              width: double.maxFinite,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        var locale = Locale('en', 'US');
                                        Get.updateLocale(locale);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'English',
                                        style: TextStyle(color: Theme.of(context).colorScheme.shadow),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Theme.of(context).colorScheme.tertiary),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        var locale = Locale('th', 'TH');
                                        Get.updateLocale(locale);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'ไทย',
                                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      var locale = Locale('en','US');
                                      Get.updateLocale(locale);
                                    }, child: Text("English")),
                                TextButton(
                                    onPressed: () {
                                      var locale = Locale('th','TH');
                                      Get.updateLocale(locale);
                                    }, child: Text("ไทย")),
                              ],
                            ),*/
                          ));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Language".tr,
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            ],
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
              //boxShadow: [
              //  BoxShadow(
              //      color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20),
              //],
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
                  globals.isLoggedIn
                      ? DrawerItem(
                          title: 'Logout'.tr,
                          icon: Icons.logout_outlined,
                          onTap: () {
                            globals.isLoggedIn = false;
                            globals.userNumber = null;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        )
                      : DrawerItem(
                          title: 'Login'.tr,
                          icon: Icons.login_outlined,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
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
  SnackBar Completeinform() {
    return SnackBar(
      content: Container(
        padding: EdgeInsets.all(16),
        height: 75,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            Text(
              "The Password change is complete".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
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

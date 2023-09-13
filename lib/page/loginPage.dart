import 'dart:io';
import 'dart:async';

import 'package:endproject/api/sheets/class_sheets_api.dart';
import 'package:endproject/main.dart';
import 'package:endproject/model/class.dart';
import 'package:endproject/page/settingPage.dart';
import 'package:endproject/page/userPage.dart';
import 'package:flutter/material.dart';
import 'package:endproject/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  List<Users> user = [];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  @override
  void initState(){
    super.initState();

    getUsers();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  Future getUsers() async {
    final user = await ClassSheetsApi.getUser();

    setState(() {
      this.user = user;
    });
    //print(classess.length);
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

        if(isExitWarning) {
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
        body: SafeArea(
          child: globals.userNumber != null ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('You must logout before you can login again.'.tr, style: TextStyle(fontSize: 18),)), 
            SizedBox(height: 18,),
            IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> UserPage()));}, icon: Icon(Icons.arrow_back_ios)),
          ],
        ) : user.length==0 ? Center(
          child: CircularProgressIndicator(),
        ): SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:  double.infinity,
                  padding: EdgeInsets.only(top: 8,right: 5,left: 5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _globalKey.currentState!.openDrawer();
                        }, 
                        icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.shadow,),
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'assets/logo.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 150, 150, 150),
                          blurRadius: 10,
                          blurStyle: BlurStyle.solid,
                        )
                      ]
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail_rounded, color: Theme.of(context).colorScheme.shadow,),
                        hintText: "Email".tr,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 150, 150, 150),
                          blurRadius: 10,
                          blurStyle: BlurStyle.solid,
                        )
                      ]
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.key_rounded, color: Theme.of(context).colorScheme.shadow,),
                        hintText: "Password".tr,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle ? Icons.visibility : Icons.visibility_off, color: Theme.of(context).colorScheme.scrim,),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: const Color(0xFF323232),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    bool CheckUser = false;
                    if(emailController.text!='' && passwordController.text!=''){
                      if(emailController.text!='' || passwordController.text!=''){
                        for(var i=0;i<user.length;i++){
                          if(emailController.text == user[i].email && passwordController.text == user[i].password) {
                            CheckUser = true;
                            globals.isLoggedIn = true;
                            print("CheckUser");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UserPage(), settings: RouteSettings(arguments: i)));
                          }
                        }
                        if(CheckUser == false){
                          ScaffoldMessenger.of(context).showSnackBar(
                            Checkuser(),
                          );
                        }
                        CheckUser == false;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Checkinform(),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        Checkinform(),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Text(
                      "login".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login to the system for ".tr,
                      style: TextStyle(
                        color: Color(0xFF969696),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Teachers only".tr,
                      style: TextStyle(
                        color: Color.fromARGB(255, 168, 62, 62),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                        color: Color(0xFF969696),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          width: 275,
          elevation: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              //boxShadow: [
              //  BoxShadow(
              //    color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20
              //  ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  SizedBox(
                    height: 8,
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
                  DrawerItem(
                    title: 'Login'.tr, 
                    icon: Icons.login_outlined, 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SnackBar Checkinform() {
    return SnackBar(
      content: Container(
        padding: EdgeInsets.all(16),
        height: 75,
        decoration: BoxDecoration(
          color: Color(0xFFC72C41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.error_rounded,
              color: Colors.white,
            ),
            Text(
              "Please enter your email and password".tr,
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

  SnackBar Checkuser() {
    return SnackBar(
      content: Container(
        padding: EdgeInsets.all(16),
        height: 75,
        decoration: BoxDecoration(
          color: Color(0xFFC72C41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.error_rounded,
              color: Colors.white,
            ),
            Text(
              "Please check your email or password".tr,
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
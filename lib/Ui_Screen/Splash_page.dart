import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Ui_Screen/My_Ui_Page.dart';
import 'package:todo_full_app/onboarding/Login_page.dart';

class Splash_screen extends StatefulWidget {
  //const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var uid = pref.getString("uid");
      if (uid != null && uid.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return My_Ui_Page(id: uid!);
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue.shade500,
        child: Icon(
          Icons.check,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}

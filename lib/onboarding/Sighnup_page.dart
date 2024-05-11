import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_full_app/onboarding/Login_page.dart';

import '../Costum_widget/costum_widget.dart';

class Sighn_page extends StatelessWidget {
//  const LoginPage({super.key});
  var emailControler = TextEditingController();
  var passControler = TextEditingController();
  var nameControler = TextEditingController();
  var mFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: mFormKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "Create Account!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    "assets/images/loginUi1.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 12,
                          spreadRadius: 4,
                          offset: Offset(0, 5))
                    ]),
                    child: MyTextFeild(
                      validater: (value) {
                        if (value!.length <= 7) {
                          return "please fill correct name";
                        }
                      },
                      myIcon: Icon(Icons.person),
                      hintText: "enter your name",
                      content: "name",
                      controller: nameControler,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 12,
                          spreadRadius: 4,
                          offset: Offset(0, 5))
                    ]),
                    child: MyTextFeild(
                      validater: (value) {
                        const pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                            r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        final regxp = RegExp(pattern);
                        if (value!.isEmpty) {
                          return "email not exist";
                        } else if (regxp.hasMatch(value)) {
                          return "please enter correct email";
                        }
                      },
                      hintText: "enter your gmail",
                      content: "gmail",
                      controller: emailControler,
                      myIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 12,
                          spreadRadius: 4,
                          offset: Offset(0, 5))
                    ]),
                    child: MyTextFeild(
                      validater: (value) {
                        if (value!.length <= 7) {
                          return "please enter correct password";
                        }
                      },
                      myIcon: Icon(Icons.key),
                      suffIcon: Icon(Icons.remove_red_eye),
                      hintText: "enter your pass",
                      content: "pass",
                      controller: passControler,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue, onPrimary: Colors.white),
                        onPressed: () async {
                          if (mFormKey.currentState!.validate()) {
                            mFormKey.currentState!.save();
                            try {
                              var auth = FirebaseAuth.instance;
                              var firestore = FirebaseFirestore.instance;
                              var userCred =
                                  await auth.createUserWithEmailAndPassword(
                                      email: emailControler.text.toString(),
                                      password: passControler.text.toString());
                              var uuid = userCred.user!.uid;
                              var creatAt =
                                  DateTime.now().millisecondsSinceEpoch;
                              firestore.collection("users").doc(uuid).set({
                                "name": nameControler.text.toString(),
                                "email": emailControler.text.toString(),
                                "time": creatAt,
                              });
                              Navigator.pop(context);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "The password provided is too weak")));
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "The account already exists for that email")));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${e}")));
                            }
                          }
                        },
                        child: Text("Sighn up"))),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("already have account? "),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                          child: Text(
                            "login now!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

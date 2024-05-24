import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Costum_widget/add_update_func.dart';
import 'package:todo_full_app/Costum_widget/costum_widget.dart';
import 'package:todo_full_app/Model.dart';
import 'package:todo_full_app/StateManagement/Todo_bloc.dart';
import 'package:todo_full_app/StateManagement/Todo_event.dart';
import 'package:todo_full_app/Ui_Screen/Ui_page_not_using_bloc.dart';

class Nextpage extends StatefulWidget {
  @override
  State<Nextpage> createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage> {
  String? Myid;
  My_page data = My_page();

  //const Nextpage({super.key});
  var titleControler = TextEditingController();

  var subControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff157180),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Enter Your Data Here",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Secondtextfeild(
                    hintText: "enter your title",
                    content: "title",
                    controller: titleControler),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Secondtextfeild(
                    hintText: "enter your subtitle",
                    content: "subtitle",
                    controller: subControler),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (titleControler.text.isNotEmpty &&
                        subControler.text.isNotEmpty) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(pref.getString("uid"))
                          .collection("notes")
                          .add({
                        "title": titleControler.text.toString(),
                        "subtitle": subControler.text.toString(),
                        "time": DateTime.now().millisecondsSinceEpoch,
                      }).then((value) {
                        print("value added");
                        setState(() {});
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("enter value")));
                    }
                  },
                  child: SizedBox(
                    width: 150,
                    child: Center(
                        child: Text(
                      "add",
                      style: TextStyle(
                          color: Color(0xff157180),
                          fontWeight: FontWeight.bold),
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

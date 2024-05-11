import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Model.dart';
import 'package:todo_full_app/StateManagement/Todo_bloc.dart';
import 'package:todo_full_app/StateManagement/Todo_event.dart';
import 'package:todo_full_app/StateManagement/Todo_state.dart';
import 'package:todo_full_app/Ui_Screen/next_page.dart';
import 'package:todo_full_app/onboarding/Login_page.dart';

class My_Ui_Page extends StatefulWidget {
  @override
  State<My_Ui_Page> createState() => _My_Ui_PageState();
  String id;
  My_Ui_Page({required this.id});
}

class _My_Ui_PageState extends State<My_Ui_Page> {
  String? userId;

  List<Map<String, dynamic>> listData = [];
  // Future<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
  //     FirebaseFirestore.instance.collection("collectionPath").doc().get();
  // My_Ui_Page({super.key});
  var fire = FirebaseFirestore.instance;

  Future<String> getDoucmentId() async {
    String documentId = await FirebaseFirestore.instance
        .collection("collectionPath")
        .doc()
        .get()
        .toString();
    return documentId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(FetchData(userId: widget.id));
    String id = getDoucmentId().toString();
    log(id.toString());
    // fire.collection("notes").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: TextButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("uid");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            child: Text("Logout")),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedState) {
          return ListView.builder(
              itemCount: state.mdata.length,
              itemBuilder: (context, index) {
                var data = state.mdata;

                return Card(
                  color: Colors.blue.shade300,
                  child: ListTile(
                    title: Text(data[index].title!),
                    subtitle: Text(data[index].subtitle!),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                          // IconButton(
                          //     onPressed: () {
                          //       BlocProvider.of<TodoBloc>(context).add(
                          //           DeleteData(
                          //               userId: widget.id,
                          //               uid: documentSnapshot.toString()));
                          //     },
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: Colors.black,
                          //     ))
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Nextpage();
          }));
        },
        child: Icon(Icons.check),
      ),
    );
  }

  /* addData({required Model newModel}) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    var id = widget.id;
    var firestore = fire.collection("users").doc(id).collection("notes");
    firestore.add(newModel.toMap()).then((value) {
      print("value added");
      setState(() {});
    });
  }

  */
}

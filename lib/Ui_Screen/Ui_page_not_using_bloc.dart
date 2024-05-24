import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Ui_Screen/next_page.dart';

import '../Model.dart';
import '../onboarding/Login_page.dart';

class My_page extends StatefulWidget {
  String? docid;

  @override
  State<My_page> createState() => _My_pageState();
}

class _My_pageState extends State<My_page> {
  String? loginid;
  var titleControler = TextEditingController();
  var subControler = TextEditingController();

  late FirebaseFirestore fire;

  @override
  void initState() {
    super.initState();
    fire = FirebaseFirestore.instance;
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note_APP"),
        backgroundColor: Color(0xff157180),
      ),
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
              child: Text("Log Out!"))),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: fire
              .collection("users")
              .doc(loginid)
              .collection("notes")
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              var mdata = snapshot.data!.docs;
              if (mdata.isEmpty) {
                return Center(
                    child: Lottie.asset("assets/animation/waiting_animation"));
              } else {
                return ListView.builder(
                  itemCount: mdata.length,
                  itemBuilder: (context, index) {
                    Model currNote = Model.fromMap(mdata[index].data());

                    var currData = mdata[index].data();
                    widget.docid = mdata[index].id;
                    return Card(
                      color: Color(0xff157180),
                      child: ListTile(
                        title: Text(currData["title"]),
                        subtitle: Text(currData["subtitle"]),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _editNoteDialog(widget.docid!,
                                      currNote.title!, currNote.subtitle!);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black87,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Delete!"),
                                          content:
                                              Text("do you want to delete?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  SharedPreferences pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  fire
                                                      .collection("users")
                                                      .doc(
                                                          pref.getString("uid"))
                                                      .collection("notes")
                                                      .doc(widget.docid)
                                                      .delete()
                                                      .then((value) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Note deleted")),
                                                    );
                                                  }).catchError((error) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Failed to delete note")),
                                                    );
                                                    print(
                                                        "Failed to delete note: $error");
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text("yes")),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No!")),
                                          ],
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Nextpage();
          }));
        },
        child: Icon(
          Icons.add,
          color: Color(0xff157180),
        ),
      ),
    );
  }

  Future<void> getid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginid = pref.getString("uid");
    setState(() {}); // Trigger rebuild after getting the login id
  }

  Future<void> _editNoteDialog(
      String docId, String currentTitle, String currentSubtitle) async {
    TextEditingController titleController =
        TextEditingController(text: currentTitle);
    TextEditingController subtitleController =
        TextEditingController(text: currentSubtitle);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title')),
              TextField(
                  controller: subtitleController,
                  decoration: InputDecoration(labelText: 'Subtitle')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Save"),
              onPressed: () async {
                await _saveEditedNote(
                    docId, titleController.text, subtitleController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveEditedNote(
      String docId, String newTitle, String newSubtitle) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(loginid)
        .collection("notes")
        .doc(docId)
        .update({
      "title": newTitle,
      "subtitle": newSubtitle,
      "time": DateTime.now().millisecondsSinceEpoch,
    });
  }
}

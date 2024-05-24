import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Ui_Screen/Ui_page_not_using_bloc.dart';

void Curd_Data(
    {String title = " ", String subtitle = " ", bool isEdit = false}) async {
  My_page data = My_page();
  var titleControler = TextEditingController();
  var subControler = TextEditingController();
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (titleControler.text.isNotEmpty && subControler.text.isNotEmpty) {
    if (isEdit == true) {
      title = titleControler.text.toString();
      subtitle = subControler.text.toString();
      FirebaseFirestore.instance
          .collection("users")
          .doc(pref.getString("uid"))
          .collection("notes")
          .doc(data.docid)
          .update({
        "title": titleControler.text.toString(),
        "subtitle": subControler.text.toString(),
      }).then((value) {
        print("data print");
      });
    } else {
      title = "";
      subtitle = "";
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
      });
    }
  }
}

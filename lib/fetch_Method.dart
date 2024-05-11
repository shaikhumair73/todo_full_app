import 'package:cloud_firestore/cloud_firestore.dart';

import 'Model.dart';

Future<List<Model>> fetchNotes(String userId) async {
  List<Model> Notes = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(userId)
        .collection("notes")
        .get();
    querySnapshot.docs.forEach((doc) {
      Model note = Model.fromMap(doc.data());
      Notes.add(note);
    });
  } catch (e) {
    print("error is $e");
  }
  return Notes;
}

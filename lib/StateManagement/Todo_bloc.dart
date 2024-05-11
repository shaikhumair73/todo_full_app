import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/StateManagement/Todo_event.dart';
import 'package:todo_full_app/StateManagement/Todo_state.dart';
import 'package:todo_full_app/Ui_Screen/My_Ui_Page.dart';
import 'package:todo_full_app/fetch_Method.dart';

import '../Model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  FirebaseFirestore fire = FirebaseFirestore.instance;

  TodoBloc() : super(InitialState()) {
    on<AddData>((event, emit) async {
      try {
        emit(LoadingState());
        var firestore =
            fire.collection("users").doc(event.userId).collection("notes");
        await firestore.add(event.MyModel.toMap()).then((value) {
          print("value added");
          // setState(() {});
        });
        List<Model> note = await fetchNotes(event.userId);
        emit(LoadedState(mdata: note));
      } catch (e) {
        emit(ErrorState(errorMsg: "${e}"));
      }
    });
    on<FetchData>((event, emit) async {
      try {
        emit(LoadingState());
        List<Model> note = await fetchNotes(event.userId);
        emit(LoadedState(mdata: note));
      } catch (e) {
        emit(ErrorState(errorMsg: "${e}"));
      }
    });
    on<DeleteData>((event, emit) async {
      emit(LoadingState());
      var firestore = fire
          .collection("users")
          .doc(event.userId)
          .collection("notes")
          .doc(event.uid)
          .delete();
      List<Model> note = await fetchNotes(event.userId);
      emit(LoadedState(mdata: note));
    });
  }
}

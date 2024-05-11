import 'package:todo_full_app/Model.dart';

class TodoEvent {}

class AddData extends TodoEvent {
  Model MyModel;
  String userId;
  AddData({required this.MyModel, required this.userId});
}

class FetchData extends TodoEvent {
  String userId;
  FetchData({required this.userId});
}

class DeleteData extends TodoEvent {
  String userId;
  String uid;
  DeleteData({required this.userId, required this.uid});
}

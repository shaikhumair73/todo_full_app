import '../Model.dart';

class TodoState {}

class InitialState extends TodoState {}

class LoadingState extends TodoState {}

class LoadedState extends TodoState {
  List<Model> mdata;
  LoadedState({required this.mdata});
}

class ErrorState extends TodoState {
  String errorMsg;
  ErrorState({required this.errorMsg});
}

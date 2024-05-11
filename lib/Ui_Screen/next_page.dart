import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_full_app/Costum_widget/costum_widget.dart';
import 'package:todo_full_app/Model.dart';
import 'package:todo_full_app/StateManagement/Todo_bloc.dart';
import 'package:todo_full_app/StateManagement/Todo_event.dart';

class Nextpage extends StatelessWidget {
  //const Nextpage({super.key});
  var titleControler = TextEditingController();
  var subControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
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
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    BlocProvider.of<TodoBloc>(context).add(AddData(
                      MyModel: Model(
                          title: titleControler.text.toString(),
                          subtitle: subControler.text.toString()),
                      userId: pref.getString("uid")!,
                    ));
                    Navigator.pop(context);
                  },
                  child: Text("add"))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_full_app/StateManagement/Todo_bloc.dart';
import 'package:todo_full_app/Ui_Screen/My_Ui_Page.dart';
import 'package:todo_full_app/Ui_Screen/Splash_page.dart';
import 'package:todo_full_app/onboarding/Login_page.dart';
import 'package:todo_full_app/onboarding/Sighnup_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlocProvider(create: (context) => TodoBloc(), child: (const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

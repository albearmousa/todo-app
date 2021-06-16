import 'package:dio_and_json/screen/list_user_screen.dart';
import 'package:dio_and_json/screen/todo_add.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home' : (context) => ListUserScreen(),
        'sec' : (context) => TodoAdd(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:ListUserScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}


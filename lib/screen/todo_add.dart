import 'dart:async';

import 'package:dio_and_json/model/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoAdd extends StatefulWidget {
  static const routeName = 'sec';

  TodoAdd({Key key}) : super(key: key);

  @override
  _TodoAddState createState() => _TodoAddState();
}

StreamController<User> events = StreamController<User>();

class _TodoAddState extends State<TodoAdd> {
  List<User> users = [];

  var controller = TextEditingController();
  var controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller1 = TextEditingController();
    events.stream.listen((data) {
      users.add(data);
      setState(() {});
    });
  }

  void setText() {
    setState(() {
      controller.text;
      controller1.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Add'),
        centerTitle: true,
      ),
      body: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Enter your title"),
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller1,
                    decoration: InputDecoration(hintText: 'Enter your body'),
                    onChanged: (val) {},
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setText();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Title : ${controller.text}"),
                              content: Text("Body : ${controller1.text}"),
                              actions: [
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            );
                          });
                    },
                    child: Text("Submit"),
                  ),
                  Text(
                    'Title : ${controller.text}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Body : ${controller1.text}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:dio_and_json/model/list_user_response.dart';
import 'package:dio_and_json/model/user.dart';
import 'package:flutter/material.dart';

import '../http_service.dart';

class ListUserScreen extends StatefulWidget {
  static const routeName = 'home';
 static List<User> users = [];
 static User user = User();

  ListUserScreen({Key key}) : super(key: key);

  @override
  _ListUserScreenState createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  Dio dio = Dio();

  bool isLoading = false;

  HttpService http;

  ListUserResponse listUserResponse;

  static List<User> users;

  String get cont => cont;
  String get con1 => con1;


  // Future postData() async {
  //   final String pathUrl = 'https://reqres.in/api/users';
  //   dynamic data = {
  //     'name': 'Albear Mousa',
  //     'job': 'leader',
  //     'email': 'albearmosa@gmail.com'
  //   };
  //   var response = await dio.post(pathUrl,
  //       data: data,
  //       options: Options(headers: {
  //         'content-type': 'application/json; charset-UTF-8',
  //       }));
  //   return response.data;
  // }

  // Future putData() async {
  //   final String pathUrl = 'https://reqres.in/api/users';
  //   dynamic data = {'name': 'Albear ', 'job': 'Developer'};
  //   var response = await dio.put(pathUrl,
  //       data: data,
  //       options: Options(headers: {
  //         'content-type': 'application/json; charset-UTF-8',
  //       }));
  //   return response.data;
  // }

  Future getListUser() async {
    Response response;
    try {
      isLoading = true;

      response = await http.getRequest("/api/users?page=2");

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          listUserResponse = ListUserResponse.fromJson(response.data);
          users = listUserResponse.users;
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();

    getListUser();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single user"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users != null
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'sec');
                          },
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Dismissible(
                              key: ValueKey(users),
                              background: Container(
                                color: Colors.green,
                              ),
                              child: ListTile(
                                title:
                                    Text('${user.firstName} ${user.lastName}'),
                                leading: Image.network(user.avatar),
                                subtitle: Text(user.email),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: users.length,
                )
              : Center(
                  child: Text("No User Object"),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'sec');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

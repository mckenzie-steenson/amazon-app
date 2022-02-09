import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Include in setup
class User {
  final bool success;

  User({
    required this.success,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['res'],
    );
  }
}

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Include in setup
  TextEditingController idController = TextEditingController();

  String id = "";

  String _idString = 'Your user will appear here if it exists! ';

  bool isVisible = false;

  // Include in setup -- show how the http request looks in FastAPI
  // and then show how the url should look in the code
  Future<User> _userExists() async {
    final url = 'http://127.0.0.1:8000/userExists?user=$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User Page")),
        // Include in setup - adding to the User page
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: [
              // Include in setup -- UserExists Query
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'User Search',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 150, right: 150, bottom: 10),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User ID',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    child: Text('Search'),
                    onPressed: () {
                      print(idController.text);
                      setState(() {
                        id = idController.text;
                      });

                      _userExists().then((result) {
                        if (result.success) {
                          print("SUCCESS");
                          setState(() {
                            _idString = idController.text;
                          });
                        } else {
                          setState(() {
                            isVisible = true;
                            _idString =
                                "The user you searched does not exist! Oops!";
                          });
                        }
                      });
                    },
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: Column(children: [
                    Text(
                      "User Name: " + _idString,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ])
                  //

                  ),
            ])));
  }
}

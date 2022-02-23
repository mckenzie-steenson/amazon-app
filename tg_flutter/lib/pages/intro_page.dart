import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String imagePath = "test/AVph0EeEilAPnD_x9myq.jpeg";
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Intro Page")),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Image.network(
                  'https://media2.giphy.com/media/dv7LVj1t6e1wobkYgX/giphy.gif?cid=ecf05e47zs97ng6h05arjp3l73ti4g0wyqr191cgy19bqoa4&rid=giphy.gif&ct=g',
                  width: 300,
                  height: 400,
                  fit: BoxFit.contain,
                ),
                // Added For Firebase Storage
              ],
            )));
  }
}

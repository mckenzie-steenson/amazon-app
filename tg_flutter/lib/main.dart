import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tg_flutter/pages/home_page.dart';

Future<void> main() async {
  // Added for Firebase Implementation
  // initializes firebase when the app is run
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

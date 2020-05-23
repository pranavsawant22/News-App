import 'package:flutter/material.dart';
import 'package:newsapp/views/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool flag = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),

    );
  }
}


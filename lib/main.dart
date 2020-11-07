import 'package:app_delivery/screens/home.dart';
import 'package:app_delivery/utility/my_style.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: MyStyle().primaryColor),
      debugShowCheckedModeBanner: false,
      title: 'Delivery',
      home: Home(),
    );
  }
}

import 'package:flutter/material.dart';

class MyStyle {
  Color dartColor = Colors.green[700];
  Color primaryColor = Colors.red[700];

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.green[700],
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.green[700],
  );

  BoxDecoration myBoxDecoration(String namePic) => BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$namePic'),
          fit: BoxFit.cover,
        ),
      );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
      ),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: dartColor,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: dartColor,
          fontWeight: FontWeight.bold,
        ),
      );

  Container showLogo() => Container(
        width: 120.0,
        child: Image.asset('assets/images/logo.png'),
      );

  MyStyle();
}

import 'dart:convert';

import 'package:app_delivery/models/user_model.dart';
import 'package:app_delivery/screens/main_rider.dart';
import 'package:app_delivery/screens/main_shop.dart';
import 'package:app_delivery/screens/main_user.dart';
import 'package:app_delivery/utility/my_style.dart';
import 'package:app_delivery/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//field
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.5),
            radius: 2.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyStyle().showLogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('Delivery'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        'http://192.168.56.1/flutter/app_delivery/php/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          if (chooseType == 'User') {
            routeToServices(MainUser(), userModel);
          } else if (chooseType == 'Shop') {
            routeToServices(MainShop(), userModel);
          } else if (chooseType == 'Rider') {
            routeToServices(MainRider(), userModel);
          } else {
            normalDialog(context, 'ກະລຸນາລອງໃໝ່ອີກຄັ້ງ');
          }
        } else {
          normalDialog(context, 'Password fail!');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToServices(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.iD);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().dartColor,
            ),
            labelStyle: TextStyle(color: MyStyle().dartColor),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700])),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().dartColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().dartColor,
            ),
            labelStyle: TextStyle(color: MyStyle().dartColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700])),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().dartColor)),
          ),
        ),
      );
}

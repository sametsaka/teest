import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teest/db/dbHelper.dart';
import 'package:teest/models/user.dart';
import 'package:teest/screens/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hesap',
                    style: TextStyle(color: Colors.green, fontSize: 65.0),
                  ),
                  Text(
                    'Cüzdanı',
                    style: TextStyle(color: Colors.white, fontSize: 65.0),
                  ),
                  TextFormField(
                    controller: loginInput,
                    decoration: new InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: passwordInput,
                    decoration: new InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent)),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                  SizedBox(
                    width: 400.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        var dbHelper = new DbHelper();
                        Future<UserModel> usermodel = dbHelper.getUser(loginInput.text.toString(),
                            passwordInput.text.toString());
                        usermodel.then((onValue){
                          if(onValue != null)
                            print(onValue.ID);
                          else
                            print("Kayıt yok!");

                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _widget() {
    AlertDialog dialog =
        new AlertDialog(title: Text('testasdadas'), content: Text('1231312'));
    showDialog(context: context, child: dialog);
  }
}

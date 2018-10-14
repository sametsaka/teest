import 'package:flutter/material.dart';
import 'package:teest/db/dbHelper.dart';
import 'package:teest/models/user.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final format = new DateFormat('yyyy-MM-dd hh:mm');
  

  TextEditingController loginInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      onPressed: _register,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    var userModel = new UserModel(EMAIL: null, PASSWORD: null);
    userModel.EMAIL = loginInput.text.toString();
    userModel.PASSWORD = passwordInput.text.toString();
    userModel.RECORD_DATE =format.format(new DateTime.now().toLocal());
    var dbHelper = new DbHelper();
    dbHelper.insertNewUser(userModel);
    print('Başarılı');
  }
}

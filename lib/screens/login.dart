import 'dart:io';

import 'package:daily_activity/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  String _resultText = "Tekan FAB untuk melakukan autentikasi";
  Color _resultColor = Colors.black;
  final LocalAuthentication auth = LocalAuthentication();

  ProgressDialog pr;

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  String msg = '';
  bool _showPassword = false;

  void _togglevisibility(){
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<List> login() async {
    var url = "http://192.168.1.243/rest_flutter/index.php/Login";
    final response = await http.post(url, body: {
      "param":"login",
      "username":username.text,
      "password":password.text
    });
    var dataUser = json.decode(response.body);
    if(dataUser.length!=0){
      String status = dataUser['status'];
      if(status=='fail'){
        setState(() {
          msg = dataUser['error_msg'];
        });
      }else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', dataUser['username']);
        prefs.setString('islogin', 'yes');
        prefs.setString('status', dataUser['status_user']);
        prefs.setString('vip', dataUser['vip']);
        Navigator.pushReplacementNamed(context, '/Homepage');
      }

      print(msg);
    }
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black12,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 100.0, left: 35.0, right: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50.0),),
                Image.asset('images/logodaily.png', width: 90.0,),
                Padding(padding: EdgeInsets.only(bottom: 50.0),),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      labelText: 'Username',
                      border: OutlineInputBorder()
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0),),
                TextFormField(
                  controller: password,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          _togglevisibility();
                        },
                        child: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.pinkAccent,
                        ),
                      )
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0),),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?", style: TextStyle(color: Colors.pinkAccent, fontSize: 11.0),),
                ),
                Padding(padding: EdgeInsets.only(top: 22.0),),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    child: Text("Login", style: TextStyle(color: Colors.white),),
                    color: Colors.pink,
                    onPressed: (){
                      if(username.text == ""){
                        setState(() {
                          msg = "Username harus din isi.";
                        });
                      }else if(password.text == ""){
                        setState(() {
                          msg = "Password harus di isi.";
                        });
                      }else{
                        pr.show();
                        Future.delayed(Duration(seconds: 3)).then((value){
                          pr.hide().whenComplete((){
                            login();
                          });
                        });
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0),),
                Text(msg, style: TextStyle(fontSize: 11.0, color: Colors.red),),
                Padding(padding: EdgeInsets.only(top: 20.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have account?", style: TextStyle(fontSize: 11.0),),
                    FlatButton(
                      onPressed: (){},
                      child: Text("contact admin to create account", style: TextStyle(color: Colors.blue, fontSize: 11.0),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _auth,
        tooltip: 'Authentication',
        backgroundColor: Colors.pink,
        child: Icon(Icons.fingerprint),
      ),
    );
  }

  void _auth() async {
    List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        print("Face");
        _startBioMetricAuth("Gunakan Face ID untuk melakukan autentikasi.");
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        print("Finger");
        _startBioMetricAuth("Gunakan Touch ID untuk melakukan autentikasi.");
      }
    } else {
      _startBioMetricAuth("Gunakan Fingerprint untuk melakukan autentikasi.");
    }
  }

  Future<void> _startBioMetricAuth(String message) async {
    try {
      bool didAuthenticate =
          await auth.authenticateWithBiometrics(localizedReason: message);
      if (didAuthenticate) {
        setState(() {
          _resultColor = Colors.green;
          _resultText = "Autentikasi berhasil.";
          Navigator.pushReplacementNamed(context, '/Homepage');
        });
      } else {
        setState(() {
          _resultColor = Colors.red;
          _resultText = "Autentikasi gagal.";
        });
      }
    } on PlatformException catch (e) {
      // if (e.code == auth_error.notAvailable) {
      //   print("Error!");
      // }
    }
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, gass);
  }

  void gass() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return Login();
    }));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return(
        new Scaffold(
          backgroundColor: Colors.orange,
          body: new Center(
              child: new Image.asset("images/nanas.png", width: 300)
          ),
        )
    );
  }
}
class Login extends StatefulWidget{
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{
  @override
  final userText = TextEditingController();
  final passwordText = TextEditingController();

  void login() async {
    String email = userText.value.text;
    String password = passwordText.value.text;
    final response = await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
    headers: <String, String> {
      'Content-Type': 'application/json'
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }));

    Map<String, dynamic> data = jsonDecode(response.body);
    if(data["access_token"] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data["access_token"]);
      prefs.setInt("user_id", data["user"]["id"]);
      prefs.setString("user_name", data["user"]["name"]);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
        return Home();
      }), (Route<dynamic> route) => false);
    } else {
      return print("GAGAL LOGIN");
    }

  }
 
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screen.width,
          height: screen.height,
          padding: EdgeInsets.all(35),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset("images/patrick.png", width: 100),
                SizedBox(height: 15),
                TextField(controller: userText, decoration: InputDecoration(labelText: 'username'),),
                SizedBox(height: 15),
                TextField(controller: passwordText, obscureText: true, decoration: InputDecoration(labelText: 'password'),),
                SizedBox(height: 15),
                ElevatedButton(onPressed: login, child: Container(
                  child: Center (
                    child: Text('Login'),
                  ),
                  width: screen.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
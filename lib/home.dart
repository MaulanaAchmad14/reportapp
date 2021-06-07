import 'package:flutter/material.dart';
import 'homepage.dart';
import 'myreport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  //Let's add the color code for our proje

  int current_index = 0;
  Color bgBlack = Color(0xFF1a1a1a);
  Color mainBlack = Color(0xFF262626);
  Color fbBlue = Color(0xFF2D88FF);
  Color mainGrey = Color(0xFF505050);

  List<Widget> elements = [
    HomePage(),
    MyReport(),
    SizedBox(),
  ];

  //Here I'm going to import a list of images that we will use for the profile picture and the story

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //let's add the  bg color
      backgroundColor: bgBlack,
      //let's add the app bar
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainBlack,
        title: Text(
          "Reporting",
          style: TextStyle(
            color: fbBlue,
          ),
        ),
        //Now let's add the action button
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),

      //Now let's work on the body
      body: elements[current_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            if(index == 2) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                return Login();
              }), (Route<dynamic> route) => false);
            } else {
              setState(() {
                current_index = index;
              });
            }
          },
          currentIndex: current_index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "My Report"),
            BottomNavigationBarItem(
                icon: Icon(Icons.power_off), label: "Logout"),
          ]),
    );
  }
}

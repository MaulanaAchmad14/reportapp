import 'dart:convert';

import 'package:flutter/material.dart';
import 'actionbtn.dart';
import 'feedbox.dart';
import 'storytile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isLoading = true;
  List<dynamic> report;
  String username;

  void getFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String name = prefs.getString("name");
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/reports"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        });

    Map<String, dynamic> data = jsonDecode(response.body);
    setState(() {
      report = data["data"];
      isLoading = false;
      username = name;
    });
  }

  void initState() {
    super.initState();
    getFeed();
  }

// List<String> avatarUrl = [
//   "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
//   "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
//   "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
//   "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
// ];
// List<String> storyUrl = [
//   "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80",
//   "https://images.unsplash.com/photo-1600174297956-c6d4d9998f14?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
//   "https://images.unsplash.com/photo-1600008646149-eb8835bd979d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
//   "https://images.unsplash.com/photo-1502920313556-c0bbbcd00403?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
// ];

Color bgBlack = Color(0xFF1a1a1a);
Color mainBlack = Color(0xFF262626);
Color fbBlue = Color(0xFF2D88FF);
Color mainGrey = Color(0xFF505050);

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(top: 30, left:8.0, right:8, bottom: 8),
      child: isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) :
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: report.length,
                itemBuilder: (context, index) {
                  if(report[index]["status"] == 1) {
                    return feedBox(
                      false,
                      "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                      report[index]["name"],
                      report[index]["created_at"],
                      report[index]["description"],
                      "",
                    );
                  } else {
                    return SizedBox();
                  }
                })
          )
    ),
  );
}}

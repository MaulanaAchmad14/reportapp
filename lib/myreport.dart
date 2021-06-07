import 'dart:convert';

import 'package:flutter/material.dart';
import 'feedbox.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyReport extends StatefulWidget {
  @override
  _MyReport createState() => _MyReport();
}

class _MyReport extends State<MyReport> {
  List<dynamic> userReport;
  bool isLoading = true;
  String username;

  void initState() {
    super.initState();
    fetchReport();
  }

  void fetchReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id');
    String token = prefs.getString('token');
    String name = prefs.getString('user_name');
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/user_report/$userId"),
        headers: <String, String>{
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json'
        });

    var data = jsonDecode(response.body);
    if (data["success"] == true) {
      setState(() {
        userReport = data["data"];
        isLoading = false;
        username = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Report", style: TextStyle(color: Colors.white)),
              ElevatedButton(
                  onPressed: () {
                    print("dfjhdkjfh");
                  },
                  child: Text("Add Report")),
            ],
          ),
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 30,
              child: isLoading
                  ? Center(child: Container(width: 100, height: 100, child: CircularProgressIndicator()))
                  : ListView.builder(
                      itemCount: userReport.length,
                      itemBuilder: (context, index) {
                        return feedBox(
                            true,
                            "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                            username,
                            userReport[index]["created_at"],
                            userReport[index]["description"],
                            "");
                      })),
        ],
      ),
    ));
  }
}

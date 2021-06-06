import 'package:flutter/material.dart';
import 'feedbox.dart';

class MyReport extends StatefulWidget {
  @override
  _MyReport createState() => _MyReport();
}

class _MyReport extends State<MyReport> {
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
                ElevatedButton(onPressed: (){
                  print("dfjhdkjfh");
                }, child: Text("Add Report")),
              ],
            ),
            SizedBox(height: 20),
            feedBox(true, "", "Doctor code", "6 min",
                "I just wrote something", "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80"),
          ],
        ),
      )
    );
  }
}
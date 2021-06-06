import 'package:flutter/material.dart';
import 'actionbtn.dart';
import 'feedbox.dart';
import 'storytile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<String> avatarUrl = [
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
    "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
  ];
  List<String> storyUrl = [
    "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80",
    "https://images.unsplash.com/photo-1600174297956-c6d4d9998f14?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1600008646149-eb8835bd979d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
    "https://images.unsplash.com/photo-1502920313556-c0bbbcd00403?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
  ];

  Color bgBlack = Color(0xFF1a1a1a);
  Color mainBlack = Color(0xFF262626);
  Color fbBlue = Color(0xFF2D88FF);
  Color mainGrey = Color(0xFF505050);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            feedBox(false, avatarUrl[0], "Doctor code", "6 min",
                "I just wrote something", ""),
            feedBox(false, avatarUrl[1], "Joseph Joestar", "6 min",
                "It's pretty good I like it", storyUrl[2]),
            feedBox(false, avatarUrl[2], "Giorno giovana", "Yesterday",
                "I'm Giorno Giovana and I have a Dream", storyUrl[1]),
          ],
        ),
      ),
    );
  }
}

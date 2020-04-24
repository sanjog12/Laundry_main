import 'package:flutter/material.dart';

import 'pick_drop_ui/home_page.dart';

void main() => runApp(start());

class start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Laundry -beta",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white
      ),
      home: home_page(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laundry/Wrapper.dart';
import 'package:laundry/authentication/AuthScreens/Login.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';
import 'pick_drop_ui/home_page.dart';

void main() => runApp(Start());

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Laundry -beta",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white
      ),
      home: Wrapper(),
    );
  }
}

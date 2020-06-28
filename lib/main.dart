import 'package:flutter/material.dart';
//import 'package:laundry/Test/test1.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/during_navigation.dart';
import 'pick_drop_ui/home_page.dart';
void main() => runApp(Start());

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Laundry -beta",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}

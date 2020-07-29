import 'package:flutter/material.dart';
import 'package:laundry/Wrapper.dart';
import 'package:laundry/authentication/AuthScreens/Login.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';
import 'package:laundry/pick_drop_ui/pages/customer_end_work/customer_end.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/during_navigation.dart';
import 'authentication/AuthScreens/Login.dart';
import 'pick_drop_ui/home_page.dart';

void main() => runApp(Start());

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Laundry -beta",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white
      ),
      home: Login(),
    );
  }
}

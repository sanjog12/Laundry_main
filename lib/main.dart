import 'package:flutter/material.dart';
import 'package:laundry/Wrapper.dart';

void main() => runApp(Start());

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Laundry",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white
      ),
      home: Wrapper(),
    );
  }
}

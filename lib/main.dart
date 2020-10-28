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
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 8,
            color: Color.fromRGBO(2, 124, 149, 1),
            iconTheme: IconThemeData(
              color:Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      
      home: Wrapper(),
    );
  }
}

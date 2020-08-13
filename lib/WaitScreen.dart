import 'package:flutter/material.dart';

class WaitScreen extends StatefulWidget {
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	   body: Container(
       padding: EdgeInsets.all(20),
       child: Container(
         child: Center(
           child: CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
           ),
         ),
       )
     ),
    );
  }
}

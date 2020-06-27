import 'package:flutter/material.dart';

class CustomerEnd extends StatefulWidget {
  @override
  _CustomerEndState createState() => _CustomerEndState();
}

class _CustomerEndState extends State<CustomerEnd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    title: Text("Customer Laundry Details"),
	    ),
	    
	    body: Container(
		    padding: EdgeInsets.all(10),
		    child: Center(
			    child: Text("Customer Cloths Details input"),
		    ),
	    ),
    );
  }
}

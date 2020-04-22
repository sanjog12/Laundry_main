import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';


class during_navigation extends StatefulWidget {
  @override
  _during_navigationState createState() => _during_navigationState();
}

class _during_navigationState extends State<during_navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
	    child: Column(
	      children: <Widget>[
	        Padding(
		        padding: EdgeInsets.only(top: 200, left: 50),
		        child: Text("During navigation page "),
	        ),
		      
		      Padding(
		        padding: const EdgeInsets.only(top: 20, left: 50),
		        child: RaisedButton(
			       child: Text("Reached the destination "),
			       onPressed: (){
			      	 polyline().stop_polyline();
			       },
		        ),
		      )
		      
	      ],
	    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/screen_shot.dart';


class during_navigation extends StatefulWidget {
	
	polyline object;
	during_navigation(this.object , {Key key}):super(key : key);
	
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
		        child: Text("During navigation page ",style: TextStyle(fontSize: 20),),
	        ),
		      
		      Padding(
		        padding: const EdgeInsets.only(top: 20, left: 50),
		        child: RaisedButton(
			       child: Text("Reached the destination "),
			       onPressed: (){
			       	print("Navigating to screen shot page");
			      	 Navigator.push(context,
						       MaterialPageRoute(builder: (context) => screen_shot(widget.object)));
			       },
		        ),
		      )
		      
	      ],
	    ),
    );
  }
}

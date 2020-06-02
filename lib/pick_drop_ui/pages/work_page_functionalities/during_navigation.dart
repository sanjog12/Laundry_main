import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/screen_shot.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';



class DuringNavigation extends StatefulWidget {
	
	final String docName ;
	final CreatePolyline object;
	DuringNavigation(this.object , this.docName , {Key key}):super(key : key);
	
  @override
  _DuringNavigationState createState() => _DuringNavigationState();
}

class _DuringNavigationState extends State<DuringNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
	    color: Colors.white,
	    child: Column(
		    crossAxisAlignment: CrossAxisAlignment.stretch,
	      mainAxisAlignment: MainAxisAlignment.center,
	      children: <Widget>[
	        Center(
			        child: Text("During navigation page",style: TextStyle(
					        fontSize: 20
			        ),),
	        ),
		      
		      RaisedButton(
			       child: Text("Reached the destination "),
			       onPressed: (){
			       	print("Navigating to screen shot page");
			       	Navigator.of(context).pop();
			      	 Navigator.push(context,
						       MaterialPageRoute(builder: (context) => ScreenShot(widget.object, widget.docName)));
			       },
		      ),
	      ],
	    ),
    );
  }
}

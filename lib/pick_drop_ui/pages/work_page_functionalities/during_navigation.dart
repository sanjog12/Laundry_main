import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/Work_Page_Functionalities/Maps_functions.dart';
import 'package:laundry/pick_drop_ui/pages/Work_Page_Functionalities/Screen_shot.dart';



class During_navigation extends StatefulWidget {
	
	String doc_name ;
	polyline object;
	During_navigation(this.object , this.doc_name , {Key key}):super(key : key);
	
  @override
  _During_navigationState createState() => _During_navigationState();
}



class _During_navigationState extends State<During_navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
	    color: Colors.white,
	    
	    child: Column(
	      children: <Widget>[
	        Padding(
		        padding: EdgeInsets.only(top: 200, left: 50),
		        child: Text("During navigation page ",style: TextStyle(fontSize: 20),),
	        ),
		      
		      Padding(
		        padding:EdgeInsets.only(top: 20, left: 50),
		        child: RaisedButton(
			       child: Text("Reached the destination "),
			       onPressed: (){
			       	print("Navigating to screen shot page");
			       	Navigator.of(context).pop();
			      	 Navigator.push(context,
						       MaterialPageRoute(builder: (context) => Screen_shot(widget.object, widget.doc_name)));
			       },
		        ),
		      )
		      
	      ],
	    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';


class screen_shot extends StatefulWidget {
	
	polyline object;
	screen_shot(this.object , {Key key}): super(key: key);
	
	
  @override
  _screen_shotState createState() => _screen_shotState();
}

class _screen_shotState extends State<screen_shot> {
	
	Size size;
	
  @override
  Widget build(BuildContext context) {
	  
  	size = MediaQuery.of(context).size;
  	print("calling stop_polyline function ");
    return Container(
	    height : size.height,
	    width: size.width,
	    child: widget.object.stop_polyline(),
    );
  
  }
}

/*
   The layout of page which will appear after the worker will open the job 
which is specified in the work card in the work section . 
 */

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/Json_Road_Snapped.dart';

import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/during_navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';



Future<bool> workDescription(context,name , address){

	return showDialog(
			context: context,
			builder: (BuildContext context) => MapPage()
	);
}

class MapPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}


class _MapPageState extends State<MapPage>{
	Completer<GoogleMapController> _controller = Completer();
	static final CameraPosition _intial = CameraPosition(target: LatLng(28.640884,77.126071), zoom: 15);
	 List<Marker> markers = [];
	 
	 @override
  void initState() {
    super.initState();
    distanceTimeNavigation();
    markers.add(Marker(
			markerId: MarkerId("Sanjog House"),
			draggable: false,
			onTap: (){
				print("Tapped");
			},
			position: LatLng(28.640884,77.126071)
		));
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
			shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(10)
			),
			title: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: <Widget>[
					Text('Pickup Location Details',style: TextStyle(
						color: Colors.blueGrey
					),),
					Divider(
						thickness: 1,
					)
				],
			),
			backgroundColor: Colors.grey[400],
	    content:SingleChildScrollView(
	      child: Container(
	      	height: 400,
	      	width: 350,
	      	child: Center(
	      		child: GoogleMap(
	      			initialCameraPosition: _intial,
	      			markers: Set.from(markers),
	      			mapType: MapType.normal,
	      			onMapCreated: (GoogleMapController controller){
	      				_controller.complete(controller);
	      			},),
	      	),
	      	decoration: BoxDecoration(
	      		color: Colors.white,
	      	),
	      ),
	    ),
	    
	    actions: <Widget>[
		    RaisedButton(
			    shape: RoundedRectangleBorder(
				    borderRadius: BorderRadius.circular(15),
			    ),
			    color: Colors.blueGrey[700],
			    child: Text("NAVIGATE",textAlign: TextAlign.center,style: TextStyle(
				    color: Colors.blue[100],
			    ),),
			    
			    onPressed: (){
				    final String docName ='${Random().nextInt(10)}' + '  '+' ${DateTime.now()}';
				    CreatePolyline object = CreatePolyline(docName);
				    object.startRecord();
				    googleMapNavigation();
				    Navigator.of(context).pop();
				    Navigator.push(context,
						    MaterialPageRoute(builder: (context)=>DuringNavigation(object , docName))
				    );
			    },
		    ),
	    ],
		);
  }
}
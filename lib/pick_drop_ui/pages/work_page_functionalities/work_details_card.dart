/*
   The layout of page which will appear after the worker will open the job 
which is specified in the work card in the work section . 
 */

import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/during_navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';



Future<bool> workDescription(context, Job job, UserAuth userAuth){

	return showDialog(
			context: context,
			builder: (BuildContext context) => MapPage(
				userAuth: userAuth,
				job: job,
			)
	);
}


class MapPage extends StatefulWidget{
	final UserAuth userAuth;
	final Job job ;
  const MapPage({Key key, this.userAuth, this.job}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}


class _MapPageState extends State<MapPage>{
	Completer<GoogleMapController> _controller = Completer();
	 List<Marker> markers = [];
	 
	 @override
  void initState() {
    super.initState();
    markers.add(Marker(
			markerId: MarkerId("Sanjog House"),
			draggable: false,
			onTap: (){
				print("Tapped");
			},
			position: LatLng(double.parse(widget.job.lat),double.parse(widget.job.long)),
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
	      			initialCameraPosition: CameraPosition(target: LatLng(double.parse(widget.job.lat), double.parse(widget.job.long)), zoom: 15),
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
				    Navigator.of(context).pop();
				    Navigator.push(context,
						    MaterialPageRoute(builder: (context)=>DuringNavigation(object: object , docName: docName,userAuth: widget.userAuth, job: widget.job,))
				    );
			    },
		    ),
	    ],
		);
  }
}
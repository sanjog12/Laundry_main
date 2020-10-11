/*
   The layout of page which will appear after the worker will open the job 
which is specified in the work card in the work section . 
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/WorkerSection/Screen/NavigationScreen.dart';
import 'package:laundry/WorkerSection/work_page_functionalities/CreatePolyline.dart';
import 'package:url_launcher/url_launcher.dart';



Future<bool> workDescription(context, Job job, UserBasic userBasic){

	return showDialog(
			context: context,
			builder: (BuildContext context) => MapPage(
				userBasic: userBasic,
				job: job,
			)
	);
}


class MapPage extends StatefulWidget{
	final UserBasic userBasic;
	final Job job ;
  const MapPage({Key key, this.userBasic, this.job}) : super(key: key);
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
			position: LatLng(widget.job.position.latitude, widget.job.position.longitude),
//	    position: LatLng(28.601231, 77.082344),
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
					Text(widget.job.customerName,style: TextStyle(
						color: Colors.blueGrey,
						fontWeight: FontWeight.bold,
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
	      			initialCameraPosition: CameraPosition(target: LatLng(widget.job.position.latitude, widget.job.position.longitude), zoom: 15),
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
			    
			    onPressed: () async{
				    CreatePolyline object = CreatePolyline();
				    object.startRecord(widget.job);
				    print(widget.job.position.latitude.toString()+" "+widget.job.position.longitude.toString());
				    try {
					    launch(
							    'https://www.google.com/maps/dir/?api=1&destination=${widget
									    .job.position.latitude.toString()}'
									    ',${widget.job.position.longitude.toString()}&dir_action=navigate&travelmode=driving');
				    }catch(e){
				    	print("error");
				    	print(e);
				    }
				    Navigator.pop(context);
				    Navigator.push(context,
						    MaterialPageRoute(builder: (context)=>DuringNavigation(object: object, userBasic: widget.userBasic, job: widget.job,))
				    );
			    },
		    ),
	    ],
		);
  }
}
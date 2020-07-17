
import 'dart:async';
import 'package:laundry/Classes/UserBasic.dart';

import 'screen_shot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';
import 'package:location/location.dart';



class DuringNavigation extends StatefulWidget {

	final UserBasic userBasic;
	final String docName ;
	final CreatePolyline object;
	final Job job;
	DuringNavigation({this.userBasic, this.object, this.docName, this.job, Key key}):super(key : key);

	@override
	_DuringNavigationState createState() => _DuringNavigationState();
}

class _DuringNavigationState extends State<DuringNavigation> {
	
	GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: 'AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc');
	Location location =Location();
	LatLng currentLocation;
	LatLng previousLocation;
	List<LatLng> routeCoordinates;
	Completer<GoogleMapController> _controller = Completer();
	Set<Polyline> polyline ={};
	
	Future<List<LatLng>> getPolyline() async{
		
		try{
		await googleMapPolyline.getCoordinatesWithLocation(
				origin: currentLocation,
				destination: LatLng(widget.job.position.latitude , widget.job.position.longitude),
				mode: RouteMode.driving,
//			destination: LatLng(28.601231, 77.082344)
		).then((value){
			routeCoordinates = value;
		});}catch(e){
			print(e.toString());
		}
		print("printing");
		print(routeCoordinates.first);
		return routeCoordinates;
	}
	
	@override
  void initState() {
    super.initState();
    location.getLocation().then((value){
    	previousLocation = currentLocation;
    	currentLocation = LatLng(value.latitude,value.longitude);
    }).whenComplete(() async{
	    await getPolyline().then((value){
	    	if(this.mounted) {
			    setState(() {
				    polyline.add(
						    Polyline(
							    polylineId: PolylineId('route1'),
							    visible: true,
							    points: value,
							    width: 6,
							    color: Colors.red,
							    startCap: Cap.roundCap,
							    endCap: Cap.buttCap,
						    )
				    );
			    });
		    }
	    });
    });
  }
  
  void updateCamera() async{
		final GoogleMapController controller = await _controller.future;
		controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation,zoom: 17)));
  }
	
  @override
  Widget build(BuildContext context) {
	  location.onLocationChanged.listen((event) {
	  	print("inside");
	  	if(mounted) {
			  setState(() {
				  currentLocation = LatLng(event.latitude, event.longitude);
			  });
		  }
		  updateCamera();
	  });
	  
	  
    return Stack(
      children : <Widget>[
      	Container(
	    child: GoogleMap(
		    initialCameraPosition: CameraPosition(target: currentLocation != null?currentLocation:LatLng(0,0),zoom: 17),
		    polylines: polyline,
		    compassEnabled: true,
		    myLocationEnabled: true,
		    mapType: MapType.normal,
		    onMapCreated: (GoogleMapController controller) async{
		    	_controller.complete(controller);
		    	controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation != null?currentLocation:LatLng(0,0),zoom: 17)));
		    },
	    ),
      ),
	
	      Align(
		      alignment: AlignmentDirectional.bottomStart,
	        child: Container(
		        height: 40,
		        width: 150,
			      decoration: BoxDecoration(
				      borderRadius: BorderRadius.circular(10),
				      color: Colors.blueGrey,
			      ),
			      child: FlatButton(
					      child: Text("Reached Location"),
					      onPressed: () {
						      Navigator.of(context).pop();
						      Navigator.push(context,
								      MaterialPageRoute(builder: (context) => ScreenShot(
									      object: widget.object,
									      docName: widget.docName,
									      userBasic: widget.userBasic,
									      job: widget.job,
								      )));
					      }
			      ),
	        ),
	      ),
      ],
    );
  }
}

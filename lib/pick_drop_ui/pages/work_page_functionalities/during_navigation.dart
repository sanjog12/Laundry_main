
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:screen/screen.dart';
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
		).then((value){
			routeCoordinates = value;
		});
		}catch(e){
			print("error in getPolyline");
			print(e.toString());
		}
		return routeCoordinates;
	}
	
	
	Future<bool> popUpFunction() async{
		return showDialog(
			context: context,
			builder: (context){
				return AlertDialog(
					title: Text("Tracking"),
					content: Text("You are being tracked , You can't go back from this page"),
					actions: <Widget>[
						FlatButton(
							child: Text("Ok"),
							onPressed: () => Navigator.of(context).pop(false)
						)
					],
				);
			}
		)??false;
	}
	
	
	@override
  void initState() {
		Screen.keepOn(true);
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
							    color: Colors.lightBlue,
							    width: 3,
							    startCap: Cap.roundCap,
							    endCap: Cap.buttCap,
						    )
				    );
			    });
		    }
	    });
    });
  }
  
  Future<void> updateCamera() async{
		final GoogleMapController controller = await _controller.future;
		controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation,zoom: 17)));
  }
  
  @override
  void dispose() {
    super.dispose();
  }
	
  @override
  Widget build(BuildContext context) {
	  location.onLocationChanged.listen((event) {
	  	print("inside location Changed event ");
	  	if(mounted) {
			  setState(() {
				  currentLocation = LatLng(event.latitude, event.longitude);
			  });
			  updateCamera();
		  }
	  });
	  
	  
    return WillPopScope(
	    onWillPop: popUpFunction,
      child: Stack(
        children : <Widget>[
        	Container(
		        height: MediaQuery.of(context).size.height - 40,
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
		        alignment: AlignmentDirectional.bottomCenter,
		        child: Container(
			        padding: EdgeInsets.symmetric(horizontal: 120,vertical: 5),
			        height: 50,
			        width: MediaQuery.of(context).size.width,
			        decoration: BoxDecoration(
					        color: Color.fromRGBO(224,238,242, 1)
			        ),
			        child: Container(
				        height: 40,
				        width: 80,
				        decoration: BoxDecoration(
					        borderRadius: BorderRadius.circular(8),
					        color: Color.fromRGBO(2, 124, 149, 1),
				        ),
				        child: FlatButton(
						        child: Text("End Ride",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontFamily: "Seguisb",fontSize: 20),),
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
	        ),
        ],
      ),
    );
  }
}

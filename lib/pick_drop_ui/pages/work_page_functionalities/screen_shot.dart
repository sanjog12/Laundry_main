import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/pick_drop_ui/pages/Work_Page_Functionalities/Maps_functions.dart';


class Screen_shot extends StatefulWidget {
	polyline object;
	String doc_name;
	Screen_shot(this.object , this.doc_name ,{Key key}): super(key: key);
  @override
  _Screen_shotState createState() => _Screen_shotState();
}




class _Screen_shotState extends State<Screen_shot> {
	
	
	
	
	Size size;
	Completer<GoogleMapController> _controller = Completer();
	int _polylineIdCounter =1;
	Map<PolylineId,Polyline> polylines = <PolylineId, Polyline>{};
	
	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    trip_details();
    widget.object.stop_polyline();
  }
	
	
	LatLngBounds _latLngBounds(List<LatLng> list){
		/*
		    Function to return the boundary based on the points recorded in the list
		that bounds the google_map to a specified boundary and sets the zoom level
		 */
		
		print("About to check assert function in _latlongBoubds function");
		assert(list.isNotEmpty); /// If true then execution will happen normally
		/// if false then execution will be stopped here only
		
		print("assert is false exicuting further codes ");
		double x0,x1,y0,y1;
		for(LatLng latLng in list){
			if(x0==null){
				x0 = x1 =latLng.latitude;
				y0 = y1 =latLng.longitude;
			}else{
				if(latLng.latitude > x1) x1 = latLng.latitude;
				if(latLng.latitude < x0) x0 = latLng.latitude;
				if(latLng.longitude > y1) y1 = latLng.longitude;
				if(latLng.longitude < y0) y0 = latLng.longitude;
			}
		}
		print(x0 );
		return LatLngBounds(northeast: LatLng(x1,y1) , southwest: LatLng(x0 , y0));
	}
	
	
	void trip_details(){
		print("trip_details invoked ");
		/*
		Makes polyline connecting consecutive recorded points
		 */
		
		
		print(widget.object.getrecordedlist());
		final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
		_polylineIdCounter++;
		final PolylineId polylineId = PolylineId(polylineIdVal);
		
		final Polyline polyline =Polyline(
			jointType: JointType.mitered,
			startCap: Cap.roundCap,
			endCap: Cap.squareCap,
			geodesic: false,
			polylineId: polylineId,
			consumeTapEvents: true,
			color: Colors.lightBlueAccent,
			width: 5,
			points: widget.object.getrecordedlist(),
			onTap: (){},
		);
		setState(() {
			polylines[polylineId]=polyline;
		});
		
	}
	
	
	upload_pic(png) async {
		final StorageReference firebaseStorageRef =
				FirebaseStorage.instance.ref().child(widget.doc_name);
		final StorageUploadTask task = firebaseStorageRef.putData(png);
	}
	
	
  @override
  Widget build(BuildContext context) {
	
	  print(Set<Polyline>.of(polylines.values));
		
  	size = MediaQuery.of(context).size;
  	print("calling stop_polyline function ");
    return Container(
	    height: size.height-200,
	        child: GoogleMap(
		      polylines: Set<Polyline>.of(polylines.values),
		      initialCameraPosition: CameraPosition(target: widget.object.getrecordedlist().first),
		      mapType: MapType.normal,
		      zoomGesturesEnabled: true,
		      zoomControlsEnabled: true,
		      onMapCreated: (GoogleMapController controller) async {
			      _controller.complete(controller);
			      controller.animateCamera(CameraUpdate.newLatLngBounds(_latLngBounds(widget.object.getrecordedlist()),2));
			      
			      await Future.delayed(Duration(seconds: 4));
			      Firestore.instance.collection('Location Points').document(widget.doc_name).setData({
				      '${DateTime.now()}' : 'Screen Short Taken'
			      },merge: true);
			      var png = await controller.takeSnapshot();
			      upload_pic(png);
			      },
	        ),
    );
  }
}

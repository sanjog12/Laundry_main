/*
All works related to the maps and navigation
 */

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:background_location/background_location.dart';


get_navigation(){
	/*
	   Navigating to the work places and other places is done using this function  in the following url we can pass
	   location variable and driving mode .
	 */
	launch('https://www.google.com/maps/dir/?api=1&destination=28.640884,77.126071&dir_action=navigate&travelmode=two_wheeler');
}





class polyline {
	/*
	   Class that makes polyline of the trip first records it and then makes a polyline on the google maps for storing
	the ss in of the google map in the database along with the specified job
	 */
	
	CameraUpdate _update;
	List<LatLng> _listltlg = [];
	Completer<GoogleMapController> _controller = Completer();
	Map<PolylineId,Polyline> polylines = <PolylineId, Polyline>{};
	int _polylineIdCounter =1;
	
	
	start_record() {
		
		BackgroundLocation.startLocationService();
		BackgroundLocation.getLocationUpdates((location) {
			_listltlg.add(LatLng(location.latitude, location.longitude));
		});
	}
	
	
	void trip_details(){
		final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
		_polylineIdCounter++;
		
		final PolylineId polylineId = PolylineId(polylineIdVal);
		
		final Polyline polyline =Polyline(
			jointType: JointType.round,
			geodesic: true,
			polylineId: polylineId,
			consumeTapEvents: true,
			color: Colors.lightBlueAccent,
			width: 5,
			points: _listltlg,
			onTap: (){},
		);
		polylines[polylineId]=polyline;
	}
	
	Widget stop_polyline() {
		BackgroundLocation.stopLocationService();
		return Container(
			child: GoogleMap(
			  polylines: Set<Polyline>.of(polylines.values),
				mapType: MapType.normal,
				onMapCreated: (GoogleMapController controller){
			  	_controller.complete(controller);
			  	},
			),
		);
	}
}
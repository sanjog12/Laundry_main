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
	bool check;
	List<LatLng> _listltlg = [];
	Completer<GoogleMapController> _controller = Completer();
	Map<PolylineId,Polyline> polylines = <PolylineId, Polyline>{};
	int _polylineIdCounter =1;
	
	
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
		return LatLngBounds(northeast: LatLng(x1,y1) , southwest: LatLng(x0 , y0));
	}
	
	
	start_record() {
		/*
		Starts background location tracking
		 */
		BackgroundLocation.startLocationService();
		BackgroundLocation.getLocationUpdates((location) {
			this._listltlg.add(LatLng(location.latitude, location.longitude));
			this.check = this._listltlg.isNotEmpty;
			print("location change detected and stored " + '$check');
		});
	}
	
	
	void trip_details(){
		print("trip_details invoked ");
		/*
		Makes polyline connecting consecutive recorded points
		 */
		
		final String polylineIdVal = 'polyline_id_${this._polylineIdCounter}';
		this._polylineIdCounter++;
		
		final PolylineId polylineId = PolylineId(polylineIdVal);
		
		final Polyline polyline =Polyline(
			jointType: JointType.round,
			geodesic: true,
			polylineId: polylineId,
			consumeTapEvents: true,
			color: Colors.lightBlueAccent,
			width: 5,
			points: this._listltlg,
			onTap: (){},
		);
		this.polylines[polylineId]=polyline;
	}
	
	
	
	Widget stop_polyline() {
		this.check = this._listltlg.isNotEmpty;
		print("stop_polyline function is invoked " + '${this.check}');
		
		/*
		     Function that returns the plotted map on the screen and stops the background process
		 */
		
		BackgroundLocation.stopLocationService();
		return Container(
			child: GoogleMap(
			  polylines: Set<Polyline>.of(polylines.values),
				initialCameraPosition: CameraPosition(target: _listltlg.first),
				mapType: MapType.normal,
				cameraTargetBounds: CameraTargetBounds(_latLngBounds(this._listltlg)),
				onMapCreated: (GoogleMapController controller){
			  	this._controller.complete(controller);
			  	},
			),
		);
	}
}
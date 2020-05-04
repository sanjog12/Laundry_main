/*
All works related to the maps and navigation
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:background_location/background_location.dart';


get_navigation(){
	
	/*
	   Navi places and other places is done using this function  in the following url we can pass
	   location variable and driving mode .
	 */
	
	launch('https://www.google.com/maps/dir/?api=1&destination=28.640884,77.126071&dir_action=navigate&travelmode=two_wheeler');
}




class polyline {
	/*
	   Class that makes polyline of the trip first records it and then makes a polyline on the google maps for storing
	the ss in of the google map in the database along with the specified job
	 */
	
	String doc_name;
	polyline(this.doc_name);
	GeoPoint a ;
	
	bool check;
	List<LatLng> _listltlg= [];
	
	List<LatLng> getlist(){
		print("list accessed");
		return this._listltlg;
	}
	
	
	start_record() {
		/*
		Starts background location tracking
		 */
		BackgroundLocation.startLocationService();
		_listltlg.add(LatLng(0,0));
		BackgroundLocation.getLocationUpdates((location) {
			print('getLocationUpdate invoked');
			
			Corordinate_filter(location);
		});
	}
	
	
	stop_polyline() {
		this.check = this._listltlg.isNotEmpty;
		print("stop_polyline function is invoked " + '$check');
		/*
		     Function that returns the plotted map on the screen and stops the background process
		 */
		BackgroundLocation.stopLocationService();
		_listltlg.removeAt(0);
	}
	
	
	void Corordinate_filter(location) {
		
		print('inside filter property');
		
		if(_listltlg.last.longitude != location.longitude && _listltlg.last.latitude != location.latitude){
			print('Condition for not recording same points ');
			this._listltlg.add(LatLng(location.latitude,location.longitude));
			
			a=GeoPoint(location.latitude,location.longitude);
			
			Firestore.instance.collection('Location Points').document(doc_name).setData({
				'${DateTime.now()}' : a
			},merge: true);
		}
	}
}
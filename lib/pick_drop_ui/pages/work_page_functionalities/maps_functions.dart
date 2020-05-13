/*
All works related to the maps and navigation
 */

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Json_Road_Snapped.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:background_location/background_location.dart';


// ignore: non_constant_identifier_names
get_navigation(){
	/*
	   Navigation places and other places is done using this function  in the following url we can pass
	   location variable and driving mode .
	 */
	
	launch('https://www.google.com/maps');
	
}


// ignore: non_constant_identifier_names
 FetchRoadSnapped() async{
	/*
	   Using a google's built in api called  *Road snapped* by passing a set of coordinates through a HTTPS
	   to process the points and return the set of a road points which user might have taken which is predicted
	   by the passed set of location points  
	 */
	
	SnappedPoints snappedPointsFromjson(String str) => SnappedPoints.fromJson(json.decode(str));
	
	http.Response response = await http.get('https://roads.googleapis.com/v1/snapToRoads?path=28.594094,77.082039|28.593753,77.082030|28.593654,77.081619|28.593628,77.080884&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc');
	if(response.statusCode==200){
		snappedPointsFromjson(response.body);
	else {
		print("Loading");
	}
 }
		
		
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
	List<LatLng> _listltlg;
	static List<LatLng> _snappedlist = [];
	
	
	List<LatLng> getrecordedlist(){
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
	
// ignore: non_constant_identifier_names
	static void Snappedlist(double a , double b){
		_snappedlist.add(LatLng(a,b));
	}
}
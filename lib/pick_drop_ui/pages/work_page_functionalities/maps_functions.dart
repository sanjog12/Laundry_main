/*
All works related to the maps and navigation
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:background_location/background_location.dart';



googleMapNavigation(){
	launch('https://www.google.com/maps/');
}


class CreatePolyline {
	
	String docName;
	CreatePolyline(this.docName);
	GeoPoint a ;
	bool check;
	List<LatLng> _listltlg = [];
	
	
	List<LatLng> getrecordedlist(){
		print("list accessed");
		return this._listltlg;
	}
	
	
	startRecord() async{
		BackgroundLocation.startLocationService();
		_listltlg.add(LatLng(0,0));
		BackgroundLocation.getLocationUpdates((location) {
			print('getLocationUpdate invoked');
			coordinateFilter(location);
		});
	}
	
	
	stopPolyline() {
		this.check = this._listltlg.isNotEmpty;
		print("stop_polyline function is invoked " + '$check');
		BackgroundLocation.stopLocationService();
		_listltlg.removeAt(0);
	}
	
	
	
	void coordinateFilter(location) {
		print('inside filter property');
		
		if(_listltlg.last.longitude.toStringAsFixed(3) != location.longitude.toStringAsFixed(3)
				&& _listltlg.last.latitude.toStringAsFixed(3) != location.latitude.toStringAsFixed(3)){
			
			print('Condition for not recording same points ');
			this._listltlg.add(LatLng(location.latitude,location.longitude));
			
			a=GeoPoint(location.latitude,location.longitude);
			
			Firestore.instance.collection('Location Points').document(docName).setData({
				'${DateTime.now()}' : a
			},merge: true);
		}
	}
}
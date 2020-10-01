/*
All works related to the maps and navigation ..//  \\..
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:background_location/background_location.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:http/http.dart';



class CreatePolyline {
	
	GeoPoint a ;
	bool check;
	List<LatLng> _listltlg = [];
	List<DateTime> dateTime= [];
	Set<Marker> delayInJob ={};
	
	
	List<LatLng> getrecordedlist(){
		// print("list accessed");
		return this._listltlg;
	}
	
	
	startRecord(Job job) {
		BackgroundLocation.startLocationService();
		_listltlg.add(LatLng(0,0));
		BackgroundLocation.getLocationUpdates((location) {
			print("Latitude : " +location.latitude.toString() + " " +"Longitude : " +location.longitude.toString());
			coordinateFilter(location,job);
		});
		dateTime.add(DateTime.now());
	}
	
	
	stopPolyline() {
		print("stop_polyline function is invoked " + '$check');
		BackgroundLocation.stopLocationService();
		_listltlg.removeAt(0);
	}
	
	
	
	void coordinateFilter(location,Job job) {
		if(_listltlg.last.longitude.toStringAsFixed(3) != location.longitude.toStringAsFixed(3)
				&& _listltlg.last.latitude.toStringAsFixed(3) != location.latitude.toStringAsFixed(3)){
			// print('Condition for not recording same points ');
			this._listltlg.add(LatLng(location.latitude,location.longitude));
			a = GeoPoint(location.latitude,location.longitude);
			// print("minute " +DateTime.now().difference(dateTime.last).inMinutes.toString());
			if(DateTime.now().difference(dateTime.last).inMinutes >= 5){
				// print("delay");
				this.delayInJob.add(Marker(
					icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
					markerId: MarkerId("Delay"),
					consumeTapEvents: true,
					infoWindow: InfoWindow(
						snippet: DateTime.now().difference(dateTime.last).inMinutes.toString(),
					),
					position: LatLng(location.latitude,location.longitude),
				));
			}
			// print(this.delayInJob.length);
			dateTime.add(DateTime.now());
		}
	}
}
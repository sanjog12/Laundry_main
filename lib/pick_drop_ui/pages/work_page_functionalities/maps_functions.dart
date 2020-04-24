/*
All works related to the maps and navigation
 */

import 'package:google_maps_flutter/google_maps_flutter.dart';
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
	
	bool check;
	List<LatLng> _listltlg=[];
	
	List<LatLng> getlist(){
		print("list accessed");
		return this._listltlg;
	}
	
	
	start_record() {
		/*
		Starts background location tracking
		 */
		BackgroundLocation.startLocationService();
		this._listltlg.add(LatLng(28.593888, 77.082024));
		this._listltlg.add(LatLng(28.593651, 77.081753));
		this._listltlg.add(LatLng(28.593611, 77.081347));
		this._listltlg.add(LatLng(28.594308, 77.080779));
//		BackgroundLocation.getLocationUpdates((location) {
//			this._listltlg.add(LatLng(location.latitude, location.longitude));
//			this.check = this._listltlg.isNotEmpty;
//			print("location change detected and stored " + '$check');
//		});
	}
	
	
	stop_polyline() {
		this.check = this._listltlg.isNotEmpty;
		print("stop_polyline function is invoked " + '$check');
		/*
		     Function that returns the plotted map on the screen and stops the background process
		 */
		BackgroundLocation.stopLocationService();
	}
}
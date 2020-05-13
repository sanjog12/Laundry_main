import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';

class SnappedPoints {
	
	
	final List<SnappedPoint> snappedpoints;

	SnappedPoints({this.snappedpoints});

	factory SnappedPoints.fromJson(Map<String, dynamic> json){
		return SnappedPoints(
			snappedpoints: List<SnappedPoint>.from(json["snappedPoints"].map((x) => SnappedPoint.fromJson(x)))
		);
	}
}



class SnappedPoint{
	final Location location;
	final int originalIndex;
	final String placeId;
	
	SnappedPoint({this.location,this.originalIndex , this.placeId});
	
	factory SnappedPoint.fromJson(Map<String,dynamic> json) => SnappedPoint(
		location: Location.fromJson(json["location"]),
		originalIndex: json["originalIndex"],
		placeId: json["placeId"],
	);
}



class Location {
	final double latitude;
	final double longitude;
	Location({this.latitude,this.longitude});
	factory Location.fromJson(Map<String , dynamic > json){
		double lat = json["latitude"].toDouble();
		double long = json["longitude"].toDouble();
		polyline.Snappedlist(lat, long);
		return Location(
			latitude: lat,
			longitude:long,
		);
	}
}

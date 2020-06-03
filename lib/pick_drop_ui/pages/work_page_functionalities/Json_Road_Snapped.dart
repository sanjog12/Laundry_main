import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;



Future<List<LatLng>> fetchRoadSnapped(List<LatLng> recordedList) async{
	/*
	   Using a google's built in api called  *Road snapped* by passing a set of coordinates through a HTTPS
	   to process the points and return the set of a road points which user might have taken which is predicted
	   by the passed set of location points
	 */
	
	List<LatLng> points =[];
	String url = '';
	for(var p in recordedList)
		url = url + p.latitude.toString() + ',' +p.longitude.toString() + (recordedList.last.latitude == p.latitude? '' :'|');
	
	url = 'https://roads.googleapis.com/v1/snapToRoads?path=' + url +'&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc';
	print(url);
	http.Response response = await http.get(url);
	
	if(response.statusCode==200){
		Map<String, dynamic> map = await json.decode(response.body);
		for(int i=0 ; i<map['snappedPoints'].length ;i++ ){
			points.add(LatLng(map['snappedPoints'][i]['location']['latitude'] as double,
					map['snappedPoints'][i]['location']['longitude'] as double));
		}
		return points;
	}
	
	else{
		print("Error");
		return null;
	}
}



Future<void> distanceTimeNavigation() async{
	
	String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometers&origins=28.594208,77.082083&destinations=28.598174,77.081450&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc";
	
	http.Response response = await http.get(url);
	print("response\n" + '${response.body}');
	
	
}
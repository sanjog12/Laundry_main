import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;



Future<List<LatLng>> fetchRoadSnapped() async{
	/*
	   Using a google's built in api called  *Road snapped* by passing a set of coordinates through a HTTPS
	   to process the points and return the set of a road points which user might have taken which is predicted
	   by the passed set of location points
	 */
	
	List<LatLng> points =[];
	http.Response response = await http.get('https://roads.googleapis.com/v1/snapToRoads?path=28.594094,77.082039|28.593753,77.082030|28.593654,77.081619|28.593628,77.080884&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc');
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

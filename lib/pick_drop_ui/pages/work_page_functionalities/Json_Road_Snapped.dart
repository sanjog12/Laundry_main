import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;




Future<List<LatLng>> fetchRoadSnapped(List<LatLng> recordedList) async{
	List<LatLng> points =[];
	String url = '';
	
	for(var p in recordedList)
		url = url + p.latitude.toString() + ',' +p.longitude.toString() + (recordedList.last.latitude == p.latitude? '' :'|');
	
	url = 'https://roads.googleapis.com/v1/snapToRoads?path='+url+'&interpolate=true&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc';
	
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



Future<void> distanceTimeNavigation(List<LatLng> temp, docName) async{
	
	String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometers&origins="
			+temp.first.latitude.toString()+","+temp.first.longitude.toString() +
			"&destinations="+temp.last.latitude.toString()+","+temp.last.longitude.toString() +"&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc";
	
	http.Response response = await http.get(url);
	print("response\n" + '${response.body}');
	Map<String,dynamic> map = await json.decode(response.body);
	print('length distance JSON: '+map['rows'][0]['elements'][0]['distance']['text'].toString());
	print('length distance JSON: '+map['rows'][0]['elements'][0]['duration']['text'].toString());
	await Firestore.instance.collection('Location Points').document(docName).setData({
		'Distance' : map['rows'][0]['elements'][0]['distance']['text'].toString(),
		'Time' : map['rows'][0]['elements'][0]['duration']['text'].toString()
	},merge: true);
}
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/TripDetails.dart';
import 'package:laundry/Services/SharedPrefs.dart';




Future<List<LatLng>> fetchRoadSnapped(List<LatLng> recordedList,docName) async{
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
		await Firestore.instance.collection('Location Points').document(docName).setData({
			"api url":url,
		},merge: true);
		return points;
		
	}
	
	else{
		print("Error");
		return null;
	}
}



Future<TripDetails> distanceTimeNavigation(List<LatLng> temp, Job job) async{
	
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf = firebaseDatabase.reference();
	String mobile = await SharedPrefs.getStringPreference('Mobile');
	String distance;
	String time ;
	double totalDistance;
	double totalTime;
	
	try {
		
		String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometers&origins="
				+ temp.first.latitude.toString() + "," +
				temp.first.longitude.toString() +
				"&destinations=" + temp.last.latitude.toString() + "," +
				temp.last.longitude.toString() +
				"&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc";
		
		http.Response response = await http.get(url);
		Map<dynamic, dynamic> map = await json.decode(response.body);
		
		print('length distance JSON: '+map['rows'][0]['elements'][0]['distance']['text'].toString());
		print('length distance JSON: '+map['rows'][0]['elements'][0]['duration']['text'].toString());
		
		dbf = firebaseDatabase.reference()
				.child("EmployeeRecordDistance")
				.child(mobile.toString())
				.child(DateTime.now().month.toString());
		
		dbf.once().then((DataSnapshot snapshot){
			Map<dynamic,dynamic> map = snapshot.value;
			map.forEach((key, value) {
				distance = value["Total_Distance"];
				time = value["Total_Time"];
			});
		});
		
		print("distance " +distance);
		print("time " + time);
		
		if(distance != null && time != null){
			totalDistance = double.parse(distance) + double.parse(map['rows'][0]['elements'][0]['distance']['text'].toString());
			totalTime = double.parse(time) + double.parse(map['rows'][0]['elements'][0]['duration']['text'].toString());
		}
		else{
			totalDistance = double.parse(map['rows'][0]['elements'][0]['distance']['text'].toString());
			totalTime = double.parse(map['rows'][0]['elements'][0]['duration']['text'].toString());
		}
		
		dbf = firebaseDatabase.reference();
		dbf.child("EmployeeRecordDistance")
				.child(mobile.toString())
				.child(DateTime.now().month.toString())
				.set({
			'Distance': totalDistance,
			'Time': totalTime,
		});
		
		TripDetails tripDetails = TripDetails(
				distance: map['rows'][0]['elements'][0]['distance']['text'].toString(),
				time: map['rows'][0]['elements'][0]['duration']['text'].toString()
		);
		
		return tripDetails;
	}catch(e){
		print(e);
		return null;
	}
}

Future<double> distanceFormStore(LatLng currentLocation, LatLng storeLocation) async {
	String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=meters&origins="
			+ currentLocation.latitude.toString() + "," +
			currentLocation.longitude.toString() +
			"&destinations=" + currentLocation.latitude.toString() + "," +
			currentLocation.longitude.toString() +
			"&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc";
	
	http.Response response = await http.get(url);
	print("response\n" + '${response.body}');
	Map<String, dynamic> map = await json.decode(response.body);
	
	return double.parse(map['rows'][0]['elements'][0]['distance']['text']);
}
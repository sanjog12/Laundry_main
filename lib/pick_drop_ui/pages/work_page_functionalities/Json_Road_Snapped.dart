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
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	
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
	String uid;
	uid = await SharedPrefs.getStringPreference("uid");
	print(uid);
	
	String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=kilometers&origins="
			+temp.first.latitude.toString()+","+temp.first.longitude.toString() +
			"&destinations="+temp.last.latitude.toString()+","+temp.last.longitude.toString() +"&key=AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc";
	
	http.Response response = await http.get(url);
	print("response\n" + '${response.body}');
	Map<dynamic,dynamic> map = await json.decode(response.body);
	print('length distance JSON: '+map['rows'][0]['elements'][0]['distance']['text'].toString());
	print('length distance JSON: '+map['rows'][0]['elements'][0]['duration']['text'].toString());
	await firebaseDatabase.reference().child("EmployeeRecordDistance").child(uid).child(job.id).set({
		'Distance' : map['rows'][0]['elements'][0]['distance']['text'].toString(),
		'Time' : map['rows'][0]['elements'][0]['duration']['text'].toString(),
	});
	TripDetails tripDetails = TripDetails(
			distance: map['rows'][0]['elements'][0]['distance']['text'].toString(),
			time: map['rows'][0]['elements'][0]['duration']['text'].toString()
	);
	return tripDetails;
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
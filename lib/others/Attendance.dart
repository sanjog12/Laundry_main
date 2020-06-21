

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Services/SharedPrefs.dart';



FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
DatabaseReference dbf;
String uid;

Future<List<DateTime>> getAttendance() async{
	List<DateTime> presentDates = [];
	List<DateTime> absentDates = [];
	uid = await SharedPrefs.getStringPreference('uid');
	dbf = firebaseDatabase.reference()
			.child("Attendance")
			.child(uid)
	    .child("2020")
			.child(DateTime.now().month.toString());
	await dbf.once().then((DataSnapshot snapshot) async{
		Map<dynamic,dynamic> map = await snapshot.value;
		map.forEach((key, value) async{
			print(key);
			presentDates.add(DateTime(2020,DateTime.now().month,int.parse(key)));
		});
	});
	print(presentDates.length);
	return presentDates;
}
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:laundry/pick_drop_ui/pages/attendance.dart';



FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
DatabaseReference dbf;
String uid;

Future<void> getAttendance(UserBasic userBasic) async {
	uid = await SharedPrefs.getStringPreference('uid');
	dbf = firebaseDatabase.reference()
			.child("Attendance")
			.child(userBasic.mobile+"_"+userBasic.name+"_"+userBasic.userID)
			.child(DateTime.now().year.toString())
			.child("9");
	
	await dbf.once().then((DataSnapshot snapshot) async {
		print(snapshot.value);
		print(snapshot.key);
		Map<dynamic, dynamic> map = await snapshot.value;
		
		for (var v in map.entries) {
			if(v.value.toString() == "half" || v.value.toString() =="half_late"){
				halfDates.add(DateTime(DateTime.now().year,DateTime.now().month,int.parse(v.key.toString())));
			}
			else if(v.value.toString() == "full" || v.value.toString() =="full_late"){
				presentDates.add(DateTime(DateTime.now().year ,DateTime.now().month,int.parse(v.key.toString())));
			}
			else if(v.value.toString() == "absent" || v.value.toString() =="absent_late"){
				absentDates.add(DateTime(DateTime.now().year ,DateTime.now().month,int.parse(v.key.toString())));
			}
		}
	});
}
import 'package:firebase_database/firebase_database.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import '../Wrapper.dart';



FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
DatabaseReference dbf;
String uid;

Future<List<DateTime>> getAttendance(UserBasic userBasic) async {
	uid = await SharedPrefs.getStringPreference('uid');
	
	dbf = firebaseDatabase.reference()
			.child("Attendance")
			.child(userBasic.mobile)
			.child("2020")
			.child(DateTime
			.now()
			.month
			.toString());
	
	await dbf.once().then((DataSnapshot snapshot) async {
		Map<dynamic, dynamic> map = await snapshot.value;
		for (var v in map.entries) {
		
		}
//		map.forEach((key, value) async{
//			print(key);
//			presentDates.add(DateTime(2020,DateTime.now().month,int.parse(key)));
//		});
	});
	print(presentDates.length);
}
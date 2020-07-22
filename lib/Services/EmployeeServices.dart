import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Classes/UserBasic.dart';


class EmployeeServices{
	
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	Future<void> loginTimeRecord(UserBasic userBasic) async{
		
		dbf = firebaseDatabase.reference();
		DateFormat dateFormat = DateFormat("HH:mm");
		print(DateTime.now().toString().split(' ')[1]);
		DateTime startTime = dateFormat.parse(userBasic.startTime.split(' ')[0]);
		print(startTime);
		DateTime loginTime = dateFormat.parse(DateTime.now().toString().split(' ')[1]);
		print(loginTime);
		bool onTime =loginTime.isBefore(startTime);
		print(loginTime.difference(startTime));
		print(loginTime.difference(startTime).inHours);
		print("login Time Record");
		
		try {
			DateTime now = DateTime.now();
			dbf
					.child("Attendance")
					.child(userBasic.mobile)
					.child(now.year.toString())
					.child(now.month.toString())
					.child(now.day.toString())
					.set(onTime ? DateFormat('HH:mm:ss').format(now):DateFormat('HH:mm:ss').format(now).toString() + "_late");
		}catch(e){
			print(e.toString());
		}
	}
	
	
	Future<void> logoutTimeRecord(UserBasic userBasic) async{
		String loginTime;
		String loginTimeNote;
		DateTime now = DateTime.now();
		try {
			dbf = firebaseDatabase.reference()
					.child("Attendance")
					.child(userBasic.mobile)
					.child(now.year.toString())
					.child(now.month.toString())
					.child(now.day.toString());
			
			await dbf.once().then((DataSnapshot snapshot) async {
				print(snapshot.value);
				loginTimeNote = snapshot.value.toString().split('_')[1] != null? snapshot.value.toString().split('_')[1]:" ";
				loginTime = snapshot.value.toString().split('_')[0];
			});
			print(loginTime);
			DateFormat dateFormat = DateFormat('HH:mm:ss');
			DateTime dateTime1 = dateFormat.parse(loginTime);
			print(dateTime1);
			String temp = dateFormat.format(now);
			DateTime dateTime2 = dateFormat.parse(temp);
			print(dateTime2);
			print(userBasic.hours);
			int hours = int.parse(userBasic.hours.split(':')[0]);
			int workingHours = dateTime2
					.difference(dateTime1)
					.inHours;
			
			String log = " ";
			
			if (workingHours >= (hours / 2) + 1 && workingHours < hours) {
				log = loginTimeNote != ' '?"half_late" :"half";
			}
			else if(workingHours >= 0 && workingHours < (hours / 2) + 1) {
				log = loginTimeNote != ' '?"absent_late":'absent';
			}
			else{
				log = loginTimeNote != ' '?"full_late":'full';
			}
			
			dbf = firebaseDatabase.reference();
			await dbf.child("Attendance")
					.child(userBasic.mobile)
					.child(now.year.toString())
					.child(now.month.toString())
					.child(now.day.toString())
					.set(log);
		}catch(e){
			print("error");
			print(e);
		}
		
	}
	
}
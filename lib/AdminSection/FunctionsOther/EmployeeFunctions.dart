import 'package:firebase_database/firebase_database.dart';
import 'package:laundry/AdminSection/Class/EmployeeList.dart';
import 'package:laundry/AdminSection/Class/EmployeesAttendance.dart';
import 'package:laundry/Classes/JobHistory.dart';



Future<List<EmployeeList>> getEmployee() async{
	
	print("getEmployee");
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf ;
	
	List<EmployeeList> employeeData = [];
	List<dynamic> key = [];
	try {
		dbf = firebaseDatabase.reference()
				.child('Attendance');
		
		await dbf.once().then((DataSnapshot snapshot) async {
			Map<dynamic, dynamic> map = await snapshot.value;
			print(map);
			key = map.keys.toList();
			for (var v in key) {
				print(v.toString().split('_')[1]);
				employeeData.add(EmployeeList(
					name: v.toString().split('_')[1],
					id: v.toString().split('_')[2],
					phone: v.toString().split('_')[0],
				));
			}
		});
		print("returning");
		return employeeData;
	}catch(e){
		print(e.toString());
	}
	print("returning");
	return employeeData;
}


Future<EmployeeData> getEmployeeAttendance(EmployeeList employeeList) async{
	print("get Employee Attendance");
	int a =0 , p = 0 , h = 0 ;
	EmployeeData employeeData ;
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf ;
	
	dbf = firebaseDatabase.reference()
	       .child('Attendance')
	       .child(employeeList.phone +"_"+employeeList.name+"_"+employeeList.id)
	       .child(DateTime.now().year.toString())
	       .child(DateTime.now().month.toString());
	
	await dbf.once().then((DataSnapshot snapshot) async{
		Map<dynamic,dynamic> map = await snapshot.value;
		if(map != null){
		for(var v in map.values){
			if(v == "absent"){
				a=a+1;
			}
			else if(v == "full"){
				p = p+1;
			}
			else if(v == "half"){
				h = h +1;
			}
		}}
		
		else{
			a = 0 ; p =0 ; h =0 ;
		}
	});
	
	dbf = firebaseDatabase.reference()
			.child('EmployeeRecordDistance')
			.child(employeeList.phone +"_"+ employeeList.name+"_"+employeeList.id)
			.child(DateTime.now().year.toString())
			.child(DateTime.now().month.toString());
	
	await dbf.once().then((DataSnapshot snapshot) async{
		Map<dynamic,dynamic> map = await snapshot.value;
		if(map != null){
			employeeData = EmployeeData(
				absent: a.toString(),
				present: p.toString(),
				half: h.toString(),
				totalDistance: map["Distance"].toString(),
				totalTime:  map["Time"].toString(),
		);}
		
		else{
			employeeData = EmployeeData(
				absent: a.toString(),
				present: p.toString(),
				half: h.toString(),
				totalDistance: '0',
				totalTime: '0',
			);}
	});
	
	print(employeeData.totalDistance);
	return employeeData;
}

Future<List<JobHistory>> getEmployeeWorkHistory(EmployeeList employee) async{
	List<JobHistory> listOfJob = [];
	
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf ;
	
	try{
		dbf = firebaseDatabase.reference()
				.child('WorkHistory')
				.child(employee.phone +"_"+employee.name+"_"+employee.id)
				.child(DateTime.now().year.toString())
				.child(DateTime.now().month.toString());
		
		await dbf.once().then((DataSnapshot snapshot) async{
			Map<dynamic,dynamic> map = await snapshot.value;
			if(map !=null)
			for(var v in map.entries){
				listOfJob.add(JobHistory(
					url: v.value["url"],
					distance: v.value["distance"],
					time: v.value["time"],
					id: v.value["id"]
				));
			}
		});
		
		return listOfJob;
	}catch(e){
		print("error");
		print(e.toString());
		return null;
	}
}
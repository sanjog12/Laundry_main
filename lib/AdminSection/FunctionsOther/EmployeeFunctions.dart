import 'package:firebase_database/firebase_database.dart';
import 'package:laundry/AdminSection/Class/EmployeeList.dart';
import 'package:laundry/AdminSection/Class/EmployeesAttendance.dart';



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
		}
	});
	
	dbf = firebaseDatabase.reference()
			.child('EmployeeRecordDistance')
			.child(employeeList.phone +"_"+ employeeList.name+"_"+employeeList.id)
			.child(DateTime.now().year.toString())
			.child(DateTime.now().month.toString());
	
	await dbf.once().then((DataSnapshot snapshot) async{
		Map<dynamic,dynamic> map = await snapshot.value;
		employeeData = EmployeeData(
			absent: a.toString(),
			present: p.toString(),
			half: h.toString(),
			totalDistance: map["Distance"].toString(),
			totalTime: map["Time"].toString()
		);
	});
	
	print(employeeData.totalDistance);
	return employeeData;
}
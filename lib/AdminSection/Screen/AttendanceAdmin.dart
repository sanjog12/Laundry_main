import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:laundry/AdminSection/Class/EmployeeList.dart';
import 'package:laundry/AdminSection/Class/EmployeesAttendance.dart';
import 'package:laundry/AdminSection/FunctionsOther/EmployeeFunctions.dart';

class AttendanceAdmin extends StatefulWidget {
  @override
  _AttendanceAdminState createState() => _AttendanceAdminState();
}

class _AttendanceAdminState extends State<AttendanceAdmin> {
	
	List<EmployeeList> employeeList = [];
	bool waiting = false;
	
	Future<void> getEmployeeCall() async{
		await getEmployee().then((value) {
			setState(() {
				print(waiting);
				employeeList = value;
				employeeList.sort((a,b){
					print(a.name.compareTo(b.name));
					return a.name.compareTo(b.name);
				});
				waiting = true;
				print(waiting);
			});
		});
	}
	
	@override
  void initState() {
    super.initState();
    getEmployeeCall();
  }
	
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    title: Text("Attendance of Employees"),
	    ),
	    
	    body: Container(
		    padding: EdgeInsets.all(20),
		    child: Column(
			    crossAxisAlignment: CrossAxisAlignment.stretch,
			    children: <Widget>[
			    	waiting ?Expanded(
			    	  child: ListView.builder(
					    itemCount: employeeList.length,
						  itemBuilder: (BuildContext context , index){
					    	if(employeeList.length != 0) {
							    return Container(
								    margin: EdgeInsets.symmetric(horizontal: 10),
								    decoration: BoxDecoration(
									    border: Border.all(
										    width: 1
									    )
								    ),
								    child: ListTile(
									    title: Text(employeeList[index].id),
									    subtitle: Column(
										    crossAxisAlignment: CrossAxisAlignment.start,
									      children: <Widget>[
								          Text(employeeList[index].name),
									        Text(employeeList[index].phone),
									      ],
									    ),
									    onTap: () async{
										    EmployeeData employeeData;
										    loadingWindow(context);
									    	employeeData = await getEmployeeAttendance(employeeList[index]);
									    	print("test " +employeeData.present);
									    	Navigator.pop(context);
									    	detailedWindow(context, employeeData, employeeList[index]);
									    },
								    ),
							    );
						    }
					    	else{
					    		return Container(
								    child: Text("Nothing to show"),
							    );
						    }
						  }
				    ),
			    	):
						    Container(
							    child: CircularProgressIndicator(
								    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
							    ),
						    ),
			    ],
		    ),
	    ),
    );
  }
  
  Future<void> detailedWindow(BuildContext context, EmployeeData employeeData, EmployeeList employeeList){
		return showDialog(
			context: context,
			builder:(BuildContext context){
			return AlertDialog(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadiusDirectional.circular(10)
				),
				title: Text(employeeList.name),
				content: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						Divider(thickness: 1.5),
						Row(
							children: <Widget>[
								Text("Present :"),
								Text(employeeData.present),
							],
						),
						SizedBox(height: 5,),
						Row(
							children: <Widget>[
								Text("Absent :"),
								Text(employeeData.absent),
							],
						),
						SizedBox(height: 5,),
						Row(
							children: <Widget>[
								Text("Half Days :"),
								Text(employeeData.half)
							],
						),
						
						SizedBox(height: 15),
						Row(
							children: <Widget>[
								Text("Total Distance :"),
								Text(employeeData.totalDistance),
							],
						),
						SizedBox(height: 10,),
						Row(
							children: <Widget>[
								Text("Total Time :"),
								Text(employeeData.totalTime),
							],
						),
					],
				),
			);
			}
		);
  }
	
	Future<void> loadingWindow (BuildContext context){
		return showDialog(
				context: context,
				builder:(BuildContext context){
					return AlertDialog(
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadiusDirectional.circular(10)
						),
						content: Container(
							padding: EdgeInsets.all(10),
							child: Center(child: CircularProgressIndicator()),
						),
					);
				}
		);
	}
}

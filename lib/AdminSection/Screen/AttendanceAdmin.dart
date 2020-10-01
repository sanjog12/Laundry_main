import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:laundry/AdminSection/Class/EmployeeList.dart';
import 'package:laundry/AdminSection/Class/EmployeesAttendance.dart';
import 'package:laundry/AdminSection/FunctionsOther/EmployeeFunctions.dart';
import 'package:laundry/AdminSection/Screen/EmployeeWorkHistory.dart';

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
				backgroundColor: Color.fromRGBO(2, 124, 149, 1),
				elevation: 8,
				iconTheme: IconThemeData(
					color:Colors.blue[100],
				),
		    title: Text(
					"EMPLOYEE ATTENDANCE",
					style: TextStyle(
						fontWeight: FontWeight.bold,
						fontFamily: "OpenSans",
						letterSpacing: 1.0,
						color:Color.fromRGBO(255, 255, 255, 1),
					),
				),
				centerTitle: true,
	    ),
	    
	    body: Container(
				height: MediaQuery.of(context).size.height,
				width: MediaQuery.of(context).size.width,
		    padding: EdgeInsets.all(20),
		    child: Column(
			    crossAxisAlignment: CrossAxisAlignment.center,
			    children: <Widget>[
			    	waiting ?Expanded(
			    	  child: ListView.builder(
					    itemCount: employeeList.length,
						  itemBuilder: (BuildContext context , index){
					    	if(employeeList.length != 0) {
							    return Container(
										height: 120,
								    margin: EdgeInsets.symmetric(horizontal: 10),
								    child: Card(
											elevation: 3,
											shape: RoundedRectangleBorder(
												borderRadius: BorderRadius.circular(15),
											),
											color: Colors.blueGrey[50],
								      child: ListTile(
											leading: Icon(
												Icons.view_module,
												color: Colors.blueGrey[700],
											),
									    title: Padding(
									      padding: EdgeInsets.only(top:10.0),
									      child: Text(
										      employeeList[index].id,
										      style: TextStyle(
												      fontWeight: FontWeight.w800, fontFamily: "OpenSans", letterSpacing: .5, fontSize: 20,
												      color: Color.fromRGBO(88, 89, 91,1)
										      ),
									      ),
									    ),
									      subtitle: Column(
										      crossAxisAlignment: CrossAxisAlignment.start,
										      children: <Widget>[
										      	Divider(thickness: 1.5,),
											      Text(
												      employeeList[index].name,
												      style: TextStyle(
														      fontWeight: FontWeight.w800,
														      fontFamily: "OpenSans",
														      letterSpacing: .5,
																	fontSize: 14,
																	color: Color.fromRGBO(88, 89, 91,1)
												      ),
											      ),
											      SizedBox(
												      height: 5,
											      ),
											      Text(
												      employeeList[index].phone,
												      style: TextStyle(
														      fontWeight: FontWeight.w800,
														      fontFamily: "OpenSans",
														      letterSpacing: .5,
														      fontSize: 12,
														      color: Color.fromRGBO(88, 89, 91,1)
												      ),
											      ),
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
									      
									      onLongPress: () async{
												Navigator.push(context,
													MaterialPageRoute(
														builder: (context) => EmployeeWorkHistory(
															employeeList: employeeList[index],
														)
													),
												);
									      },
								      ),
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
				    Center(
					    child: Container(
						    child: CircularProgressIndicator(
							    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[700]),
						    ),
					    ),
				    ),
			    ],
		    ),
		    decoration: BoxDecoration(
			    image: DecorationImage(
				    image: AssetImage("images/12.jpg"),
				    fit: BoxFit.fill,
			    ),
		    ),
	    ),
    );
	}
  
  Future<void> detailedWindow(BuildContext context, EmployeeData employeeData, EmployeeList employeeList){
		return showDialog(
			context: context,
			builder:(BuildContext context){
			return AlertDialog(
				backgroundColor: Colors.blueGrey[50],
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(15),
					side: BorderSide(
						color: Colors.lightBlue[400],
						width: 3
					)
				),
				title: Text(
						employeeList.name,
					style: TextStyle(
							fontWeight: FontWeight.w800,
							fontFamily: "OpenSans",
							letterSpacing: .5,
							fontSize: 20,
							color: Color.fromRGBO(88, 89, 91,1)
					),
				),
				content: Container(
					height: 200,
				  child: Column(
				  	crossAxisAlignment: CrossAxisAlignment.start,
				  	children: <Widget>[
				  		Divider(thickness: 1.5),
				  		Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  			children: <Widget>[
				  				Text(
											"Present :",
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  				Text(
											employeeData.present,
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  			],
				  		),
				  		SizedBox(height: 5,),
				  		Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  			children: <Widget>[
				  				Text(
											"Absent :",
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  				Text(
											employeeData.absent,
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  			],
				  		),
				  		SizedBox(height: 5,),
				  		Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  			children: <Widget>[
				  				Text(
											"Half Days :",
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  				Text(
											employeeData.half,
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									)
				  			],
				  		),
				  		SizedBox(height: 5),
				  		Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  			children: <Widget>[
				  				Text(
											"Total Distance :",
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  				Text(
											employeeData.totalDistance,
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  			],
				  		),
				  		SizedBox(height: 5,),
				  		Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  			children: <Widget>[
				  				Text(
											"Total Time :",
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  				Text(
											employeeData.totalTime,
										style: TextStyle(
												fontWeight: FontWeight.w800,
												fontFamily: "OpenSans",
												letterSpacing: .5,
												fontSize: 16,
												color: Color.fromRGBO(88, 89, 91,1)
										),
									),
				  			],
				  		),
				  	],
				  ),
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
							height: 100,
							padding: EdgeInsets.all(10),
							child: Center(child: CircularProgressIndicator(
								valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[700]),
							)),
						),
					);
				}
		);
	}
}

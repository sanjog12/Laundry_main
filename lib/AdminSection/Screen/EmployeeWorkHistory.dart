import 'package:flutter/material.dart';
import 'package:laundry/AdminSection/Class/EmployeeList.dart';
import 'package:laundry/AdminSection/FunctionsOther/EmployeeFunctions.dart';
import 'package:laundry/Classes/JobHistory.dart';
import 'package:laundry/others/ShowImage.dart';



class EmployeeWorkHistory extends StatefulWidget {
	final EmployeeList employeeList;

  const EmployeeWorkHistory({Key key, this.employeeList}) : super(key: key);
	
	
  @override
  _EmployeeWorkHistoryState createState() => _EmployeeWorkHistoryState();
}

class _EmployeeWorkHistoryState extends State<EmployeeWorkHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    backgroundColor: Colors.blueGrey[700],
		    elevation: 8,
		    iconTheme: IconThemeData(
			    color:Colors.blue[100],
		    ),
		    title: Text(
			    "EMPLOYEE WORK History",
			    style: TextStyle(
				    fontWeight: FontWeight.bold,
				    fontFamily: "OpenSans",
				    letterSpacing: 1.0,
				    color:Colors.blue[100],
			    ),
		    ),
		    centerTitle: true,
	    ),
	    
	    body: Container(
			    decoration: BoxDecoration(
					    image: DecorationImage(
							    image: AssetImage("images/12.jpg"),
							    fit: BoxFit.fill
					    )
			    ),
			    padding: EdgeInsets.all(18),
		      child: FutureBuilder<List<JobHistory>>(
			      future: getEmployeeWorkHistory(widget.employeeList),
			      builder: (BuildContext context, AsyncSnapshot<List<JobHistory>> snapshot){
			    	  if(snapshot.data != null)
			    	  return ListView.builder(
						    itemCount: snapshot.data.length,
					      itemBuilder: (context,index){
						    	print(snapshot.data.length);
						    	if(snapshot.data.length != 0){
						  	  return Card(
								    shape: RoundedRectangleBorder(
									    borderRadius: BorderRadius.circular(15)
								    ),
								    elevation: 20,
						  	    child: Container(
								    padding: EdgeInsets.symmetric(vertical: 10),
									    decoration: BoxDecoration(
											    color: Colors.white,
											    borderRadius: BorderRadiusDirectional.circular(10)
									    ),
									    child: ListTile(
										    title: Text("Job ID : "+snapshot.data[index].id),
										    subtitle: Column(
											    crossAxisAlignment: CrossAxisAlignment.start,
											    children: <Widget>[
												    Divider(thickness: 1.5,),
												    SizedBox(height: 5),
												    Text("Distance Covered : " + snapshot.data[index].distance),
												    SizedBox(height: 5),
												    Text("Time Taken : " + snapshot.data[index].time),
											    ],
										    ),
										    onTap: (){
										    	print(snapshot.data[index].url);
											    showImage(context, snapshot.data[index].url.toString());
										    },
									    )
							    ),
						  	  );}
						    	else{
						    		print("else");
						    		return Container(
									    child: Center(
										    child: Text("No work found"),
									    ),
						    		);
							    }
					      },
				      );
			    	
			    	  else{
			    		  return Container(
						     child: Center(
							    child: CircularProgressIndicator(
								    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
							    ),
						    ),
					    );
				    }
			    },
		    )
	    ),
    );
  }
}

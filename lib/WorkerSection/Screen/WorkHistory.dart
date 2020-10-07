import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:laundry/Classes/JobHistory.dart';
import 'package:laundry/Classes/MonthDetail.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/EmployeeServices.dart';
import 'package:laundry/others/ShowImage.dart';


class WorkHistory extends StatefulWidget {
	
	final UserBasic userBasic;
  const WorkHistory({Key key, this.userBasic}) : super(key: key);
	
  @override
  _WorkHistoryState createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
	
	List<JobHistory> jobHistory =[];
	bool imageLoader = true;
	bool dataLoader = true;
	MonthDetails monthDetails = MonthDetails();
	
	@override
  void initState() {
    super.initState();
    EmployeeServices().getJobHistory(widget.userBasic).then((value){
    	jobHistory = value;
    });
    EmployeeServices().getMonthlyDetails(widget.userBasic).then((value) async{
    	monthDetails =  value;
    	print(monthDetails.distance);
    	setState(() {
    	  dataLoader = false;
    	});
    });
  }
	
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    backgroundColor: Color.fromRGBO(2, 124, 149, 1),
		    title: Text("Job History",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
	    ),
	    
	    body: Container(
				      padding: EdgeInsets.all(15),
				      decoration: BoxDecoration(
					      image: DecorationImage(
							      image: AssetImage("images/12.jpg"),
							      fit: BoxFit.fill
					      )
				      ),
				      child: Column(
					      crossAxisAlignment: CrossAxisAlignment.stretch,
					      children: <Widget>[
					      	Row(
							      mainAxisSize: MainAxisSize.min,
					          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							      children: <Widget>[
							      	Card(
									      color: Colors.blueGrey[700],
									      elevation: 10,
									      child: Container(
										      padding: EdgeInsets.all(24),
										      child: Column(
											      children: <Widget>[
											      	Text("Distance ",style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.blue[100]),),
												      Divider(thickness: 2, color: Colors.white,),
												      dataLoader ? Text(' ')
														      :Text(monthDetails.distance + " km",style: TextStyle(fontSize: 25,color: Colors.blue[100]),),
											      ],
										      ),
									      ),
								      ),
								      
								      Card(
									      color: Colors.blueGrey[700],
									      elevation: 2,
									      child: Container(
										      padding: EdgeInsets.all(24),
										      child: Column(
											      children: <Widget>[
											      	Text("Time ",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic, color: Colors.blue[100]),),
												      Divider(thickness: 2,color: Colors.white,),
												      dataLoader ? Text(" ")
														      :Text(monthDetails.time + " min",style: TextStyle(fontSize: 25,color: Colors.blue[100])),
											      ],
										      ),
									      ),
								      ),
							      ],
						      ),
						      Divider(thickness: 2,),
						      SizedBox(height: 20,),
						      Text("Completed Work Detail ",textAlign: TextAlign.center,style: TextStyle(fontSize:22,color: Colors.black,fontWeight: FontWeight.bold),),
						      SizedBox(height: 10,),
						      
						      Expanded(
						        child: ListView.builder(
							      itemCount: jobHistory.length,
							      itemBuilder: (context,index){
							      	return Container(
									      decoration: BoxDecoration(
										      color: Colors.white,
										      borderRadius: BorderRadiusDirectional.circular(10)
									      ),
									      child: ListTile(
										      title: Text("Job ID : "+jobHistory[index].id),
										      subtitle: Column(
											      crossAxisAlignment: CrossAxisAlignment.start,
											      children: <Widget>[
											      	Divider(thickness: 1.5,),
											      	SizedBox(height: 5),
											      	Text("Distance Covered : " +jobHistory[index].distance),
												      SizedBox(height: 5),
												      Text("Time Taken : " + jobHistory[index].time),
											      ],
										      ),
										      onTap: (){
										      	showImage(context, jobHistory[index].url.toString());
										      },
									      )
								      );},
						        ),
						      )
					      ],
				      ),
		      ),
    );
  }
}

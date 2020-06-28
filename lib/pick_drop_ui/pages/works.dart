/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/work_details_card.dart';


class Work extends StatefulWidget {
  final UserAuth userAuth;

  const Work({Key key, this.userAuth}) : super(key: key);
  @override
  _WorkState createState() => _WorkState();
}



class _WorkState extends State<Work> {
  
  double lat;
  double long;
  var workData;
  String uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference dbf;

  Future<List<Job>> getData() async{
    print("Called");
    List<Job> jobList = [];
    uid = await SharedPrefs.getStringPreference('uid');
    print(uid);
    dbf = firebaseDatabase.reference().child("Jobs").child(uid);
    await dbf.once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values =snapshot.value;
      if(values != null){
      values.forEach((key, value) {
        print(key);
        Job job = Job(
          id: key,
          customerName: value["Name"],
          address: value["Address"],
          lat: value["Lat"],
          long: value["Long"],
        );
        jobList.add(job);
      });
      }else{
        Job job = Job(
          id: "0000",
          customerName: "No assigned Job",
          address: " ",
          lat: " ",
          long: " ",
        );
        jobList.add(job);
      }
    });
    print(jobList.length);
    return jobList;
  }
  
  
  
  @override
  void initState() {
    super.initState();
  }
  
  
  fetchWorkDetails(){
      return StreamBuilder<List<Job>>(
        stream: getData().asStream(),
        builder: (context,AsyncSnapshot<List<Job>> snapshot){
          print(snapshot.hasData);
          if(!snapshot.hasData){
            return Center(
              child:CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
              ),
            );
          }else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context,int index){
              return workCards(context,snapshot.data[index], widget.userAuth);
            },
          );
          }
        },
      );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue[100]
        ),
        title: Text(
          "JOBS ASSIGNED",
        style: TextStyle(
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          color: Colors.blue[100]
,        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      
      body:  Container(
        padding: EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder:(BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapShot){
              if (!snapShot.hasData) return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>
                  (Colors.blueGrey),
              ));
              var result = snapShot.data;
              switch (result){
                case ConnectivityResult.none:
                  return Container(padding:EdgeInsets.all(10),child: InternetCheck());
                case ConnectivityResult.mobile:
                case ConnectivityResult.wifi:
                  return fetchWorkDetails();
                default:
                  return Container(padding: EdgeInsets.all(10),child: InternetCheck());
              }
            } ),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/12.jpg"),
    fit: BoxFit.fill,
    ),
      ),
    ),
    );
  }
}



class InternetCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
	      height : 200,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/network.gif'),fit: BoxFit.contain),
            borderRadius:BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}



workCards(BuildContext context, Job job, UserAuth userAuth) {
  print(job.customerName);
  print(job.address);
  print(job.lat + " " + job.long);
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.blueGrey[50],
        child: InkWell(
          splashColor: Colors.blue[100].withAlpha(100),
          onTap: () {
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading: job.address!=" "?Icon(Icons.view_module,
                color: Colors.blueGrey[700],):Text(""),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2,),
                    Text(
                      job.customerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: .5,
                        fontSize: 19,
                        color: Color.fromRGBO(88, 89, 91,1)
                      ),
                    ),
                  ],
                ),
                subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    job.address != " "?Text('DESTINATION :',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),):Text(""),
                    SizedBox(height: 5,),
                    Text(job.address,
                    style: TextStyle(
                      fontSize: 12,
                      color:Color.fromRGBO(88, 89, 91,1)
                    ),
                    ),
                  ],
                ),
              ),
              
              
              
              ButtonBar(
                children: <Widget>[
                  job.address != " "?RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color:Colors.blueGrey[700],
                    child: Text(
                        'OPEN',
                      style: TextStyle(
                        color: Colors.blue[100],
                      ),
                    ),
                    onPressed: () {
                      print(userAuth.email);
                      workDescription(context, job, userAuth);
                    },
                    focusElevation: 15,
                  ):Container(),
                  SizedBox(width: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



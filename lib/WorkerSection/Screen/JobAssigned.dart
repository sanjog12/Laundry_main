/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/WorkerSection/Screen/JobDetailScreen.dart';


class Work extends StatefulWidget{
  final UserBasic userBasic;
  const Work({Key key, this.userBasic}) : super(key: key);
  @override
  _WorkState createState() => _WorkState();
}



class _WorkState extends State<Work> {
  
  double lat;
  double long;
  var workData;
  String uid;
  
  Future<Position> getPosition(String address) async{
    
    List<Placemark> placeMark = [];
    print(address);
    try {
      placeMark = await Geolocator().placemarkFromAddress("India Gate ,New Delhi");
      return placeMark.first.position;
    }on PlatformException catch(e){
      print(e.message);
      return null;
    } catch(e){
      print(e);
      return null;
    }
}
  
  
  Future<List<Job>> getData() async{
    List<Job> job = [];
    print("http://208.109.15.34:8081/api/Employee/v1/GetAllJobListById/${widget.userBasic.userID}");
    http.Response response = await  http.get("http://208.109.15.34:8081/api/Employee/v1/GetAllJobListById/${widget.userBasic.userID}");
    
    var ra = jsonDecode(response.body);
    print(ra);
    
    for(var value in ra['Entity']){
      Job j = Job(
        customerName: value['CustomerName'].toString(), id: value['Id'].toString(), customerId: value['CustomerId'].toString(), storeId: value['StoreId'].toString(),
        jobId: value['JobId'].toString(), jobName: value['JobName'].toString(), userId: value['UserId'].toString(),
        isCompleted: value['IsCompleted'].toString(), isPending: value['IsPending'].toString(),
        createdBy: value['CreatedBy'].toString(), modifiedBy: value['ModifiedBy'].toString(), createdDate: value['CreatedDate'].toString(),
        modifiedDate: value['ModifiedDate'].toString(),
        isDeleted: value['IsDeleted'].toString(), store: value['Store'].toString(),
        customerAddress: value['CustomerAddress'].toString(), customerMobile: value['CustomerMobile'].toString(),
        userName: value['UserName'].toString(), completed: value['Completed'].toString(), pending: value['Pending'].toString(),
        position: await getPosition(await value['CustomerAddress'])
      );
      if(j.position != null){
        job.add(j);
      }
    }
    
    return job;
  }
  
  
  
  @override
  void initState() {
    super.initState();
    getData();
    DateFormat dateFormat = DateFormat('HH:mm:ss');
    DateTime dateTime = dateFormat.parse('8:40:23');
    DateTime dateTime2 = dateFormat.parse(DateTime.now().toString().split(' ')[1]);
    print("test " + dateTime2.isAfter(dateTime).toString());
  }
  
  
  fetchWorkDetails(){
      return StreamBuilder<List<Job>>(
        stream: getData().asStream(),
        builder: (context,AsyncSnapshot<List<Job>> snapshot){
          print(snapshot.hasData);
          if(!snapshot.hasData){
            return Center(
              child:CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[700]),
              ),
            );
          }else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context,int index){
              return workCards(context,snapshot.data[index], widget.userBasic);
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/12.jpg"),
              fit: BoxFit.fill
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder:(BuildContext context, AsyncSnapshot<ConnectivityResult> snapShot){
              if (!snapShot.hasData) return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>
                  (Colors.blueGrey[700]),
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
            }),
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
            image: DecorationImage(image: AssetImage('images/network.gif'), fit: BoxFit.contain),
            borderRadius:BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}

Widget workCards(BuildContext context, Job job, UserBasic userBasic){
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
                leading: job.customerAddress!=" "?Icon(Icons.view_module,
                color: Colors.blueGrey[700],):Text(""),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2,),
                    Text(
                      job.customerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: "OpenSans",
                        letterSpacing: .5,
                        fontSize: 19,
                        color: Color.fromRGBO(88, 89, 91,1)
                      ),
                    ),
                    Divider(thickness: 1.5,)
                  ],
                ),
                subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
//                    SizedBox(height: 5,),
                    job.customerAddress != " "?RichText(
                      text:TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text: 'Direction: ',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",
                              color: Color.fromRGBO(88, 89, 91,1),
                              fontSize: 12)),
                          TextSpan(text: job.customerAddress,style: TextStyle(
                              fontSize: 12,
                              fontFamily: "OpenSans",
                              color:Color.fromRGBO(88, 89, 91,1)
                          )),
                        ]
                      ),
                      overflow: TextOverflow.clip,
                    ):Text(""),
                    
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text('Mobile: ',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                            fontSize: 12
                        ),),
                        Text(job.customerMobile,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "OpenSans",
                              color:Color.fromRGBO(88, 89, 91,1)
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              
              ButtonBar(
                children: <Widget>[
                  job.customerAddress != " "?RaisedButton(
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
                      print(userBasic.mobile);
                      workDescription(context, job, userBasic);
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
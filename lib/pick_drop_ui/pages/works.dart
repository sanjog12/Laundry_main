/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserDetails.dart';
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
  var workData;                         ///Variable to get the snapshot of the works available in the firestore

  getData() => Firestore.instance.collection('Jobs').snapshots();
  
  
  
  @override
  void initState() {
    super.initState();
    setState(() {
      workData = getData();
    });
  }
  
  
  fetchWorkDetails(){
    if(workData == null){
      print("getting workdata");
    }else{
      return StreamBuilder(
        stream: workData,
        builder: (context,snapshot){
          if(snapshot.data == null){
            return Center(
              child:CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
              ),
            );
          }else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,i){
              return workCards(context,snapshot.data.documents[i].data['Name of customer'],snapshot.data.documents[i].data['Address'],widget.userAuth);
            },
          );
          }
        },
      );
    }
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



workCards(BuildContext context ,name,address,UserAuth userAuth) {
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
                leading: Icon(Icons.view_module,
                color: Colors.blueGrey[700],),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2,),
                    Text(
                      name,
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
                    Text('DESTINATION :',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),),
                    SizedBox(height: 5,),
                    Text(address,
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
                  RaisedButton(
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
                      workDescription(context, name, address,userAuth);
                    },
                    focusElevation: 15,
                  ),
                  SizedBox(width: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



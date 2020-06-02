/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/work_details_card.dart';


class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}



class _WorkState extends State<Work> {
  
  double lat;
  double long;
  var workData;                         ///Variable to get the snapshot of the works available in the firestore

  getData() {
    return Firestore.instance.collection('Jobs').snapshots();
  }
  
  @override
  void initState() {
    super.initState();
    setState(() {
      workData = getData();
    });
  }
  
  
  fetchWorkDetails(){
    /*
    Function to get data from the cloud_firebase and displaying details in the ListView as soon as the
    the details are uploaded in the the fire_store
     */
    if(workData == null){
      print("getting workdata");
    }else{
      return StreamBuilder(
        stream: workData,
        builder: (context,snapshot){
          if(snapshot.data == null){
            return Center(
              child:CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                semanticsLabel: 'Loading ......',
              ),
            );
          }else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,i){
              return WorkCards(snapshot.data.documents[i].data['Name of customer'],snapshot.data.documents[i].data['Address']);
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
        title: Text(
          "JOBS ASSIGNED",
        style: TextStyle(
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent[200],
      ),
      
      body:  StreamBuilder(
	      /*
	         To check whether net is connected or not when the user opens work page
	       */
          stream: Connectivity().onConnectivityChanged,
          builder:(BuildContext context,
              AsyncSnapshot<ConnectivityResult> snapShot){
            if (!snapShot.hasData) return CircularProgressIndicator();
            var result = snapShot.data;
            switch (result){
              case ConnectivityResult.none:
                return Padding(padding: EdgeInsets.all(10.0),child: InternetCheck());
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
                return fetchWorkDetails();
              default:
                return Padding(padding: EdgeInsets.all(10.0),child: InternetCheck());
            }
          } ),
    );
  }
}




class InternetCheck extends StatelessWidget {
  /*
    Image to show whether net is connected or not
   */
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



class WorkCards extends StatelessWidget{
  /*
  Class to generate TileView from the gathered data from from the fire_store
   */
  
  final  name;
  final  address;
  WorkCards(this.name,this.address);
  
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      child: InkWell(
        splashColor: Colors.blue[100].withAlpha(100),
        onTap: () {
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.view_module,
              color: Colors.grey[700],),
              title: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: .5,
                ),
              ),
              subtitle:  Text(address),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('OPEN'),
                  onPressed: () {
                    workDescription(context, name, address);
                  },
                  focusElevation: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



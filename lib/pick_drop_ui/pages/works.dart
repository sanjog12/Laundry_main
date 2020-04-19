/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/work_discription_1.dart';

class work extends StatefulWidget {
  @override
  _workState createState() => _workState();
}

class _workState extends State<work> {
  
  var workdata;                        //Variable to get the snapshot of the works available in the firestore
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      workdata = getData();
    });
  }
  
  
  get_work_details(){
    /*
    Function to get data from the cloud_firebase and displaying details in the ListView as soon as the
    the details are uploaded in the the fire_store
     */
    if(workdata != null){
      return StreamBuilder(
        stream: workdata,
        builder: (context,snapshot){
          if(snapshot.data != null){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,i){
              return workcards(snapshot.data.documents[i].data['Name of customer'],snapshot.data.documents[i].data['Address']);
            },
          );
          }else{
            return Text("Malfunction");
          }
        },
      );
    }else{
      print("getting workdata");
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs Assigned"),
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
                return Padding(padding: EdgeInsets.all(10.0),child: Malfunction());
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
                return get_work_details();
              default:
                return Padding(padding: EdgeInsets.all(10.0),child: Malfunction());
            }
          } ),
    );
  }
}
class Malfunction extends StatelessWidget {
  
  /*
    Image to show whether net is connected or not
   */
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

getData() {
  return Firestore.instance.collection('Jobs').snapshots();
}


class workcards extends StatelessWidget{
  /*
  Class to generate TileView from the gathered data from from the fire_store
   */
  final  name;
  final  address;
  workcards(this.name,this.address);
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.blueGrey[50],
      child: InkWell(
        splashColor: Colors.blue[100].withAlpha(100),
        onTap: () {
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.view_module),
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
                  	work_description(context,name, address);
                  },
                  focusElevation: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



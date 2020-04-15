/* All the information related to the work assigned to the worker
will be shown here in the form of the tile view form here the worker
can select the work and start navigation and all the distance and the
 */
 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class work extends StatefulWidget {
  @override
  _workState createState() => _workState();
}

class _workState extends State<work> {
  
  var workdata;                        //Variable to get the snapshort of the works available in the firestore
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Called work");
    setState(() {
      workdata = getData();
    });
  }
  
  
  getworkdetails(){
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
      
      body: getworkdetails(),
    );
  }
}


getData() {
  return Firestore.instance.collection('Jobs').snapshots();
}


class workcards extends StatelessWidget{
  
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
                  child: const Text('OPEN'),
                  onPressed: () {/* ... */},
                  focusElevation: 10,
                ),
                RaisedButton(
                  child: const Text('SHARE'),
                  onPressed: () {/* ... */},
                  focusElevation: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
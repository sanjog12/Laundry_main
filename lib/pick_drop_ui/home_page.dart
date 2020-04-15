/* Home page of the pick and drop worker */


import "package:flutter/material.dart";
import 'package:laundry/pick_drop_ui/pages/works.dart';


class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi user'),
      ),
      
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text("Works assigned"),
                    onPressed: (){
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => work()),
                      );
                    },
                  ),
                ),
                
                Container(
                  child: RaisedButton(
                    child: Text("2nd "),
                  ),
                ),
              ],
            ),
  
            Row(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text("3rd"),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => work()),
                      );
                    },
                  ),
                ),
      
                Container(
                  child: RaisedButton(
                    child: Text(" 4th "),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

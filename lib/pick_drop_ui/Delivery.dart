import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';
class Delivery extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DeliveryState();
  }
}
class DeliveryState extends State<Delivery>{
  bool i= true;
  Container j;
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        j= Container(
          height: 350,
          width: 350,
          child: FlareActor("images/success.flr", alignment:Alignment.center,
            fit: BoxFit.contain,
            animation: i == true ? 'go' : 'idle',),);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 30.0,),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width-30,
                      height: MediaQuery.of(context).size.height/2-100,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage("images/image1.jpg"),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      "You’ve completed your ride!",
                      style: TextStyle(fontSize: 25,fontFamily: "phagspa",fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 240.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("5.2",
                                  style: TextStyle(fontSize: 45,color: Color(0xFF027C95),fontWeight: FontWeight.bold,fontFamily: "Franklin"),),
                                SizedBox(width: 8,),
                                Padding(
                                  padding: EdgeInsets.only(top:13),
                                  child: Text("km",
                                    style: TextStyle(fontSize: 25,color: Color(0xFF027C95),fontWeight: FontWeight.bold,fontFamily: "Franklin"),),
                                ),
                              ],
                            ),
                            Text("Distance",
                              style: TextStyle(fontSize: 30,color: Color(0xFF15241D),fontWeight: FontWeight.bold,fontFamily: "Myriad_Bold"),),
                          ],
                        ),
                        SizedBox(width: 70.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("23",
                                  style: TextStyle(fontSize: 45,color: Color(0xFF027C95),fontWeight: FontWeight.bold,fontFamily: "Franklin"),),
                                SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(top:12),
                                  child: Text("min",
                                    style: TextStyle(fontSize: 25,color: Color(0xFF027C95),fontWeight: FontWeight.bold,fontFamily: "Franklin"),),
                                ),
                              ],
                            ),
                            Text("Ride time",
                              style: TextStyle(fontSize: 30,color: Color(0xFF15241D),fontWeight: FontWeight.bold,fontFamily: "Myriad_Bold"),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 280.0,left: 20.0),
                    child: j
                ),
              ],
            )
          ],
        )
    );
  }
}

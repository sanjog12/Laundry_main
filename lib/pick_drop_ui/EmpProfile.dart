import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';
class Empprofile extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profile(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
class profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    // TODO: implement createState
    return profilestate();
  }
}
class profilestate extends State<profile>{
 int ID=123456;
 int mobile=8899123034;
 bool i= false;
 bool j= false;
 double font1 = 14.0;
 double font2=14.0;
  @override
  Widget build(BuildContext context)
  {
    Widget Details;
    if(i){
      Details =Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
             Icon(
               Icons.location_on,
               size: 35,
               color: Colors.blueGrey[600],
             ),
              Text(
                "( Current Address of Employee )",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 21,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(
                Icons.home,
                size: 35,
                color: Colors.blueGrey[600],
              ),
              Text(
                "( Permanent Address Of Employee )",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 21,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(
                Icons.email,
                size: 35,
                color: Colors.blueGrey[600],
              ),
              Text(
                "( laundryemployee19999@gmail.com )",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 21,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(
                Icons.add,
                size: 35,
                color: Colors.blueGrey[600],
              ),
            ],
          ),
          SizedBox(height: 21,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(
                Icons.add,
                size: 35,
                color: Colors.blueGrey[600],
              ),
            ],
          ),
        ],
      );
    }
    else if(j){
     Details = Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
         SizedBox(height: 5,),
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             SizedBox(width: 10,),
             Icon(
               Icons.work,
               size: 35,
               color: Colors.blueGrey[600],
             ),
             SizedBox(width: 10,),
             Text(
                 ("( 3 years of Work Experiance )"),
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w600,
                 color: Colors.blueGrey[700],
               ),
             ),
           ],
         ),
         SizedBox(height: 60,),
         Text(
           ("( OTHER DETAILS.... )"),
           style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600,
             color: Colors.blueGrey[700],
           ),
         ),
       ],
     );
    }
    return Scaffold(
      body: Stack(
       children: <Widget>[
          Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           child:Image(
             image: AssetImage("images/12.jpg"),
             fit: BoxFit.cover,
             //colorBlendMode: BlendMode.darken,
           ),
         ),
         Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height/2-30,
           decoration: BoxDecoration(
               color: Colors.blueGrey[500],
                 border: Border.all(
                   color: Colors.blueGrey[700],
                 width: 6,
           ),
           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),topLeft: Radius.circular(15),topRight: Radius.circular(15))
         ),
           child: Column(
             children: <Widget>[
                Row(
                 children: <Widget>[
                   Padding(
                     padding:EdgeInsets.only(top:50.0,left: 15.0),
                     child: Container(
                       width: 108,
                       height:108,
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage("images/profileimg.png"),
                           fit: BoxFit.cover,
                         ),
                         borderRadius: BorderRadius.circular(100.0),
                         border: Border.all(
                           color: Colors.blueGrey[50],
                           width: 6.0,
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: 50.0,left: 20.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(
                           "Laundry Employee",
                           style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.blueGrey[50],

                           ),
                         ),
                         SizedBox(height: 3,),
                         Text(
                           "EMP ID: $ID",
                           style: TextStyle(
                               fontSize: 15,
                               color: Colors.blueGrey[50],

                           ),
                         ),
                         SizedBox(height: 3,),
                         Text(
                           "Mobile: $mobile",
                           style: TextStyle(
                               fontSize: 15,
                               color: Colors.blueGrey[50],

                           ),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
               SizedBox(height: 70,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   SizedBox(width: 1,),
                   Column(
                     children: <Widget>[
                       Text("3.6", style: TextStyle(
                           color: Colors.blueGrey[50],
                           fontSize: 20,
                           fontWeight: FontWeight.bold
                       ),),
                       Text("Rating", style: TextStyle(
                         color: Colors.blueGrey[50],
                         fontSize: 15,
                       ),),
                     ],
                   ),
                   Column(
                     children: <Widget>[
                       Text("72%", style: TextStyle(
                           color: Colors.blueGrey[50],
                           fontSize: 20,
                           fontWeight: FontWeight.bold
                       ),),
                       Text("Completed/given", style: TextStyle(
                         color: Colors.blueGrey[50],
                         fontSize: 15,
                       ),),
                     ],
                   ),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context,
                           MaterialPageRoute(
                               builder: (context)=>HomePage()
                           )
                       );
                     },
                     child: Container(
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.blueGrey[50]),
                       borderRadius: BorderRadius.circular(5.0),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("EDIT PROFILE", style: TextStyle(
                         color: Colors.blueGrey[50],
                         fontSize: 12,
                       ),),
                     ),
                   ),
                   ),
                   SizedBox(width: 1,),
                 ],
               )
             ],
           ),
         ),
        Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      i=true;
                      j= false;
                      font1=18.0;
                      font2=14.0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[500],
                      border: Border.all(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Persional Info", style: TextStyle(
                        color: Colors.blueGrey[50],
                        fontSize: font1,
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                   setState(() {
                    j=true;
                    i= false;
                     font2=18.0;
                     font1=14.0;
                   });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[500],
                      border: Border.all(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("     Work Info     ", style: TextStyle(
                        color: Colors.blueGrey[50],
                        fontSize: font2,
                      ),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
         Padding(
           padding: EdgeInsets.only(top: 410.0),
           child: Container(
             decoration: BoxDecoration(
               border: Border.all(color: Colors.black12),
               borderRadius: BorderRadius.circular(25.0),
             ),
             height: 290,
             width: MediaQuery.of(context).size.width,
             child: Details,
           ),
         )
         ]
           )
    );
  }
}

/* Home page of the pick and drop worker */


import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:laundry/pick_drop_ui/pages/works.dart';


class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  Widget _buildProfileImage(){               //Image widget in sliver app bar
    return Center(
      child: Container(
        width: 180,
        height:180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/profile1.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Colors.blueGrey[50],
            width: 6.0,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              iconTheme: IconThemeData(
                color: Colors.blueGrey[50]
              ),
              flexibleSpace: FlexibleSpaceBar(
                title:Padding(
                  padding: EdgeInsets.fromLTRB(20,12,9,12),
                  child: Text(
                    "Person Name",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[50],
                      fontFamily: "OpenSans",
                      letterSpacing: 0.5
                    ),
                  ),
                ),
                background: _buildProfileImage(),
                ),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                      Icons.more_vert,
                    color: Colors.blueGrey[50],
                  ),
                  onPressed: (){},
                ),
              ],
              backgroundColor: Colors.indigoAccent[200],
              expandedHeight: 280,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(200, 100)
                )
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                            child: Text(
                              "TASKS",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                              ),
                            ),
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.work,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>work()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROFILE",
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){
                                print("Profile Clicked");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "TIME",
                            style: TextStyle(
                                color: Colors.lightBlue[800],
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[800],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){
                                print("Time Clicked");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "DISTANCE",
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.cyan[800],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.directions_run,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){
                                print("Distance Clicked");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "ATTENDANCE",
                            style: TextStyle(
                                color: Colors.deepPurple[600],
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[700],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.assignment_turned_in,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){
                                print("Attendance Clicked");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROGRESS",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROGRESS",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROGRESS",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROGRESS",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[50],
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey[600],
                      ),
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                          child: Text(
                            "PROGRESS",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
              end: Alignment.center,
            colors: <Color>[
              Color(0xFF1E88E5),
              Color(0xFFb3E5FC),
            ]
          ),
        ),
      ),
    );
  }
}

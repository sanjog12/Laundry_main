/* Home page of the pick and drop worker */


import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:laundry/pick_drop_ui/pages/works.dart';


class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {     // widget drawer for side menu
  Widget buildSideMenu(){
    return Container(
        color: Colors.white,
        width: 260,
        child: Drawer(
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 280,
                width: 200,
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 118,
                        height:118,
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
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Person Name\nJob - Id",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey[50],
                              fontFamily: "OpenSans",
                              letterSpacing: 1.0
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent[200],
                  ),
                ),
              ),
             CustomListTile(Icons.person,"Profile",()=>{}),
              CustomListTile(Icons.question_answer,"FAQ",()=>{}),
              CustomListTile(Icons.description,"Terms & Conditions",()=>{}),
              CustomListTile(Icons.help,"Support",()=>{}),
              CustomListTile(Icons.lock,"Logout",()=>{}),
            ],
          ),
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[200],
        elevation: 8,
        title: Text(
          "HOME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans",
                  letterSpacing: 1.0,
              ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: buildSideMenu(),
      body: GridView.count(
          crossAxisSpacing: 8,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
          ListGrid(Icons.work,"TASK",0xFF1A237E),
            ListGrid(Icons.directions_run,"DISTANCE",0xFF1565C0),
            ListGrid(Icons.access_time,"TIME",0xFF0277BD),
            ListGrid(Icons.assignment_turned_in,"ATTENDANCE",0xFF00838F),
            ListGrid(Icons.history,"HISTORY",0xFF512DA8),
    ],
      ),
    );
}
  }
  class ListGrid extends StatelessWidget {               //Class for grid display of homepage
  IconData icon;
  String text;
  int color;

  ListGrid(this.icon,this.text,this.color);
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding:EdgeInsets.all(15.0),
        child: Container(
          padding:  EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.blue[50],
            border: Border.all(
              width: 1.5,
              color: Colors.blueGrey[600],
            ),
          ) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.0,15.0,2.0,7.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Color(color),
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      letterSpacing: 0.5
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: IconButton(
                    icon: Icon(
                      icon,
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
      );
    }
  }
  
class CustomListTile extends StatelessWidget {         //Class for items to be displayed in the drawer
  IconData icon;
  String text;
  Function ontap;
  CustomListTile(this.icon,this.text,this.ontap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        child: InkWell(
          splashColor: Colors.blue[50],
          onTap: ontap,
          child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
